//
//  CalculatorModels.swift
//  Opero
//
//  Created by NGUELE Steve  on 27/05/2025.
//

import Foundation


class calculatorModel {
    var operand1: Double
    var operand2: Double
    var theOperator: CalculatorButtons
    var result: Double?
    
    init(operand1: Double, operand2: Double, theOperator: CalculatorButtons) {
        self.operand1 = operand1
        self.operand2 = operand2
        self.theOperator = theOperator
    }
    
    func doTheMath() -> String {
        var resultat: String = ""
        switch theOperator {
        case .multiply:
            result = Double(operand1)*Double(operand2)
            if let result = result {
                resultat = result.truncatingRemainder(dividingBy: 1) == 0 ? String(Int(result)) : String(format: "%.2f", result)
            }
        case .plus:
            result = Double(operand1)+Double(operand2)
            if let result = result {
                resultat = result.truncatingRemainder(dividingBy: 1) == 0 ? String(Int(result)) : String(format: "%.2f", result)
            }
        case .minus:
            result = Double(operand1)-Double(operand2)
            if let result = result {
                resultat = result.truncatingRemainder(dividingBy: 1) == 0 ? String(Int(result)) : String(format: "%.2f", result)
            }
        case .divide:
            //verif necessaire
            if operand2 == 0 {
                return "Error"
            }
            result = Double(operand1)/Double(operand2)
            if let result = result {
                resultat = result.truncatingRemainder(dividingBy: 1) == 0 ? String(Int(result)) : String(format: "%.2f", result)
            }
        default:
            //rien
            break
        }
        result = Double(resultat)
        return resultat
    }
}
