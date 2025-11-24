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
        ZStack {
            if isShowing {
                Rectangle()
                    .opacity(0.3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            isShowing.toggle()
                        }
                    }
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Historique des calculs")
                            .font(.headline)
                            .foregroundStyle(isDarkMode ? .white : .black)
                            .padding()
                        ForEach(historiques, id: \.self) { calcul in
                            if let result = calcul.result {
                                Text("\(calcul.operand1) \(calcul.theOperator) \(calcul.operand2) = \(result))")
                            }
                        }
                        
                        
                        Spacer()
                    }
                    .padding()
                    .background(isDarkMode ? .black : .white)
                    .frame(width: 270, alignment: .leading)
                    
                    Spacer()
                }
            }
        }
    }
}

#Preview {
    HistoryView(isShowing: .constant(true))
}
