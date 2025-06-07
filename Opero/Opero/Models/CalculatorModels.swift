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
    var theOperator: OperatorType?
    var result: Double?
    
    init(operand1: Double, operand2: Double, theOperator: OperatorType) {
        self.operand1 = operand1
        self.operand2 = operand2
        self.theOperator = theOperator
    }
}
