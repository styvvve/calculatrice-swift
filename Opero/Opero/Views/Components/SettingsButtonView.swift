//
//  SettingsButtonView.swift
//  Opero
//
//  Created by NGUELE Steve  on 25/05/2025.
//

import SwiftUI

struct SettingsButtonView: View {
    
    @State private var isRotated: Bool = false
    @State private var haptic: Bool = false
    @Binding var openSettingsView: Bool
    
    
    var body: some View {
        Button {
            isRotated.toggle()
            haptic.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                openSettingsView.toggle()
                print(openSettingsView)
            }
        } label : {
           Image("setting")
                .resizable()
                .scaledToFit()
                .rotationEffect(.degrees(isRotated ? 180 : 0))
                .frame(width: 35, height: 35)
        }
        .animation(.easeInOut(duration: 0.5), value: isRotated)
#if !targetEnvironment(simulator)
            .sensoryFeedback(.impact(weight: .medium, intensity: 1), trigger: haptic)
#endif
    }
}

#Preview {
    SettingsButtonView(openSettingsView: .constant(false))
}
