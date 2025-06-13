//
//  ResultsView.swift
//  IronMind
//
//  Created by Lenin Chacón on 12/6/25.
//

import SwiftUI

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

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView(pesoCorporal: 70, pressBanca: 50, sentadillaLibre: -1, pesoMuerto: -1, isMale: true)
    }
}
