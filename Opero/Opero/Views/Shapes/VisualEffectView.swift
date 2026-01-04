//
//  VisualEffectView.swift
//  Opero
//
//  Created by NGUELE Steve  on 26/11/2025.
//

import Foundation
import UIKit
import SwiftUI


//pour donner des effets de blur aux vues
struct VisualEffectView: UIViewRepresentable {
    var effect: UIVisualEffect?
    typealias UIViewType = UIVisualEffectView
    
    func makeUIView(context: Context) -> UIVisualEffectView {
            return UIVisualEffectView()
        }
        
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
            uiView.effect = effect
    }
        
}
