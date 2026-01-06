//
//  SwiftDataTest.swift
//  OperoTests
//
//  Created by NGUELE Steve  on 06/01/2026.
//

import Testing
@testable import Opero

struct SwiftDataTest {
    
    @Test
    func equal_shouldSaveOperation() async {
        let repo = MockCalculatorRepository()
        let vm = CalculatorViewModel(repo: repo)
        
        vm.input(.two)
        vm.input(.plus)
        vm.input(.three)
        vm.input(.equal)
        
        #expect(repo.savedOperations.count == 1)
        #expect(repo.savedOperations.first?.result == 5)
    }
}
