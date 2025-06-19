//
//  TopBarView.swift
//  Opero
//
//  Created by NGUELE Steve  on 25/05/2025.
//

import SwiftUI

struct TopBarView: View {
    
    @Binding var openMoreView: Bool
    @Binding var openSettingsView: Bool
    
    @AppStorage("DarkMode") private var isDarkMode: Bool = false
    
    var body: some View {
        HStack {
            MoreButtonView(openMoreView: $openMoreView)
            Spacer()
            SettingsButtonView(openSettingsView: $openSettingsView)
        }
        .padding()
    }
}

#Preview {
    TopBarView(openMoreView: .constant(false), openSettingsView: .constant(false))
}
