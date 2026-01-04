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
                    TopBarView(openSettingsView: $openSettingsView, sideBarView: $showDrawer)
                    
                    Spacer()
                    
                    
                    KeyboardView()
                    
                    BannerAdView(width: (geo.size.width*50)/100)
                        .frame(width: (geo.size.width*50)/100, height: 50, alignment: .center)
                        .background(.ultraThinMaterial)
                        .padding(.top)
                }
                .preferredColorScheme(isDarkMode ? .dark : .light)
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
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
