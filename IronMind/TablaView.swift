//
//  TablaView.swift
//  IronMind
//
//  Created by Lenin Chacón on 12/6/25.
//

import SwiftUI

struct TablaView: View {
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

struct TablaView_Previews: PreviewProvider {
    static var previews: some View {
        TablaView(isMale: true)
    }
}
