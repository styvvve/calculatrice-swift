//
//  SettingsView.swift
//  Opero
//
//  Created by NGUELE Steve  on 13/06/2025.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    
    @Environment(\.dismiss) var dismiss
    
    //tous les parametres changeables
    @AppStorage("DarkMode") private var isDarkMode: Bool = false
    
    
    //historique de calculs
    @Environment(\.modelContext) private var context
    @Query var calcHistory: [CalculatorModel]
    
    
    @State private var adviceBeforeDelete: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                Toggle("Thème", isOn: $isDarkMode)
                    .padding()
                    .bold()
                
                //effacer l'historique de calculs
                Rectangle()
                    .foregroundStyle(.clear)
                    .frame(height: 10)
                
                Button {
                    adviceBeforeDelete.toggle()
                } label: {
                    Text("Effacer l'historique de calculs")
                        .padding()
                        .bold()
                        .foregroundStyle(.white)
                        .background(Color.red)
                        .clipShape(Capsule())
                }
                
                Spacer()
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
            .navigationTitle(Text("Paramètres"))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(isDarkMode ? .white : .black)
                    }
                }
            }
            .alert("Supprimer l'historique de calculs" ,isPresented: $adviceBeforeDelete) {
                Button("Annuler", role: .cancel) { }
                Button("Confirmer", role: .destructive) {
                    for item in calcHistory {
                        context.delete(item)
                    }
                }
            } message: {
                Text("Cette action est irréversible.")
            }
        }
    }
}

#Preview {
    SettingsView()
}
