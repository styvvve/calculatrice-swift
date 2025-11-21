//
//  TestWithBannerView.swift
//  Opero
//
//  Created by NGUELE Steve  on 21/11/2025.
//

import SwiftUI

struct TestWithBannerView: View {
    
    @State private var availableWidth: CGFloat = 320
    
    var body: some View {
        VStack {
            GeometryReader { geo in
                BannerAdView(width: geo.size.width)
                    .frame(width: geo.size.width, height: 50, alignment: .center)
                    .background(.ultraThinMaterial)
            }
        }
        .padding()
    }
}

#Preview {
    TestWithBannerView()
}
