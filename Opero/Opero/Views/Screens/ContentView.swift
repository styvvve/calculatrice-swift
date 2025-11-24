//
//  ContentView.swift
//  Opero
//
//  Created by NGUELE Steve  on 25/05/2025.
//

import SwiftUI

struct ContentView: View {
    
    @State var openMoreView: Bool = false
    @State var openSettingsView: Bool = false
    
    @AppStorage("DarkMode") private var isDarkMode: Bool = false
    
    var body: some View {
        GeometryReader { geo in
            ZStack {
                VStack {
                    BannerAdView(width: geo.size.width)
                        .frame(width: geo.size.width, height: 50, alignment: .center)
                        .background(.ultraThinMaterial)
                        .padding(.bottom)
                    TopBarView(openSettingsView: $openSettingsView, sideBarView: $openMoreView)
                    
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
        }
    }
}

#Preview {
    ContentView()
}
