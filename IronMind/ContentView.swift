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
                    .sheet(isPresented: $resultado) {
                        ResultsView(
                            pesoCorporal: Double(pesoCorporal) ?? 0,
                            pressBanca: Double(pressBanca) ?? -1,
                            sentadillaLibre: Double(sentadillaLibre) ?? -1,
                            pesoMuerto: Double(pesoMuerto) ?? -1,
                            isMale: seleccionGenero == "Hombre"
                        )
                    }
                    .tabItem {
                        Label("Calculadora", systemImage: "dumbbell")
                    }
                    
                    TableView(isMale: seleccionGenero == "Hombre")
                        .tabItem {
                            Label("Tabla", systemImage: "tablecells")
                        }
                    
                    InformationView()
                        .tabItem {
                            Label("Información", systemImage: "info.circle")
                        }
                    
                    ProfileView()
                        .tabItem {
                            Label("Yo", systemImage: "person")
                        }
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

struct TableView: View {
    let isMale: Bool
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Tablas de Fuerza")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom)
                    
                    Group {
                        Text("1. Press de Banca – \(isMale ? "Hombres" : "Mujeres")")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("Principiante: \(isMale ? "0.50 – 0.99" : "0.30 – 0.59") (Peso corporal)")
                        Text("Intermedio: \(isMale ? "1.00 – 1.39" : "0.60 – 0.89") (Peso corporal)")
                        Text("Avanzado: \(isMale ? "1.40 – 1.79" : "0.90 – 1.19") (Peso corporal)")
                        Text("Élite: \(isMale ? "1.80 o más" : "1.20 o más") (Peso corporal)")
                    }
                    
                    Divider()
                    
                    Group {
                        Text("2. Sentadilla – \(isMale ? "Hombres" : "Mujeres")")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("Principiante: \(isMale ? "0.80 – 1.29" : "0.50 – 0.99") (Peso corporal)")
                        Text("Intermedio: \(isMale ? "1.30 – 1.79" : "1.00 – 1.39") (Peso corporal)")
                        Text("Avanzado: \(isMale ? "1.80 – 2.29" : "1.40 – 1.89") (Peso corporal)")
                        Text("Élite: \(isMale ? "2.30 o más" : "1.90 o más") (Peso corporal)")
                    }
                    
                    Divider()
                    
                    Group {
                        Text("3. Peso Muerto – \(isMale ? "Hombres" : "Mujeres")")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("Principiante: \(isMale ? "1.00 – 1.49" : "0.60 – 1.09") (Peso corporal)")
                        Text("Intermedio: \(isMale ? "1.50 – 1.99" : "1.10 – 1.49") (Peso corporal)")
                        Text("Avanzado: \(isMale ? "2.00 – 2.49" : "1.50 – 1.99") (Peso corporal)")
                        Text("Élite: \(isMale ? "2.50 o más" : "2.00 o más") (Peso corporal)")
                    }
                }
                .padding()
            }
            .navigationTitle("Tabla")
        }
    }
}

