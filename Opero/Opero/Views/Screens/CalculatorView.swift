//
//  CalculatorView.swift
//  Opero
//
//  Created by NGUELE Steve  on 04/01/2026.
//

import SwiftUI

struct CalculatorView: View {
    
    @StateObject private var viewModel: CalculatorViewModel
    
    init(viewModel: CalculatorViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    let buttons: [[CalculatorButtons]] = [
            [.clear, .erase, .percent, .divide],
            [.seven, .eight, .nine, .multiply],
            [.four, .five, .six, .minus],
            [.one, .two, .three, .plus],
            [.zero, .doubleZero, .decimal, .equal]
        ]
    
    @State private var haptic: Bool = false
    
    @AppStorage("DarkMode") private var isDarkMode: Bool = false
    
    var body: some View {
        VStack(spacing: 12) {
            
            HStack {
                //le calcul d'avant
                Spacer()
                Text(viewModel.getCurrentExpression)
                    .bold()
                    .foregroundStyle(isDarkMode ? .white : .black)
                    .font(.system(size: 25))
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
    }
    
    private func buttonWidth(item: CalculatorButtons) -> CGFloat {
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
    
    private func buttonHeight(item: CalculatorButtons) -> CGFloat {
        return (UIScreen.main.bounds.width - (5 * 12)) / 4
    }
}

#Preview {
    let mock = MockCalculatorRepository()
    CalculatorView(viewModel: CalculatorViewModel(repo: mock))
}
