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
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea(edges: .all)
            VStack {
                TopBarView(openMoreView: $openMoreView, openSettingsView: $openSettingsView)
                
                Spacer()
                
                
                KeyboardView()
            }
        }
        .fullScreenCover(isPresented: $openSettingsView) {
            SettingsView()
        }
    }
}

#Preview {
    ContentView()
}
