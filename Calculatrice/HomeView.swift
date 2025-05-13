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
    
    
    //operateur choisi
    @State private var choosenOperator: CalculatorButtons?
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                VStack {
                    HStack {
                        Button {
                            
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
                        Spacer()
                        Button {
                            
                        } label: {
                            Image(systemName: "gear")
                                .font(.system(size: 24))
                        }
                        .foregroundStyle(.black)
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
                                Text(newArray[0])
                                    .bold()
                                    .font(.system(size: 25))
                                if let theOperator = choosenOperator {
                                    Text(theOperator.rawValue)
                                        .bold()
                                        .font(.system(size: 25))
                                        .foregroundStyle(.red)
                                }
                                //s il ya un deuxieme operateur
                                if newArray.indices.contains(1) {
                                    Text(newArray[1])
                                        .bold()
                                        .font(.system(size: 25))
                                }
                                if saisiePrecedente.last == "=" || newArray.count == 3 {
                                    Text("=")
                                        .bold()
                                        .font(.system(size: 25))
                                        .foregroundStyle(.red)
                                }
                                if newArray.indices.contains(2) {
                                    Text(newArray[2])
                                        .bold()
                                        .font(.system(size: 25))
                                }
                            }
                        }
                        HStack {
                            Spacer()
                            Text(saisie)
                                .bold()
                                .font(.system(size: 75))
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
        }
        if saisie == "0" || saisie == "00" || saisie == resultat {
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
            saisie = "0"
        } else if column == .percent {
            percent()
        } else if column.isOperator {
            choosenOperator = column
            if operateur1 == nil {
                operateur1 = saisie
                saisie = "0"
                saisiePrecedente = (operateur1 ?? "") + (choosenOperator?.rawValue ?? "")
            } else if operateur1 != nil && operateur2 != nil && resultatPrecedent != nil {
                operateur1 = resultatPrecedent
                saisie = "0"
                operateur2 = saisie
                saisiePrecedente = (operateur1 ?? "") + (choosenOperator?.rawValue ?? "")
            }
        } else if column == .equal {
            if operateur1 != nil && choosenOperator != nil {
                operateur2 = saisie
                saisiePrecedente += (operateur2 ?? "") + "="
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
}

#Preview {
    HomeView()
}
