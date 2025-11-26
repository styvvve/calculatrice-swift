//
//  ContentView.swift
//  Opero
//
//  Created by NGUELE Steve  on 25/05/2025.
//

import SwiftUI

struct ContentView: View {
    
    @State var openSettingsView: Bool = false
    
    @AppStorage("DarkMode") private var isDarkMode: Bool = false
    
    //pour la sideView
    @State private var showDrawer = false
    
    @GestureState private var dragOffset = CGSize.zero
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack {
                    BannerAdView(width: geo.size.width)
                        .frame(width: geo.size.width, height: 50, alignment: .center)
                        .background(.ultraThinMaterial)
                        .padding(.bottom)
                    TopBarView(openSettingsView: $openSettingsView, sideBarView: $showDrawer)
                    
                    Spacer()
                    
                    
                    KeyboardView()
                }
                .preferredColorScheme(isDarkMode ? .dark : .light)
                
                /*HistoryView(isShowing: $openMoreView)
                    .offset(x: openMoreView ? 0 : -300)
                    .animation(.easeInOut(duration: 0.3), value: openMoreView)
                    .gesture(
                        DragGesture()
                            .onEnded { value in
                                if value.translation.width < -50 {
                                    withAnimation {
                                        openMoreView.toggle()
                                    }
                                }
                            }
                    ) */
            }
            .fullScreenCover(isPresented: $openSettingsView) {
                SettingsView()
            }
            .overlay {
                ZStack {
                    if showDrawer {
                        Color.black.opacity(0.3)
                            .background(VisualEffectView(effect: UIBlurEffect(style: .dark)))
                            .ignoresSafeArea()
                            .onTapGesture {
                                withAnimation {
                                    showDrawer = false
                                }
                            }
                    }
                    
                    //historiques
                    HStack(spacing: 0) {
                        HistoryView()
                            .frame(width: 250)
                            .offset(x: showDrawer ? 0 : -300)
                            .animation(.easeInOut(duration: 0.3), value: showDrawer)
                        Spacer()
                    }
                    .ignoresSafeArea()
                }
            }.animation(.easeInOut, value: showDrawer)
            .gesture(
                 DragGesture()
                    .onEnded { value in
                        if value.startLocation.x < 20 && value.translation.width > 100 {
                            withAnimation {
                                showDrawer = true
                            }
                        }
                    }
            )
        }
    }
}

#Preview {
    ContentView()
}
