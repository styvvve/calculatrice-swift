//
//  Double+Formatting.swift
//  Opero
//
//  Created by NGUELE Steve  on 06/01/2026.
//

import Foundation

extension Double {
    func formattedWithoutTrailingZero() -> String {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 6
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: self)) ?? "0"
    }
}
