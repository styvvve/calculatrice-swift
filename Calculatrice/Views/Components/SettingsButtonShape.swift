//
//  SettingsButtonShape.swift
//  Calculatrice
//
//  Created by NGUELE Steve  on 18/05/2025.
//

import SwiftUI

struct SettingsButtonShape: View {
    
    @State private var rotation: Double = 0
    @Binding var width: CGFloat
    @Binding var height: CGFloat
    
    var body: some View {
        VStack {
            
        }
    }
}

struct SettingsShape: Shape {
    var cornerRadius: CGFloat
    
    func path(in rect: CGRect) -> Path {
        let sides = 6
        let center = CGPoint(x: rect.midX, y: rect.midY)
        var path = Path()
        let radius = min(rect.width, rect.height) / 2
        
        let angle = Double.pi * 2 / Double(sides)
        
        //point pour l'hexagone
        var points: [CGPoint] = []
        for i in 0..<sides {
            let theta = angle * Double(i) - Double.pi / 2
            let point = CGPoint(
                x: center.x + CGFloat(cos(theta)) * radius,
                y: center.y + CGFloat(sin(theta)) * radius
            )
            points.append(point)
        }
        
        //dessin
        for i in 0..<sides {
            let prev = points[(i - 1 + sides) % sides]
            let current = points[i]
            let next = points[(i + 1) % sides]
            
            let startVec = current.vector(to: prev).normalized.scaled(by: cornerRadius).toPoint()
            let endVec = current.vector(to: next).normalized.scaled(by: cornerRadius).toPoint()
            
            let start = CGPoint(x: current.x + startVec.x, y: current.y + startVec.y)
            let end = CGPoint(x: current.x + endVec.x, y: current.y + endVec.y)
            if i == 0 {
                path.move(to: start)
            } else {
                path.addLine(to: start)
            }
            
            path.addQuadCurve(to: end, control: current)
        }
        
        path.closeSubpath()
        return path
    }
}

#Preview {
    SettingsButtonShape(width: .constant(200), height: .constant(200))
}
