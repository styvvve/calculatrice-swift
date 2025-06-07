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
    
    //pour l'affichage
    @State var previousOperand1: String? = nil
    @State var previousOperand2: String? = nil
    @State var previousOperator: OperatorType? = nil
    @State var previousResult: String? = nil
    
    @State var saisieActuelle: String = "0"
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea(edges: .all)
            VStack {
                TopBarView(openMoreView: $openMoreView, openSettingsView: $openSettingsView)
                
                Spacer()
                
                DisplayCalculationView(previousOperand1: $previousOperand1, previousOperand2: $previousOperand2, previousOperator: $previousOperator, previousResult: $previousResult, saisieActuelle: $saisieActuelle)
                //KeyboardView(saisieActuelle: $saisieActuelle)
                    .frame(height: 400)
            }
        }
    }
}

#Preview {
    ContentView()
}
