//
//  StyledBannerAdView.swift
//  Opero
//
//  Created by NGUELE Steve  on 06/01/2026.
//

import SwiftUI

struct StyledBannerAdView: View {
    
    @State private var availableWidth: CGFloat = 320
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                GeometryReader { geo in
                    BannerAdView(width: geo.size.width)
                        .frame(width: geo.size.width, height: 50, alignment: .center)
                        .background(.ultraThinMaterial)
                        .overlay(Divider(), alignment: .top)
                        .ignoresSafeArea(edges: .bottom)
                        .onAppear {
                            availableWidth = geo.size.width
                        }
                        .onChange(of: geo.size.width) { oldValue, newValue in
                            availableWidth = newValue
                        }
                }
                .frame(height: 50, alignment: .bottom)
            }
            .padding()
        }
    }
}

#Preview {
    StyledBannerAdView()
}
