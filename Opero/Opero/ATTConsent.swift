//
//  ATTConsent.swift
//  Opero
//
//  Created by NGUELE Steve  on 11/11/2025.
//

import Foundation
import AppTrackingTransparency
import AdSupport

enum ATTAuthorization {
    static func requestIfNeed() {
        guard ATTrackingManager.trackingAuthorizationStatus == .notDetermined else { return }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            ATTrackingManager.requestTrackingAuthorization() {
                _ in 
            }
        }
    }
}
