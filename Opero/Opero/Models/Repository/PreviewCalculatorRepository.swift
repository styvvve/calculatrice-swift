//
//  PreviewCalculatorRepository.swift
//  Opero
//
//  Created by NGUELE Steve  on 06/01/2026.
//

import Foundation

final class PreviewCalculatorRepository: CalculatorRepositoryProtocol {
    
    func save(_ operation: CalculatorModel) {}
    
    func fetchAll() -> [CalculatorModel] {
        [ CalculatorModel(operand1: 2, operand2: 3, operation: "+", result: 5)]
    }
    
    func delete(_ operation: CalculatorModel) {}
    
    func deleteAll() {}
}
