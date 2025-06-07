//
//  Buttons.swift
//  Opero
//
//  Created by NGUELE Steve  on 27/05/2025.
//

import Foundation
import SwiftUI

enum CalculatorButtons: String {
    case zero = "0"
    case doubleZero = "00"
    case decimal = "."
    case equal = "="
    case one = "1"
    case two = "2"
    case three = "3"
    case plus = "+"
    case four = "4"
    case five = "5"
    case six = "6"
    case minus = "-"
    case seven = "7"
    case eight = "8"
    case nine = "9"
    case multiply = "x"
    case clear = "C"
    case erase = "⌫"
    case percent = "%"
    case divide = "/"
    
    var getColor: Color {
        switch self {
        case .clear: return .red
        case .erase: return .red.opacity(0.5)
        case .percent, .divide, .multiply, .minus, .plus, .equal: return .gray
        default: return .black
        }
    }
    
    var isOperator: Bool {
        switch self {
        case .divide, .multiply, .minus, .plus: return true
        default: return false
        }
    }
    
    var isNumber: Bool {
        switch self {
        case .doubleZero, .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine: return true
        default: return false
        }
    }
}
