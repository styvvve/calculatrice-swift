//
//  CGPointExtensions.swift
//  Calculatrice
//
//  Created by NGUELE Steve  on 18/05/2025.
//

import Foundation
import SwiftUI

extension CGPoint {
    func vector(to point: CGPoint) -> CGVector {
        CGVector(dx: point.x - self.x, dy: point.y - self.y)
    }
}

extension CGVector {
    var length: CGFloat {
        sqrt(dx * dx + dy * dy)
    }
    
    var normalized: CGVector {
        var len = length
        return len == 0 ? .zero : CGVector(dx: dx / len, dy: dy / len)
    }
    
    func scaled(by scale: CGFloat) -> CGVector {
        CGVector(dx: dx * scale, dy: dy * scale)
    }
    
    func toPoint() -> CGPoint {
        CGPoint(x: dx, y: dy)
    }
}

extension CGFloat {
    var normalized: CGFloat {
        if self == 0 { return 0 }
        return self / abs(self)
    }
}
