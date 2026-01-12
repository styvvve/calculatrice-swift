//
//  ContentView.swift
//  Opero
//
//  Created by NGUELE Steve  on 10/01/2026.
//

//use this view like a RootView before the App file

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @AppStorage("DarkMode") private var isDarkMode: Bool = false
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        let repo = SwiftDataCalculatorRepository(context: modelContext)
        let viewModel = CalculatorViewModel(repo: repo)
        
        CalculatorView(viewModel: viewModel)
            .preferredColorScheme(isDarkMode ? .dark : .light)
        
    }
}

#Preview {
    ContentView()
}
