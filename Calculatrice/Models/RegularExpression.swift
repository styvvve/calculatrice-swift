//
//  RegularExpression.swift
//  Calculatrice
//
//  Created by NGUELE Steve  on 13/05/2025.
//

import Foundation

func separators(_ texte: String) -> [String] {
    let operators = CharacterSet(charactersIn: "+-*/=")
    let parts = texte.components(separatedBy: operators)
    return parts
}
