//
//  TopBarView.swift
//  Opero
//
//  Created by NGUELE Steve  on 25/05/2025.
//

import SwiftUI

struct TopBarView: View {
    
    @Binding var openSettingsView: Bool
    @Binding var sideBarView: Bool
    
    @AppStorage("DarkMode") private var isDarkMode: Bool = false
    
    var body: some View {
        HStack {
            MoreButtonView(openMoreView: $sideBarView)
            Spacer()
            SettingsButtonView(openSettingsView: $openSettingsView)
        }
        .padding()
    }
}

#Preview {
    TopBarView(openSettingsView: .constant(false), sideBarView: .constant(false))
}
