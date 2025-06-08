import SwiftUI

struct ContentView: View {
    @State private var pesoCorporal: String = ""
    @State private var pressBanca: String = ""
    @State private var sentadillaLibre: String = ""
    @State private var pesoMuerto: String = ""
    @State private var resultado: Bool = false
    @State private var seleccionGenero: String? = nil
    
    var body: some View {
        NavigationView {
            if seleccionGenero == nil {
                VStack(spacing: 20) {
                    Text("Selecciona tu género")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                    
                    Button(action: {
                        seleccionGenero = "Hombre"
                    }) {
                        Text("Hombre")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .font(.title)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                    
                    Button(action: {
                        seleccionGenero = "Mujer"
                    }) {
                        Text("Mujer")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .font(.title)
                            .cornerRadius(10)
                    }
                    .padding(.horizontal)
                }
                .navigationTitle("IronMind")
            } else {
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
                .sheet(isPresented: $resultado) {
                    ResultsView(
                        pesoCorporal: Double(pesoCorporal) ?? 0,
                        pressBanca: Double(pressBanca) ?? -1,
                        sentadillaLibre: Double(sentadillaLibre) ?? -1,
                        pesoMuerto: Double(pesoMuerto) ?? -1,
                        isMale: seleccionGenero == "Hombre"
                    )
                }
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
    let isMale: Bool // New parameter for gender
    
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
                    levels: isMale ? [
                        (0.5...0.99, "Principiante"),
                        (1.0...1.39, "Intermedio"),
                        (1.40...1.79, "Avanzado"),
                        (1.80...Double.infinity, "Elite")
                    ] : [
                        (0.30...0.59, "Principiante"),
                        (0.60...0.89, "Intermedio"),
                        (0.90...1.19, "Avanzado"),
                        (1.20...Double.infinity, "Élite")
                    ]
                )
            }
            
            if sentadillaLibre >= 0 {
                ExerciseResultView(
                    exercise: "Sentadilla Libre",
                    ratio: sentadillaLibre / pesoCorporal,
                    levels: isMale ? [
                        (0.8...1.29, "Principiante"),
                        (1.30...1.79, "Intermedio"),
                        (1.80...2.29, "Avanzado"),
                        (2.30...Double.infinity, "Elite")
                    ] : [
                        (0.50...0.99, "Principiante"),
                        (1.00...1.39, "Intermedio"),
                        (1.40...1.89, "Avanzado"),
                        (1.90...Double.infinity, "Élite")
                    ]
                )
            }
            
            if pesoMuerto >= 0 {
                ExerciseResultView(
                    exercise: "Peso Muerto",
                    ratio: pesoMuerto / pesoCorporal,
                    levels: isMale ? [
                        (1.0...1.49, "Principiante"),
                        (1.5...1.99, "Intermedio"),
                        (2.0...2.49, "Avanzado"),
                        (2.5...Double.infinity, "Elite")
                    ] : [
                        (0.60...1.09, "Principiante"),
                        (1.10...1.49, "Intermedio"),
                        (1.50...1.99, "Avanzado"),
                        (2.00...Double.infinity, "Élite")
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
