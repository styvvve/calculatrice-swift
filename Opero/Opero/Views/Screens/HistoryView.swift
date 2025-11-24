//
//  HistoryView.swift
//  Opero
//
//  Created by NGUELE Steve  on 18/06/2025.
//

import SwiftUI
import SwiftData

struct HistoryView: View {
    
    @Environment(\.modelContext) private var context
    
    @Query private var historiques: [CalculatorModel]
    @AppStorage("DarkMode") private var isDarkMode: Bool = false
    
    @Binding var isShowing: Bool
    
    
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            Text("Historique des calculs")
                .font(.headline)
                .foregroundStyle(isDarkMode ? .white : .black)
                .padding()
            
            VStack(alignment: .leading, spacing: 10) {
                ForEach(historiques, id: \.self) { calcul in
                    if let result = calcul.result {
                        Text("\(calcul.operand1) \(calcul.theOperator) \(calcul.operand2) = \(result))")
                    }
                }
            }
            .padding()
            
            
            Spacer()
            
            VStack(alignment: .leading, spacing: 6) {
                Divider()
                Text("v1.2.0")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

#Preview {
    HistoryView(isShowing: .constant(true))
}
