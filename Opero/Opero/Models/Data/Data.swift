//
//  Data.swift
//  Opero
//
//  Created by NGUELE Steve  on 11/06/2025.
//

//on utilise UserDefaults pour la persistance de données

//MARK: l'historique des calculs
import Foundation
import SwiftUI 

func saveCalcHistory(_ history: [String]) {
    UserDefaults.standard.set(history, forKey: "calcHistory")
}

func loadCalcHistory() -> [String] {
    return UserDefaults.standard.stringArray(forKey: "calcHistory") ?? []
}

func clearCalcHistory() {
    UserDefaults.standard.removeObject(forKey: "calcHistory")
}

//limiter la taille de l'historique
func limitTheSizeOfCalcHistory() {
    var history = loadCalcHistory()
    if history.count > 30 {
        history.removeFirst()
    }
    saveCalcHistory(history)
}
