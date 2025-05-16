//
//  Data.swift
//  Calculatrice
//
//  Created by NGUELE Steve  on 16/05/2025.
//

import Foundation

//on utilise UserDefaults pour la persistance de données

//MARK: l'historique des calculs
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

//MARK: l'historique des conversions de devises



//MARK: Les preferences de l'utilisateur


