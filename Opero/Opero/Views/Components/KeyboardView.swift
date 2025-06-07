//
//  KeyboardView.swift
//  Opero
//
//  Created by NGUELE Steve  on 27/05/2025.
//

import SwiftUI

struct KeyboardView: View {
    
    //calcul precedent
    @Binding var previousOperand1: String?
    @Binding var previousOperand2: String?
    @Binding var previousResult: String?
    
    //calcul actuel
    @Binding  var operand1: String?
    @Binding  var operand2: String?
    @Binding  var result: String?
    
    @Binding var currentOperation: OperatorType?
    
    @State private var haptic: Bool = false
    @Binding var saisieActuelle: String
    
    //comment les boutons seront classer
    @State private var clavier: [[CalculatorButtons]] = [
            [.clear, .erase, .percent, .divide],
            [.seven, .eight, .nine, .multiply],
            [.four, .five, .six, .minus],
            [.one, .two, .three, .plus],
            [.zero, .doubleZero, .decimal, .equal]
        ]
    
    var body: some View {
        GeometryReader { geo in
            //boutons
            let spacing: CGFloat = 5
            let buttonWidth = (geo.size.width - spacing * 5) / 4
    
            VStack {
                
                VStack {
                    HStack {
                        //le calcul d'avant
                        Spacer()
                        if let previousOperator1 = previousOperand1 {
                            Text(previousOperator1)
                                .bold()
                                .foregroundStyle(.black)
                                .font(.system(size: 25))
                        }
                        
                        if let currentOperation = currentOperation {
                            Text(currentOperation.rawValue)
                                .bold()
                                .font(.system(size: 25))
                                .foregroundStyle(.red)
                        }
                        
                        if let previousOperator2 = previousOperand2 {
                            Text(previousOperator2)
                                .bold()
                                .foregroundStyle(.black)
                                .font(.system(size: 25))
                            Text(CalculatorButtons.equal.rawValue)
                                .bold()
                                .font(.system(size: 25))
                                .foregroundStyle(.red)
                        }
                        
                        if let previousResult = previousResult {
                            Text(previousResult)
                                .bold()
                                .foregroundStyle(.black)
                                .font(.system(size: 25))
                        }
                    }
                    
                    
                    //le calcul present
                    HStack {
                        Spacer()
                        Text(saisieActuelle)
                            .bold()
                            .font(saisieActuelle.count > 7 ? .system(size: 60) : .system(size: 75))
                    }
                    .onChange(of: saisieActuelle) {
                        if saisieActuelle.isEmpty {
                            saisieActuelle = "0"
                        }
                    }
                }
                
                ForEach(clavier, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { column in
                            Button {
                                haptic.toggle()
                                //work(column)
                            }label: {
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(column.getColor)
                                    .frame(width: buttonWidth, height: 75)
                                    .overlay(
                                        Text(column.rawValue)
                                            .foregroundStyle(.white)
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
        }
        .ignoresSafeArea()
        .padding(.horizontal)
    }
    
    //une grosse fonction qui va se charger de tout
    
    
    func write(_ button: CalculatorButtons) {
        if saisieActuelle.count < 8 {
            if saisieActuelle == "0" || saisieActuelle == "00" {
                saisieActuelle = button.rawValue
            } else {
                saisieActuelle += button.rawValue
            }
        }
    }
}

#Preview {
    KeyboardView(previousOperand1: .constant("2"), previousOperand2: .constant("4"), previousResult: .constant("6"), operand1: .constant(nil), operand2: .constant(nil), result: .constant(nil), currentOperation: .constant(.add), saisieActuelle: .constant("0"))
}
