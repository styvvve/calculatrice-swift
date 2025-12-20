//
//  KeyboardView.swift
//  Opero
//
//  Created by NGUELE Steve  on 27/05/2025.
//

import SwiftUI
import SwiftData

struct KeyboardView: View {
    
    //calcul precedent
    @State private var previousOperand1: String? = nil
    @State private var previousOperand2: String? = nil
    @State private var previousResult: String? = nil
    
    //calcul actuel
    @State private var op1: String? = nil
    @State private var op2: String? = nil
    @State private var result: String? = nil
    
    @State private var currentOperation: CalculatorButtons?
    
    @State private var haptic: Bool = false
    
    @State private var saisieActuelle: String = "0"
    
    @AppStorage("DarkMode") private var isDarkMode: Bool = false

    
    //comment les boutons seront classer
    @State private var clavier: [[CalculatorButtons]] = [
            [.clear, .erase, .percent, .divide],
            [.seven, .eight, .nine, .multiply],
            [.four, .five, .six, .minus],
            [.one, .two, .three, .plus],
            [.zero, .doubleZero, .decimal, .equal]
        ]
    
    //Swiftdata
    @Environment(\.modelContext) private var context
    @Query private var operations: [CalculatorModel]
    
    var body: some View {
            VStack {
                
                VStack {
                    HStack {
                        //le calcul d'avant
                        Spacer()
                        if let op1 = op1 {
                            Text(op1)
                                .bold()
                                .foregroundStyle(isDarkMode ? .white : .black)
                                .font(.system(size: 25))
                        }
                        
                        if let currentOperation = currentOperation {
                            Text(currentOperation.rawValue)
                                .bold()
                                .font(.system(size: 25))
                                .foregroundStyle(.red)
                        }
                        
                        if let op2 = op2 {
                            Text(op2)
                                .bold()
                                .foregroundStyle(isDarkMode ? .white : .black)
                                .font(.system(size: 25))
                            Text(CalculatorButtons.equal.rawValue)
                                .bold()
                                .font(.system(size: 25))
                                .foregroundStyle(.red)
                        }
                        
                        /*if let result = result {
                            Text(result)
                                .bold()
                                .foregroundStyle(isDarkMode ? .white : .black)
                                .font(.system(size: 25))
                        }*/
                    }
                    
                    
                    //le calcul present
                    HStack {
                        Spacer()
                        Text(saisieActuelle)
                            .bold()
                            .foregroundStyle(isDarkMode ? .white : .black)
                            .font(saisieActuelle.count > 7 ? .system(size: 60) : .system(size: 75))
                    }
                }
                
                ForEach(clavier, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { column in
                            Button {
                                haptic.toggle()
                            }label: {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(column.getColor(darkMode: isDarkMode))
                                    .frame(width: self.buttonWidth(item: column), height: self.buttonHeight(item: column))
                                    .overlay(
                                        Text(column.rawValue)
                                            .foregroundStyle(isDarkMode ? .black : .white)
                                            .bold()
                                            .font(.title)
                                    )
                            }
                #if !targetEnvironment(simulator)
                            .sensoryFeedback(.impact(weight: .medium, intensity: 1), trigger: haptic)
                #endif
                        }
                    }
                }
            }
        .onChange(of: saisieActuelle) {
            if saisieActuelle.isEmpty {
                saisieActuelle = "0"
            }
        }
        .ignoresSafeArea()
        .padding(.horizontal)
    }
    
    private func buttonWidth(item: CalculatorButtons) -> CGFloat {
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
    
    private func buttonHeight(item: CalculatorButtons) -> CGFloat {
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
    
}

#Preview {
    KeyboardView()
}
