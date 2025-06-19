//
//  KeyboardView.swift
//  Opero
//
//  Created by NGUELE Steve  on 27/05/2025.
//

import SwiftUI

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
                        
                        if let result = result {
                            Text(result)
                                .bold()
                                .foregroundStyle(isDarkMode ? .white : .black)
                                .font(.system(size: 25))
                        }
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
                                work(column)
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
    
    //une grosse fonction qui va se charger de tout
    func work(_ button: CalculatorButtons) {
        if button.isNumber {
            if saisieActuelle == result {
                //sauvegarde de l'ancien resultat
                previousOperand1 = op1!
                previousOperand2 = op2!
                previousResult = result!
                currentOperation = nil
                op1 = nil
                op2 = nil
                result = nil
                saisieActuelle = "0"
            }
            write(button)
        } else if button.isOperator {
            if op1 == nil {
                op1 = saisieActuelle
                currentOperation = button
                previousOperand1 = op1!
                saisieActuelle = "0"
            } else if let operand1 = Double(op1 ?? ""),
                      let operand2 = Double(saisieActuelle),
                      let operation = currentOperation, result == nil {
                
                //on fait le premier calcul
                let newOperation = CalculatorModel(operand1: operand1, operand2: operand2, theOperator: operation.rawValue)
                result = newOperation.doTheMath()
                
                //sauvegarde
                context.insert(newOperation)
                
                //sauvegarde du calcul precedent
                previousOperand1 = String(operand1)
                previousOperand2 = String(operand2)
                previousResult = result!
                
                op1 = result
                result = nil
                currentOperation = button
                saisieActuelle = "0"
                op2 = nil
            } else if op1 != nil, let result = result {
                //soit le resultat sera l'op1
                op1 = result
                op2 = nil
                currentOperation = button
                saisieActuelle = "0"
            }
            result = nil
        } else if button == .erase {
            if !saisieActuelle.isEmpty {
                saisieActuelle.removeLast()
                if saisieActuelle.isEmpty {
                    saisieActuelle = "0"
                }
            }
        } else if button == .clear {
            if saisieActuelle != "0" {
                saisieActuelle = "0"
                op1 = nil
                op2 = nil
                currentOperation = nil
                if let result = result {
                    previousResult = result
                }
                result = nil
            }
        } else if button == .percent {
            percent()
        } else if button == .equal {
            if let operand1 = Double(op1 ?? ""),
               let operation = currentOperation, result == nil {
                op2 = saisieActuelle
                
                //creation d'une nouvelle instance de calcul
                if let operand2 = Double(op2 ?? "") {
                    let newOperation = CalculatorModel(operand1: operand1, operand2: operand2, theOperator: operation.rawValue)
                    result = newOperation.doTheMath()
                    saisieActuelle = (result ?? "0")
                    
                    //sauvegarde
                    context.insert(newOperation)
                }
            } else if let resultat = Double(result ?? ""), var operand1 = Double(op1 ?? ""), let operand2 = Double(op2 ?? ""), let operation = currentOperation {
                operand1 = resultat
                op1 = result
                
                let newOperation = CalculatorModel(operand1: operand1, operand2: operand2, theOperator: operation.rawValue)
                result = newOperation.doTheMath()
                
                //sauvegarde
                context.insert(newOperation)
                saisieActuelle = (result ?? "0")
            }
        } else if button == .decimal {
            if !saisieActuelle.contains(".") {
                saisieActuelle.append(".")
            }
        }
    }
    
    func write(_ button: CalculatorButtons) {
        if saisieActuelle.count < 8 {
            if saisieActuelle == "0" || saisieActuelle == "00" {
                saisieActuelle = button.rawValue
            } else {
                saisieActuelle += button.rawValue
            }
        }
    }
    
    func percent() -> Void {
            if saisieActuelle != "0" {
                if var nombre = Double(saisieActuelle) {
                    nombre /= 100
                    saisieActuelle = String(nombre)
                }
            }
        }
}

#Preview {
    KeyboardView()
}
