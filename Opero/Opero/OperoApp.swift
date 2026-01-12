//
//  OperoApp.swift
//  Opero
//
//  Created by NGUELE Steve  on 25/05/2025.
//

import SwiftUI
import SwiftData
import GoogleMobileAds
import RevenueCat

@main
struct OperoApp: App {
    
    @AppStorage("haptics") private var areHapticsActivated: Bool = true
    
    let container: ModelContainer
    let revenueCatAPI = ProcessInfo.processInfo.environment["REVENUECATAPI"]!
    init() {
        Purchases.logLevel = .debug
        Purchases.configure(withAPIKey: revenueCatAPI)
        
        do {
            container = try ModelContainer(
                for: CalculatorModel.self,
                configurations: ModelConfiguration(isStoredInMemoryOnly: true)
            )
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    var body: some Scene {
        WindowGroup {
            //CalculatorView(viewModel: CalculatorViewModel(repo: SwiftDataCalculatorRepository(context: context)))
                //.preferredColorScheme(isDarkMode ? .dark : .light)
            ContentView()
        }
        .modelContainer(container)
    }
}
