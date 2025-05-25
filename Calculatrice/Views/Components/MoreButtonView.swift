//
//  MoreButtonView.swift
//  Calculatrice
//
//  Created by NGUELE Steve  on 18/05/2025.
//

import SwiftUI

struct MoreButtonView: View {
    
    @Binding var haptic: Bool
    @Binding var openMoreView: Bool
    
    var body: some View {
        VStack {
            Button {
                haptic.toggle()
                openMoreView.toggle()
            } label: {
                VStack(alignment: .leading, spacing: 5) {
                    RoundedRectangle(cornerRadius: 30)
                        .frame(width: 30, height: 4)
                        .foregroundStyle(.black)
                    RoundedRectangle(cornerRadius: 30)
                        .frame(width: 15, height: 4)
                        .foregroundStyle(.black)
                    RoundedRectangle(cornerRadius: 30)
                        .frame(width: 30, height: 4)
                        .foregroundStyle(.black)
                }
            }
            #if !targetEnvironment(simulator)
            .sensoryFeedback(.impact(weight: .medium, intensity: 1), trigger: haptic)
            #endif
        }
    }
}

#Preview {
    MoreButtonView(haptic: .constant(false), openMoreView: .constant(false))
}
