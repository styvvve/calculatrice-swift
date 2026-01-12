//
//  HistoryView.swift
//  Opero
//
//  Created by NGUELE Steve  on 06/01/2026.
//

import SwiftUI
import SwiftData

struct HistoryView: View {
    
    @Query(sort: \CalculatorModel.date, order: .reverse) var operations: [CalculatorModel]
    
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
    HistoryView()
}
