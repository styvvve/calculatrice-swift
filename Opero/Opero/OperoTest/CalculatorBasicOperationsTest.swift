//
//  CalculatorBasicOperationsTest.swift
//  Opero
//
//  Created by NGUELE Steve  on 04/01/2026.
//

import Testing
@testable import Opero

struct CalculatorBasicOperationsTest {
    
    @Test
    func inputNumbers_shouldBuildDisplay() async {
        let mock = MockCalculatorRepository()
        let vm = CalculatorViewModel(repo: mock)
        
        vm.input(.one)
        vm.input(.two)
        
        #expect(vm.display == "12")
    }
    
    @Test
    func addition_shouldReturnCorrectResult() async {
        let mock = MockCalculatorRepository()
        let vm = CalculatorViewModel(repo: mock)
        
        vm.input(.two)
        vm.input(.plus)
        vm.input(.three)
        vm.input(.equal)
        
        #expect(vm.display == "5")
    }
    
    @Test
    func chainedOperations_shouldReusePreviousResult() async {
        let mock = MockCalculatorRepository()
        let vm = CalculatorViewModel(repo: mock)
        
        vm.input(.two)
        vm.input(.plus)
        vm.input(.three)
        vm.input(.multiply)
        vm.input(.four)
        vm.input(CalculatorButtons.equal)
        
        #expect(vm.display == "20")
    }
    
    @Test
    func divisionByZero_shouldDisplayError() async {
        let mock = MockCalculatorRepository()
        let vm = CalculatorViewModel(repo: mock)
        
        vm.input(.eight)
        vm.input(.divide)
        vm.input(.zero)
        vm.input(.equal)
        
        #expect(vm.display.contains("Error"))
    }
    
    @Test
    func percent_shouldDisplayBy100() async {
        let mock = MockCalculatorRepository()
        let vm = CalculatorViewModel(repo: mock)
        
        vm.input(.five)
        vm.input(.zero)
        vm.input(.percent)
        
        #expect(vm.display == "0.5")
    }

}
