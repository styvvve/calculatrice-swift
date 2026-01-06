//
//  CalculatorViewModel.swift
//  Opero
//
//  Created by NGUELE Steve  on 18/12/2025.
//

import Foundation

//stocke toute la logique métier de la calculatrice

/*
 -le nbre affiché
 -les opérandes
 -l'opérateur courant
 -l'égalité
 -le pourcentage
 -l'effacement / reset
 */

final class CalculatorViewModel: ObservableObject {
    
    // MARK: - Output (UI)
    @Published var display: String = "0"
    
    // MARK: - ERRORS
    @Published var errors: String?
    
    //MARK: - Internal state soit "logique métier"
    private var operand1: Double?
    private var operand2: Double?
    private var previousOperand1: Double?
    private var previousOperand2: Double?
    private var currentOperation: CalculatorButtons?
    private var result: Double?
    
    private let maxDigits: Int = 8
    
    private var state: CalculatorState = .enteringFirstNumber
    
    //MARK: - Persistence
    private let repo: CalculatorRepositoryProtocol
    @Published private(set) var history: [CalculatorModel] = []
    
    init(repo: CalculatorRepositoryProtocol) {
        self.repo = repo
    }
    
    func input(_ button: CalculatorButtons) {
        switch button {
        case .clear:
            clear()
            state = .enteringFirstNumber
        case .erase:
            erase()
        case .percent:
            percent()
        case .equal:
            equal()
            state = .showingResult
        case .decimal:
            decimal()
        default:
            numberOrOperator(button)
        }
    }
    
    private func numberOrOperator(_ button: CalculatorButtons) {
        if button.isNumber {
            writeNumber(button.rawValue)
        }else if button.isOperator {
            handleOperator(button)
        }
    }
    
    private func writeNumber(_ number: String) {
        guard display.count < maxDigits else { return }
        
        if display == "0" {
            display = number
        } else {
            display += number
        }
        
        updateState()
    }
    
    private func handleOperator(_ button: CalculatorButtons) {
        let currentValue = Double(display) ?? 0
        
        if operand1 == nil {
            operand1 = currentValue
            currentOperation = button
            display = "0"
            state = .enteringSecondNumber
            return
        }
        
        if let op1 = operand1,
           let operation = currentOperation {
            operand2 = currentValue
            do {
                result = try compute(op1, operand2!, operation)
                previousOperand1 = operand1
                operand1 = result
                display = "0"
                currentOperation = button
            } catch {
                display = error.localizedDescription
            }
        }
    }
    
    //calcul pur
    private func compute(_ a: Double, _ b: Double, _ operation: CalculatorButtons) throws -> Double {
        switch operation {
        case .plus:
            return a + b
        case .minus:
            return a - b
        case .multiply:
            return a * b
        case .divide:
            //verification necessaire
            guard b != 0 else {
                throw CalculateError.divisionByZero
            }
            return a / b
        default:
            throw CalculateError.invalidInput
        }
    }
    
    private func equal() {
        guard let op1 = operand1,
              let operation = currentOperation else { return }
        
        operand2 = Double(display) ?? 0
        do {
            let value = try compute(op1, operand2!, operation)
            display = format(value)
            errors = nil
            
            result = value
            previousOperand1 = operand1 //this for the previous display
            operand1 = result
            
            //save the operation
            let newOperation = CalculatorModel(operand1: op1, operand2: (operand2 ?? 0), operation: operation.rawValue, result: (result ?? 0))
            repo.save(newOperation)
        } catch {
            display = error.localizedDescription
        }
    }
    
    private func decimal() {
        if !display.contains(".") {
            display += "."
        }
    }
    
    private func percent() {
        if let value = Double(display) {
            display = format(value/100)
        }
    }
    
    private func erase() {
        guard display.count > 1 else {
            display = "0"
            return
        }
        
        display.removeLast()
    }
    
    private func clear() {
        display = "0"
        operand1 = nil
        operand2 = nil
        currentOperation = nil
        result = nil
    }
    
    //format propre pour l'affichage
    private func format(_ value: Double) -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 6
        formatter.minimumFractionDigits = 0
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: value)) ?? "0"
    }
    
    //getters
    var currentExpression: String {
        switch state {
        case .enteringFirstNumber:
            return ""
        case .enteringSecondNumber:
            return "\(format(operand1 ?? 0)) \(currentOperation?.rawValue ?? "")"
        case .showingResult:
            return "\(format(previousOperand1 ?? 0)) \(currentOperation?.rawValue ?? "") \(format(operand2 ?? 0)) = \(format(result ?? 0))"
        }
    }
    
    private func updateState() {
        switch state {
        case .enteringFirstNumber:
            break
        case .enteringSecondNumber:
            break
        case .showingResult:
            state = CalculatorState.enteringFirstNumber
            clear()
        }
    }
    
    func loadHistory() {
        history = repo.fetchAll()
    }
}
