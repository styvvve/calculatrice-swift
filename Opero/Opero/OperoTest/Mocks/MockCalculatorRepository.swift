//
//  MockCalculatorRepository.swift
//  Opero
//
//  Created by NGUELE Steve  on 06/01/2026.
//

import Foundation

final class MockCalculatorRepository: CalculatorRepositoryProtocol {
    
    private(set) var savedOperations: [CalculatorModel] = [] //read access only private(set) -> public reading, private writing
    
    func save(_ operation: CalculatorModel) {
        savedOperations.append(operation)
    }
    
    func fetchAll() -> [CalculatorModel] {
        []
    }
    
    func delete(_ operation: CalculatorModel) {}
    
    func deleteAll() {}
}
