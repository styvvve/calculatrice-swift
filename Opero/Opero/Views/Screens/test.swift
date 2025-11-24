import SwiftUI

struct TestView: View {
    @State private var isMenuOpen: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                // Main content
                MainView(toggleMenu: { withAnimation(.interactiveSpring()) { isMenuOpen.toggle() } })

                // Sidebar container
                SidebarContainer(isOpen: $isMenuOpen) {
                    // Contenu du menu (personnalisable)
                    VStack(alignment: .leading, spacing: 20) {
                        HStack {
                            Image(systemName: "person.crop.circle")
                                .font(.largeTitle)
                            VStack(alignment: .leading) {
                                Text("Opero")
                                    .font(.headline)
                                Text("Mon application")
                                    .font(.caption)
                            }
                        }
                        .padding(.top, 40)

                        Divider()

                        Button(action: { /* Navigate */ }) {
                            Label("Accueil", systemImage: "house")
                        }

                        Button(action: { /* Navigate */ }) {
                            Label("Paramètres", systemImage: "gearshape")
                        }

                        Button(action: { /* Logout */ }) {
                            Label("Se déconnecter", systemImage: "arrow.right.square")
                        }

                        Spacer()
                    }
                    .padding(.horizontal, 20)
                    .foregroundColor(.primary)
                } // SidebarContainer
            } // ZStack
            .navigationBarHidden(true)
        } // NavigationView
        .navigationViewStyle(StackNavigationViewStyle())
    }
}

// -----------------------------
// MainView: ton contenu principal avec bouton hamburger
// -----------------------------
struct MainView: View {
    var toggleMenu: () -> Void

    var body: some View {
        VStack {
            HStack {
                Button(action: toggleMenu) {
                    Image(systemName: "line.horizontal.3")
                        .font(.title2)
                        .padding(8)
                        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 8))
                }
                .accessibilityLabel("Ouvrir le menu")
                .accessibilityAddTraits(.isButton)

                Spacer()
            }
            .padding()

            Spacer()

            Text("Contenu principal — Opero")
                .font(.largeTitle)
                .bold()

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(UIColor.systemBackground))
    }
}

// -----------------------------
// SidebarContainer: gère l'overlay, le positionnement, gestures
// -----------------------------
struct SidebarContainer<MenuContent: View>: View {
    @Binding var isOpen: Bool
    let menuContent: () -> MenuContent

    // Drag tracking while gesture is active
    @GestureState private var dragOffset: CGFloat = 0

    init(isOpen: Binding<Bool>, @ViewBuilder menuContent: @escaping () -> MenuContent) {
        self._isOpen = isOpen
        self.menuContent = menuContent
    }

    var body: some View {
        GeometryReader { geo in
            // Calculate width: responsive, max 80% of screen or 320 pts
            let menuWidth = min(geo.size.width * 0.8, 320.0)
            let closedOffset = -menuWidth
            let openOffset: CGFloat = 0

            // totalOffset is dynamic: depends on state and drag gesture
            let totalOffset = (isOpen ? openOffset : closedOffset) + dragOffset

            ZStack(alignment: .leading) {
                // Dimmed overlay (captures taps to close)
                if isOpen || dragOffset != 0 {
                    Color.black
                        .opacity(opacityForOverlay(menuWidth: menuWidth, currentOffset: totalOffset))
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.interactiveSpring()) {
                                isOpen = false
                            }
                        }
                        // Allow overlay to capture taps but not gestures propagation
                        .accessibilityHidden(true)
                }

                // Menu panel
                VStack {
                    menuContent()
                }
                .frame(width: menuWidth, height: geo.size.height)
                .background(VisualEffectBlur(blurStyle: .systemMaterial)) // nice glass effect
                .offset(x: totalOffset)
                .shadow(color: Color.black.opacity(0.25), radius: 8, x: 4, y: 0)
                .accessibilityElement(children: .contain)
                .accessibility(addTraits: .isModal)
                .accessibilityLabel("Menu latéral")
            }
            // highPriorityGesture ensures the drag is recognized before default scrolling, etc.
            .gesture(
                DragGesture()
                    .updating($dragOffset) { value, state, _ in
                        // Only horizontal drags matter; clamp to menu width range
                        let translation = value.translation.width
                        // If menu is closed, we only want to respond to rightward drags (opening gesture)
                        if isOpen {
                            state = max(translation, -menuWidth) // allow closing drags (left)
                        } else {
                            state = min(max(translation, 0), menuWidth) // allow opening drags (right)
                        }
                    }
                    .onEnded { value in
                        let translation = value.translation.width
                        let threshold = menuWidth * 0.33 // 33% threshold

                        withAnimation(.interactiveSpring()) {
                            if isOpen {
                                // If the user dragged left enough -> close
                                if translation < -threshold { isOpen = false }
                                else { isOpen = true }
                            } else {
                                // If the user dragged right enough -> open
                                if translation > threshold { isOpen = true }
                                else { isOpen = false }
                            }
                        }
                    }
            , including: .gesture)
            // Accessibility: allow swipe to open from the left edge (iOS system behavior may already provide gestures)
            .simultaneousGesture(
                EdgeDragGesture(edge: .leading) {
                    withAnimation(.interactiveSpring()) {
                        isOpen = true
                    }
                }
            )
        } // GeometryReader
        .animation(.interactiveSpring(), value: isOpen)
    }

    // Compute overlay opacity based on how far menu is open
    private func opacityForOverlay(menuWidth: CGFloat, currentOffset: CGFloat) -> Double {
        // currentOffset ranges from -menuWidth (closed) to 0 (open)
        let openProgress = 1 - abs(currentOffset) / menuWidth
        return Double(0.5 * openProgress) // max 0.5 opacity
    }
}

// -----------------------------
// Helper: EdgeDragGesture (detect drag starting from screen edge)
// -----------------------------
struct EdgeDragGesture: Gesture {
    let drag: DragGesture
    let action: () -> Void

    init(edge: Edge, action: @escaping () -> Void) {
        // Start from a small region at the edge (20 pts)
        let startRegion: CGFloat = 20
        self.drag = DragGesture(minimumDistance: 10)
        self.action = action
        self.edge = edge
        self.startRegion = startRegion
    }

    let edge: Edge
    let startRegion: CGFloat

    // We'll implement as a simultaneous gesture checker in a custom view modifier above.
    // For simplicity in this example we'll create a transparent edge area overlay elsewhere if needed.
    var body: some Gesture {
        drag.onEnded { value in
            // do nothing here — this struct is used as a type container only
        }
    }
}

// -----------------------------
// Small UIKit blur wrapper (visual effect) for nicer background
// -----------------------------
struct VisualEffectBlur: UIViewRepresentable {
    var blurStyle: UIBlurEffect.Style

    init(blurStyle: UIBlurEffect.Style = .systemMaterial) {
        self.blurStyle = blurStyle
    }

    func makeUIView(context: Context) -> UIVisualEffectView {
        return UIVisualEffectView(effect: UIBlurEffect(style: blurStyle))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: blurStyle)
    }
}

// -----------------------------
// Preview
// -----------------------------
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
