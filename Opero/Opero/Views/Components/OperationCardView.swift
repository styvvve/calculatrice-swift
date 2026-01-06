//
//  OperationCardView.swift
//  Opero
//
//  Created by NGUELE Steve  on 06/01/2026.
//

import SwiftUI

struct OperationCardView: View {
    
    let operation: CalculatorModel
    
    var body: some View {
        VStack {
            HStack {
                Text(operation.operand1.formattedWithoutTrailingZero())
                Text(operation.operation)
                Text(operation.operand2.formattedWithoutTrailingZero())
                Text("=")
                Text(operation.result.formattedWithoutTrailingZero())
                Spacer()
            }
            .font(.system(size: 20))
            .padding()
            
            Divider()
                .padding(.horizontal)
        }
    }
}

#Preview {
    OperationCardView(operation: CalculatorModel(operand1: 2, operand2: 3, operation: "+", result: 5))
}
