//
//  CalculatorView.swift
//  Opero
//
//  Created by NGUELE Steve  on 04/01/2026.
//

import SwiftUI

struct CalculatorView: View {
    
    @State var viewModel: CalculatorViewModel
    
    let buttons: [[CalculatorButtons]] = [
            [.clear, .erase, .percent, .divide],
            [.seven, .eight, .nine, .multiply],
            [.four, .five, .six, .minus],
            [.one, .two, .three, .plus],
            [.zero, .doubleZero, .decimal, .equal]
        ]
    
    @State private var haptic: Bool = false
    
    @AppStorage("DarkMode") private var isDarkMode: Bool = false
    
    @State var openSettingsView: Bool = false
    @State private var openHistoryView = false
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                VStack {
                    HStack(spacing: 12) {
                        Spacer()
                        Button {
                            openHistoryView.toggle()
                        } label: {
                            Image(systemName: "clock.arrow.circlepath")
                                .font(.system(size: 35, weight: .light))
                        }
                        .buttonStyle(PlainButtonStyle())
                        SettingsButtonView(openSettingsView: $openSettingsView)
                    }
                    .padding()
                    
                    Spacer()
                    
                    HStack {
                        //le calcul d'avant
                        Spacer()
                        if viewModel.currentExpression.isEmpty {
                            Text("0") //to be sure the space isn't recalculated
                                .bold()
                                .foregroundStyle(isDarkMode ? .white : .black)
                                .font(.system(size: 25))
                        } else {
                            Text(viewModel.currentExpression)
                                .bold()
                                .foregroundStyle(isDarkMode ? .white : .black)
                                .font(.system(size: 25))
                        }
                    }
                    .padding(.horizontal)
                    
                    //Display
                    HStack {
                        Spacer()
                        Text(viewModel.display)
                            .bold()
                            .foregroundStyle(isDarkMode ? .white : .black)
                            .font(viewModel.display.count > 7 ? .system(size: 60) : .system(size: 75))
                    }
                    .padding()
                    
                    //Buttons
                    ForEach(buttons, id: \.self) { row in
                        HStack {
                            ForEach(row, id: \.self) { column in
                                Button {
                                    haptic.toggle()
                                    viewModel.input(column)
                                }label: {
                                    RoundedRectangle(cornerRadius: 15)
                                        .fill(column.getColor(darkMode: isDarkMode))
                                        .frame(width: self.buttonWidth(item: column), height: self.buttonHeight(item: column))
                                        .overlay(
                                            Text(column.rawValue)
                                                .foregroundStyle(isDarkMode ? .black : .white)
                                                .bold()
                                                .font(.title)
                                        )
                                }
        #if !targetEnvironment(simulator)
                                .sensoryFeedback(.impact(weight: .medium, intensity: 1), trigger: haptic)
        #endif
                            }
                        }
                    }
                }
                StyledBannerAdView()
                    .padding(.vertical)
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
        .onAppear {
            viewModel.loadHistory()
        }
        .fullScreenCover(isPresented: $openSettingsView) {
            SettingsView(viewModel: viewModel)
        }
        .sheet(isPresented: $openHistoryView) {
            HistoryView()
        }
    }
    
    private func buttonWidth(item: CalculatorButtons) -> CGFloat {
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
    
    private func buttonHeight(item: CalculatorButtons) -> CGFloat {
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
}

#Preview {
    CalculatorView(viewModel: CalculatorViewModel(repo: PreviewCalculatorRepository()))
}
