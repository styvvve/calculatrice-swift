//
//  CalculatorModels.swift
//  Opero
//
//  Created by NGUELE Steve  on 27/05/2025.
//

import Foundation
import SwiftData


@Model
class CalculatorModel {
    var operand1: Double
    var operand2: Double
    var theOperator: String
    var result: Double?
    var date: Date
    
    init(operand1: Double, operand2: Double, theOperator: String) {
        self.operand1 = operand1
        self.operand2 = operand2
        self.theOperator = theOperator
        self.date = Date.now
    }
    
    func doTheMath() -> String {
        var resultat: String = ""
        switch theOperator {
        case "x":
            result = Double(operand1)*Double(operand2)
            if let result = result {
                resultat = result.truncatingRemainder(dividingBy: 1) == 0 ? String(Int(result)) : String(format: "%.2f", result)
            }
        case "+":
            result = Double(operand1)+Double(operand2)
            if let result = result {
                resultat = result.truncatingRemainder(dividingBy: 1) == 0 ? String(Int(result)) : String(format: "%.2f", result)
            }
        case "-":
            result = Double(operand1)-Double(operand2)
            if let result = result {
                resultat = result.truncatingRemainder(dividingBy: 1) == 0 ? String(Int(result)) : String(format: "%.2f", result)
            }
        case "/":
            //verif necessaire
            if operand2 == 0 {
                return "Error"
            }
            result = Double(operand1)/Double(operand2)
            if let result = result {
                resultat = result.truncatingRemainder(dividingBy: 1) == 0 ? String(Int(result)) : String(format: "%.2f", result)
            }
        default: break
        }
        result = Double(resultat)
        return resultat
    }
}
