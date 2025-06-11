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
    
    //calcul precedent
    @State var previousOperand1: String? = nil
    @State var previousOperand2: String? = nil
    @State var previousResult: String? = nil
    
    //calcul actuel
    @State  var operand1: String? = nil
    @State  var operand2: String? = nil
    @State  var result: String? = nil
    
    @State var currentOperation: CalculatorButtons? = nil
    
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea(edges: .all)
            VStack {
                TopBarView(openMoreView: $openMoreView, openSettingsView: $openSettingsView)
                
                Spacer()
                
                
                KeyboardView()
            }
        }
    }
}

#Preview {
    ContentView()
}
