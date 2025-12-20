//
//  CalculatorRepository.swift
//  Opero
//
//  Created by NGUELE Steve  on 20/12/2025.
//

import Foundation
import SwiftData

protocol CalculatorRepositoryProtocol {
    func save(_ operation: CalculatorModel)
    func fetchAll() -> [CalculatorModel]
    func delete(_ operation: CalculatorModel)
}
