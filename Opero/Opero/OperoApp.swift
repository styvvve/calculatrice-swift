//
//  OperoApp.swift
//  Opero
//
//  Created by NGUELE Steve  on 25/05/2025.
//

import SwiftUI
import SwiftData
import GoogleMobileAds

@main
struct OperoApp: App {
    
    @AppStorage("DarkMode") private var isDarkMode: Bool = false
    @AppStorage("haptics") private var areHapticsActivated: Bool = true
    
    @Environment(\.modelContext) private var context
    
    var body: some Scene {
        WindowGroup {
            CalculatorView(viewModel: CalculatorViewModel(repo: SwiftDataCalculatorRepository(context: context)))
                .preferredColorScheme(isDarkMode ? .dark : .light)
        }
        .modelContainer(for: CalculatorModel.self)
    }
}
