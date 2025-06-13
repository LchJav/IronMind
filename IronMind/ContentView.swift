import SwiftUI

struct ContentView: View {
    @State private var pesoCorporal: String = ""
    @State private var pressBanca: String = ""
    @State private var sentadillaLibre: String = ""
    @State private var pesoMuerto: String = ""
    @State private var resultado: Bool = false
    let seleccionGenero: String?
    
    var body: some View {
        TabView {
            Form {
                Section(header: Text("Datos del Usuario")) {
                    TextField("Peso Corporal (Kg)", text: $pesoCorporal)
                        .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Pesos Levantados (kg)")) {
                    TextField("Press de Banca", text: $pressBanca)
                        .keyboardType(.decimalPad)
                    TextField("Sentadilla Libre", text: $sentadillaLibre)
                        .keyboardType(.decimalPad)
                    TextField("Peso Muerto", text: $pesoMuerto)
                        .keyboardType(.decimalPad)
                }
                
                Button(action: {
                    resultado = true
                }) {
                    Text("Calcular Nivel")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .disabled(!esEntradaValida())
            }
            .navigationTitle("IronMind")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                }
            }
            .sheet(isPresented: $resultado) {
                ResultsView(
                    pesoCorporal: Double(pesoCorporal.replacingOccurrences(of: ",", with: ".")) ?? 0,
                    pressBanca: Double(pressBanca.replacingOccurrences(of: ",", with: ".")) ?? -1,
                    sentadillaLibre: Double(sentadillaLibre.replacingOccurrences(of: ",", with: ".")) ?? -1,
                    pesoMuerto: Double(pesoMuerto.replacingOccurrences(of: ",", with: ".")) ?? -1,
                    isMale: seleccionGenero == "Hombre"
                )
            }
            .tabItem {
                Label("Calculadora", systemImage: "dumbbell")
            }
            
            TablaView(isMale: seleccionGenero == "Hombre")
                .tabItem {
                    Label("Tabla", systemImage: "tablecells")
                }
            
            InformacionView()
                .tabItem {
                    Label("Información", systemImage: "info.circle")
                }
            
            InfoPersonalView()
                .tabItem {
                    Label("Yo", systemImage: "person")
                }
        }
    }
    
    private func esEntradaValida() -> Bool {
        guard let pesoCorporal = Double(pesoCorporal.replacingOccurrences(of: ",", with: ".")) else {
            return false
        }
        let pressBanca = Double(pressBanca.replacingOccurrences(of: ",", with: ".")) ?? -1
        let sentadillaLibre = Double(sentadillaLibre.replacingOccurrences(of: ",", with: ".")) ?? -1
        let pesoMuerto = Double(pesoMuerto.replacingOccurrences(of: ",", with: ".")) ?? -1
        
        return pesoCorporal > 0 && (pressBanca >= 0 || sentadillaLibre >= 0 || pesoMuerto >= 0)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(seleccionGenero: "Hombre")
    }
}
