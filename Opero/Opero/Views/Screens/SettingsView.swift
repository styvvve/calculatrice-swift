//
//  SettingsView.swift
//  Opero
//
//  Created by NGUELE Steve  on 13/06/2025.
//

import SwiftUI
import SwiftData
import WebKit

struct SettingsView: View {
    
    @Environment(\.dismiss) var dismiss
    
    //tous les parametres changeables
    @AppStorage("DarkMode") private var isDarkMode: Bool = false
    @AppStorage("Haptics") private var areHapticsActivated: Bool = true
    
    //affichage de la page web
    @State private var isShowingSheet = false
    
    
    //historique de calculs
    @Environment(\.modelContext) private var context
    @Query var calcHistory: [CalculatorModel]
    
    
    @State private var adviceBeforeDelete: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Toggle("Thème", isOn: $isDarkMode)
                        .padding()
                        .bold()
                    
                    Toggle("Vibrations", isOn: $areHapticsActivated)
                        .padding()
                        .bold()
                    
                    Button {
                        //rechercher ds l'app store
                    } label: {
                        HStack {
                            Text("Restaurer les achats")
                            Spacer()
                            Image(systemName: "arrow.right")
                        }
                        .padding()
                        .foregroundStyle(isDarkMode ? .white : .black)
                        .bold()
                    }
                    
                    Button {
                        isShowingSheet.toggle()
                    } label: {
                        Text("Aller sur la page de l'application")
                        Spacer()
                        Image(systemName: "arrow.right")
                    }
                    .padding()
                    .foregroundStyle(isDarkMode ? .white : .black)
                    .bold()
                    
                    
                    Button {
                        adviceBeforeDelete.toggle()
                    } label: {
                        Text("Effacer l'historique de calculs")
                        Spacer()
                        Image(systemName: "arrow.right")
                    }
                    .padding()
                    .foregroundStyle(isDarkMode ? .white : .black)
                    .bold()
                    
                    Rectangle()
                        .foregroundStyle(.clear)
                        .frame(height: 10)
                    
                    Button {
                        
                    } label: {
                        HStack {
                            Text("Supprimer les pubs : 1,99€")
                                .bold()
                        }
                        .padding()
                        .foregroundStyle(.white)
                        .background(.green)
                        .clipShape(Capsule())
                        
                    }
                    
                    Spacer()
            }
            }
            .sheet(isPresented: $isShowingSheet) {
                VStack {
                    WebViewCompat(url: URL(string: "https://flawless-comma-886.notion.site/Opero-La-calculatrice-nouvelle-g-n-ration-2a0224981367806fbaffd3bbb9da35cb?source=copy_link")!)
                        .toolbar {
                            ToolbarItem(placement: .topBarTrailing) {
                                Button("Fermer") {
                                    isShowingSheet.toggle()
                                }
                                .bold()
                            }
                        }
                }
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
            .navigationTitle(Text("Paramètres"))
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .resizable()
                            .frame(width: 25, height: 25)
                            .foregroundStyle(isDarkMode ? .white : .black)
                    }
                }
            }
            .alert("Supprimer l'historique de calculs" ,isPresented: $adviceBeforeDelete) {
                Button("Annuler", role: .cancel) { }
                Button("Confirmer", role: .destructive) {
                    for item in calcHistory {
                        context.delete(item)
                    }
                }
            } message: {
                Text("Cette action est irréversible.")
            }
        }
    }
}

// MARK: WEBVIEW
struct WebViewCompat: View {
    let url: URL
    
    var body: some View {
        if #available(iOS 26.0, *) {
            WebView(url: url)
        }else {
            LegacyWebView(url: url)
        }
    }
}

@available(iOS, introduced: 13.0, deprecated: 18.0, message: "Use native WebView instead")
struct LegacyWebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }
    
    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

#Preview {
    SettingsView()
}