struct InformationView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("¿De dónde provienen las tablas de fuerza relativas al peso corporal?")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom)
                    
                    Text("Las tablas que categorizan la fuerza (en niveles como principiante, intermedio, avanzado y élite) con base en el peso corporal y el peso levantado se construyen a partir de estudios estadísticos, bases de datos poblacionales, literatura académica y análisis biomecánicos. Las fuentes principales para este tipo de estándares incluyen plataformas reconocidas internacionalmente y organizaciones profesionales en el ámbito del entrenamiento de fuerza.")
                    
                    Group {
                        Text("1. Strength Level")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("Descripción: Strength Level es una plataforma web ampliamente utilizada que recopila datos de levantamientos ingresados por usuarios de todo el mundo y los compara con bases de datos de estándares reconocidos.")
                        Text("Sus tablas muestran cuánto peso levanta en promedio una persona, según su sexo, peso corporal y nivel de experiencia.")
                        Text("Se calcula el resultado como un multiplicador del peso corporal (por ejemplo, levantar 100 kg con un peso de 58 kg → 1.72x).")
                        Text("URL:")
                        Text("🔗 https://strengthlevel.com/strength-standards")
                            .foregroundColor(.blue)
                        Text("Cita recomendada:")
                        Text("Strength Level. “Strength Standards by Weight and Gender.” StrengthLevel.com. Consultado en junio de 2025.")
                    }
                    
                    Divider()
                    
                    Group {
                        Text("2. ExRx.net (Exercise Prescription on the Net)")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("Descripción: ExRx.net es un sitio educativo usado por profesionales del ejercicio y fisioterapia. Proporciona herramientas, gráficos, y estándares de fuerza basados en literatura académica, contribuciones de expertos, y publicaciones como NSCA Essentials.")
                        Text("Sus tablas muestran rangos de fuerza divididos por edad, sexo y masa corporal, utilizando promedios tomados de estudios de población y estándares atléticos.")
                        Text("URL:")
                        Text("🔗 https://exrx.net/Testing/WeightLifting/StrengthStandards")
                            .foregroundColor(.blue)
                        Text("Cita recomendada:")
                        Text("ExRx.net. “Weight Training Standards.” Exercise Prescription on the Net, 2025.")
                    }
                    
                    Divider()
                    
                    Group {
                        Text("3. NSCA (National Strength and Conditioning Association)")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("Descripción: La NSCA es la entidad más reconocida a nivel médico y científico en entrenamiento de fuerza. Sus estándares están respaldados por investigaciones clínicas y son utilizados en universidades, clínicas deportivas y federaciones.")
                        Text("Aunque no publica tablas tan directas como Strength Level, establece guías en sus manuales oficiales como Essentials of Strength Training and Conditioning.")
                        Text("URL oficial:")
                        Text("🔗 https://www.nsca.com")
                            .foregroundColor(.blue)
                        Text("Publicación principal:")
                        Text("Haff, G. Gregory & Triplett, Travis (Eds.). Essentials of Strength Training and Conditioning. 4th ed., Human Kinetics, 2016.")
                        Text("Cita recomendada:")
                        Text("National Strength and Conditioning Association (NSCA). “Essentials of Strength Training and Conditioning.” Human Kinetics, 2016.")
                    }
                    
                    Divider()
                    
                    Group {
                        Text("4. Rogue Fitness (The Index Blog)")
                            .font(.title2)
                            .fontWeight(.bold)
                        Text("Descripción: Aunque no es una fuente académica, Rogue Fitness es una empresa líder en equipamiento para fuerza y publica artículos útiles sobre estándares de rendimiento en deportes de fuerza. Sus guías están basadas en experiencias de atletas, entrenadores y competencias como powerlifting o CrossFit.")
                        Text("URL:")
                        Text("🔗 https://www.roguefitness.com/theindex/training")
                            .foregroundColor(.blue)
                        Text("Cita recomendada:")
                        Text("Rogue Fitness. “Training Articles.” The Index, 2025.")
                    }
                    
                    Divider()
                    
                    Text("¿Cómo se usan estas tablas?")
                        .font(.title2)
                        .fontWeight(.bold)
                    Text("Las tablas clasifican el rendimiento de una persona en ejercicios como press de banca, sentadilla, peso muerto y otros, al comparar el peso levantado con su propio peso corporal. Este enfoque es útil porque:")
                    Text("• Permite comparar personas de diferentes tamaños de manera justa.")
                    Text("• Ayuda a establecer metas de entrenamiento realistas y progresivas.")
                    Text("• Facilita la programación de entrenamientos de fuerza según el nivel.")
                    
                    Divider()
                    
                    Text("Resumen gráfico")
                        .font(.title2)
                        .fontWeight(.bold)
                    Grid(alignment: .leading, horizontalSpacing: 10, verticalSpacing: 10) {
                        GridRow {
                            Text("Fuente").fontWeight(.bold)
                            Text("Tipo").fontWeight(.bold)
                            Text("Confiabilidad Médica").fontWeight(.bold)
                            Text("URL").fontWeight(.bold)
                        }
                        Divider()
                        GridRow {
                            Text("Strength Level")
                            Text("Plataforma pública")
                            Text("Media (estadística)")
                            Text("strengthlevel.com")
                                .foregroundColor(.blue)
                        }
                        GridRow {
                            Text("ExRx.net")
                            Text("Educativa")
                            Text("Alta")
                            Text("exrx.net")
                                .foregroundColor(.blue)
                        }
                        GridRow {
                            Text("NSCA")
                            Text("Profesional médica")
                            Text("Muy alta")
                            Text("nsca.com")
                                .foregroundColor(.blue)
                        }
                        GridRow {
                            Text("Rogue Fitness")
                            Text("Comercial")
                            Text("Baja (no académica)")
                            Text("roguefitness.com")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                }
                .padding()
            }
            .navigationTitle("Información")
        }
    }
}

struct ProfileView: View {
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    // No action needed for now
                }) {
                    Text("Regresar")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .navigationTitle("Yo")
        }
    }
}

struct ResultsView: View {
    let pesoCorporal: Double
    let pressBanca: Double
    let sentadillaLibre: Double
    let pesoMuerto: Double
    let isMale: Bool
    
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
                    .background(Color.blue)
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
