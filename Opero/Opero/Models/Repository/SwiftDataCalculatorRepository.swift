//
//  SwiftDataCalculatorRepository.swift
//  Opero
//
//  Created by NGUELE Steve  on 04/01/2026.
//

import Foundation
import SwiftData

final class SwiftDataCalculatorRepository: CalculatorRepositoryProtocol {
    
    private let context: ModelContext
    
    init(context: ModelContext) {
        self.context = context
    }
    
    func save(_ operation: CalculatorModel) {
        context.insert(operation)
    }
    
    func fetchAll() -> [CalculatorModel] {
        let descriptor = FetchDescriptor<CalculatorModel>(sortBy: [.init(\.date, order: .reverse)])
        return (try? context.fetch(descriptor)) ?? []
    }
    
    func delete(_ operation: CalculatorModel) {
        context.delete(operation)
    }
    
}
