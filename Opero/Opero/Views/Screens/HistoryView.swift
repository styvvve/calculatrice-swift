//
//  HistoryView.swift
//  Opero
//
//  Created by NGUELE Steve  on 06/01/2026.
//

import SwiftUI

struct HistoryView: View {
    
    let operations: [CalculatorModel]
    
    var body: some View {
        VStack(alignment: .center) {
            Capsule()
                .frame(width: 50, height: 5)
                .padding(.top)
            
            Text("Historique")
                .font(.system(size: 25, weight: .semibold))
                .padding(.top)
            
            ScrollView {
                LazyVStack(spacing: 12) {
                    ForEach(operations, id: \.self) { op in
                        OperationCardView(operation: op)
                    }
                }
            }
            .padding()
        }
    }
}

#Preview {
    HistoryView(operations: [
        CalculatorModel(operand1: 2, operand2: 3, operation: "+", result: 5),
        CalculatorModel(operand1: 2, operand2: 3, operation: "+", result: 5),
        CalculatorModel(operand1: 2, operand2: 3, operation: "+", result: 5),
        CalculatorModel(operand1: 2, operand2: 3, operation: "+", result: 5)
    ])
}
