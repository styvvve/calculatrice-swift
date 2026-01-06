//
//  CalculatorModels.swift
//  Opero
//
//  Created by NGUELE Steve  on 27/05/2025.
//

import Foundation
import SwiftData


@Model
final class CalculatorModel {
    var operand1: Double
    var operand2: Double
    var operation: String
    var result: Double
    var date: Date
    
    init(operand1: Double, operand2: Double, operation: String, result: Double, date: Date = Date.now) {
        self.operand1 = operand1
        self.operand2 = operand2
        self.operation = operation
        self.result = result
        self.date = date
    }
}
