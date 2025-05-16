//
//  ContentView.swift
//  Calculatrice
//
//  Created by NGUELE Steve  on 12/05/2025.
//

import SwiftUI

struct HomeView: View {
    
    @State private var operateur1: String?
    @State private var operateur2: String?
    @State private var resultat: String?
    
    //suavegarde vive
    @State private var resultatPrecedent: String?
    @State private var saisiePrecedente: String = ""
    @State private var saisie: String = "0"
    
    //comment on va classer les boutons
    @State private var clavier: [[CalculatorButtons]] = [
        [.clear, .erase, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .doubleZero, .decimal, .equal]
    ]
    
    //pour les haptics
    @State private var hapticForMore = false
    @State private var hapticForButtons = false
    @State private var hapticForSettings = false
    
    
    //operateur choisi
    @State private var choosenOperator: CalculatorButtons?
    
    //ouvrir les reglages
    @State private var openSettingsView = false
    
    //animation
    @State private var rotateGear = false
    
    
    //mode convertisseur ou non
    @State private var isCurrencyMode: Bool = false
    
    //les historiques
    @State private var calcHistory: [String] = []
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack {
                    HStack {
                        Button {
                            hapticForMore.toggle()
                        }label: {
                            VStack(alignment: .leading, spacing: 5) {
                                RoundedRectangle(cornerRadius: 30)
                                    .frame(width: 30, height: 4)
                                RoundedRectangle(cornerRadius: 30)
                                    .frame(width: 15, height: 4)
                                RoundedRectangle(cornerRadius: 30)
                                    .frame(width: 30, height: 4)
                            }
                        }
                        .foregroundStyle(.black)
                        .sensoryFeedback(.impact(weight: .medium, intensity: 1), trigger: hapticForMore)
                        Spacer()
                        Menu {
                            Button("Réglages") {
                                hapticForSettings.toggle()
                                openSettingsView.toggle()
                            }
                            Button {
                                hapticForSettings.toggle()
                                isCurrencyMode.toggle()
                            } label: {
                                HStack {
                                    Text("Convertisseur de devises")
                                    Spacer()
                                    if isCurrencyMode {
                                        Image(systemName: "checkmark")
                                            .foregroundStyle(.black)
                                    }
                                }
                            }
                        } label: {
                            Image(systemName: "gear")
                                .font(.system(size: 24))
                                .rotationEffect(.degrees(rotateGear ? 30 : 0))
                                .animation(.spring(response: 0.3, dampingFraction: 0.5), value: rotateGear)
                        }
                        .foregroundStyle(.black)
                        .sensoryFeedback(.impact(weight: .medium, intensity: 1), trigger: hapticForSettings)
                        .onTapGesture {
                            withAnimation {
                                rotateGear.toggle()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                    rotateGear = false
                                    //on remet a false apres un certain 2s
                                }
                            }
                        }
                    }
                    Spacer()
                }
                VStack {
                    
                    VStack(alignment: .leading) {
                        //zone d'écriture
                        HStack(spacing: 2) {
                            Spacer()
                            if !saisiePrecedente.isEmpty {
                                let newArray = separators(saisiePrecedente)
                                if let texte = afficherElement(0, dans: newArray) {
                                    texte
                                }
                                if let theOperator = choosenOperator {
                                    Text(theOperator.rawValue)
                                        .bold()
                                        .font(.system(size: 25))
                                        .foregroundStyle(.red)
                                }
                                if let texte = afficherElement(1, dans: newArray) {
                                    texte
                                }
                                if saisiePrecedente.contains("=") {
                                    Text("=")
                                        .bold()
                                        .font(.system(size: 25))
                                        .foregroundStyle(.red)
                                }
                                if let texte = afficherElement(2, dans: newArray) {
                                    texte
                                }
                            }
                        }
                        HStack {
                            Spacer()
                            Text(saisie)
                                .bold()
                                .font(saisie.count > 7 ? .system(size: 60) : .system(size: 75))
                        }
                    }
                    
                    //boutons
                    let spacing: CGFloat = 5
                    let buttonWidth = (geometry.size.width - spacing * 5) / 4
                    
                    VStack {
                        
                        ForEach(clavier, id: \.self) { row in
                            HStack {
                                ForEach(row, id: \.self) { column in
                                    Button {
                                        hapticForButtons.toggle()
                                        work(column)
                                    }label: {
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(column.getColor)
                                            .frame(width: buttonWidth, height: 75)
                                            .overlay(
                                                Text(column.rawValue)
                                                    .foregroundStyle(.white)
                                                    .bold()
                                                    .font(.title)
                                            )
                                    }
                                    .sensoryFeedback(.impact(weight: .medium, intensity: 1), trigger: hapticForButtons)
                                }
                            }
                            .frame(maxWidth: .infinity)
                        }
                    }
                    .ignoresSafeArea()
                }
            }
        }
        .padding()
        .onChange(of: saisie) {
            if saisie.isEmpty {
                saisie = "0"
            }
        }
    }
    
    
    //MARK: functions
    
    private func write(_ button: CalculatorButtons) -> Void {
        //pour le cas ou on a une reponse precedente on l'affiche proprement
        if saisie == resultat {
            resultatPrecedent = resultat
            saisiePrecedente += resultatPrecedent ?? ""
            operateur1 = nil
            operateur2 = nil
            resultat = nil
        }
        if saisie == "0" || saisie == "00" || saisie == resultatPrecedent {
            saisie = button.rawValue
        }else {
            saisie += button.rawValue
        }
    }
    
    private func percent() -> Void {
        if saisie != "0" {
            if var nombre = Double(saisie) {
                nombre /= 100
                saisie = String(nombre)
            }
        }
    }
    
    private func work(_ column: CalculatorButtons) -> Void {
        if column.isNumber && saisie.count < 7 {
            write(column)
        } else if column == .erase && saisie != "0" {
            saisie.removeLast()
        } else if column == .clear {
            if saisie == "0" && !saisiePrecedente.isEmpty {
                calcHistory.append(saisiePrecedente)
                saveCalcHistory(calcHistory)
                saisiePrecedente.removeAll()
                choosenOperator = nil
                resultatPrecedent = resultat
                resultat = nil
            } else {
                if saisie == resultat {
                    resultatPrecedent = resultat
                    saisiePrecedente += resultatPrecedent ?? ""
                    operateur1 = nil
                    operateur2 = nil
                    resultat = nil
                }
                saisie = "0"
            }
        } else if column == .percent {
            percent()
        } else if column.isOperator {
            choosenOperator = column
            if operateur1 == nil && resultat == nil {
                operateur1 = saisie
                saisie = "0"
                saisiePrecedente = (operateur1 ?? "") + (choosenOperator?.rawValue ?? "")
            } else if resultat != nil && operateur1 != nil {
                resultatPrecedent = resultat
                operateur1 = saisie
                saisie = "0"
                operateur2 = nil
                resultat = nil
                saisiePrecedente.removeAll()
                saisiePrecedente = (operateur1 ?? "") + (choosenOperator?.rawValue ?? "")
            }
        } else if column == .equal {
            if operateur1 != nil && choosenOperator != nil && resultat == nil {
                operateur2 = saisie
                saisiePrecedente += (operateur2 ?? "") + "="
                makeOperation()
            } else if let resultat = resultat {
                operateur1 = resultat
                saisiePrecedente = (operateur1 ?? "") + (choosenOperator?.rawValue ?? "") + (operateur2 ?? "") + "="
                makeOperation()
            }
        } else if column == .decimal {
            saisie += "."
        }
    }
    
    private func makeOperation() -> Void {
        switch choosenOperator {
        case .multiply:
            let result = (Double(operateur1 ?? "0") ?? 0)*(Double(operateur2 ?? "0") ?? 0)
            resultat = result.truncatingRemainder(dividingBy: 1) == 0 ? String(Int(result)) : String(format: "%.2f", result)
            saisie = resultat ?? "0"
        case .plus:
            let result = (Double(operateur1 ?? "0") ?? 0)+(Double(operateur2 ?? "0") ?? 0)
            resultat = result.truncatingRemainder(dividingBy: 1) == 0 ? String(Int(result)) : String(format: "%.2f", result)
            saisie = resultat ?? "0"
        case .minus:
            let result = (Double(operateur1 ?? "0") ?? 0)-(Double(operateur2 ?? "0") ?? 0)
            resultat = result.truncatingRemainder(dividingBy: 1) == 0 ? String(Int(result)) : String(format: "%.2f", result)
            saisie = resultat ?? "0"
        case .divide:
            let result = (Double(operateur1 ?? "0") ?? 0)/(Double(operateur2 ?? "0") ?? 0)
            resultat = result.truncatingRemainder(dividingBy: 1) == 0 ? String(Int(result)) : String(format: "%.2f", result)
            saisie = resultat ?? "0"
        default:
            //rien
            break
        }
    }
    //refaire cette fonction pour bien renvoyer
    private func afficherElement(_ index: Int, dans array: [String]) -> Text? {
        if array.indices.contains(index) {
            return Text(array[index])
                .bold()
                .font(.system(size: 25))
                .foregroundStyle(array[index] == "=" ? .red : .black)
        }
        return nil //car c'est optionnel
    }
}

#Preview {
    HomeView()
}
