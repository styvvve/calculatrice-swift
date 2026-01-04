//
//  displayView.swift
//  Opero
//
//  Created by NGUELE Steve  on 04/01/2026.
//

import SwiftUI

struct displayView: View {
    
    @State var saisie: String = "0"
    @AppStorage("DarkMode") private var isDarkMode: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text(saisie)
                    .bold()
                    .foregroundStyle(isDarkMode ? .white : .black)
                    .font(saisie.count > 7 ? .system(size: 60) : .system(size: 75))
            }
        }
    }
}

#Preview {
    displayView()
}
