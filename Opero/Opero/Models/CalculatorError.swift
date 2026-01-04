//
//  CalculatorError.swift
//  Opero
//
//  Created by NGUELE Steve  on 20/12/2025.
//

import Foundation

enum CalculateError: Error, Equatable, LocalizedError {
    case divisionByZero
    case invalidInput
    case overflow
    
    var errorDescription: String? {
        switch self {
        case .divisionByZero:
            return "Error"
        case .invalidInput:
            return "Error"
        case .overflow:
            return "Overflow"
        }
    }
}
