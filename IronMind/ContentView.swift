import SwiftUI

struct ContentView: View {
    @State private var pesoCorporal: String = ""
    @State private var pressBanca: String = ""
    @State private var sentadillaLibre: String = ""
    @State private var pesoMuerto: String = ""
    @State private var resultado: Bool = false
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Datos del Usuario")) {
                    TextField("Peso Corporal (kg)", text: $pesoCorporal)
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
            .sheet(isPresented: $resultado) {
                ResultsView(
                    pesoCorporal: Double(pesoCorporal) ?? 0,
                    pressBanca: Double(pressBanca) ?? -1,
                    sentadillaLibre: Double(sentadillaLibre) ?? -1,
                    pesoMuerto: Double(pesoMuerto) ?? -1
                )
            }
        }
    }
    
    private func esEntradaValida() -> Bool {
        guard let pesoCorporal = Double(pesoCorporal) else {
            return false
        }
        let pressBanca = Double(pressBanca) ?? -1
        let sentadillaLibre = Double(sentadillaLibre) ?? -1
        let pesoMuerto = Double(pesoMuerto) ?? -1
        
        return pesoCorporal > 0 && (pressBanca >= 0 || sentadillaLibre >= 0 || pesoMuerto >= 0)
    }
}

struct ResultsView: View {
    let pesoCorporal: Double
    let pressBanca: Double
    let sentadillaLibre: Double
    let pesoMuerto: Double
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Resultados")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            if pressBanca >= 0 {
                ExerciseResultView(
                    exercise: "Press de Banca",
                    ratio: pressBanca / pesoCorporal,
                    levels: [
                        (0.5...0.75, "Principiante"),
                        (1.0...1.25, "Intermedio"),
                        (1.5...1.75, "Avanzado"),
                        (2.0...99.9, "Elite")
                    ]
                )
            }
            
            if sentadillaLibre >= 0 {
                ExerciseResultView(
                    exercise: "Sentadilla Libre",
                    ratio: sentadillaLibre / pesoCorporal,
                    levels: [
                        (0.75...1.24, "Principiante"),
                        (1.25...1.74, "Intermedio"),
                        (1.75...2.24, "Avanzado"),
                        (2.25...10.0, "Elite")
                    ]
                )
            }
            
            if pesoMuerto >= 0 {
                ExerciseResultView(
                    exercise: "Peso Muerto",
                    ratio: pesoMuerto / pesoCorporal,
                    levels: [
                        (1.0...1.25, "Principiante"),
                        (1.5...1.75, "Intermedio"),
                        (2.0...2.25, "Avanzado"),
                        (2.5...99.9, "Elite")
                    ]
                )
            }
            
            Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Cerrar")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
        }
        .padding()
    }
    
    @Environment(\.presentationMode) private var presentationMode
}

struct ExerciseResultView: View {
    let exercise: String
    let ratio: Double
    let levels: [(ClosedRange<Double>, String)]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(exercise)
                .font(.title2)
                .fontWeight(.bold)
            Text("Levantaste \(String(format: "%.2f", ratio))x tu peso corporal")
                .font(.title3)
            Text("Nivel: \(calculateLevel())")
                .font(.title3)
                .foregroundColor(.blue)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
    
    private func calculateLevel() -> String {
        for (range, level) in levels {
            if range.contains(ratio) {
                return level
            }
        }
        return "No clasificado"
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
