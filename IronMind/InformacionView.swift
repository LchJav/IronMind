//
//  InformacionView.swift
//  IronMind
//
//  Created by Lenin Chacón on 12/6/25.
//

import SwiftUI

struct InformacionView: View {
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

struct InformacionView_Previews: PreviewProvider {
    static var previews: some View {
        InformacionView()
    }
}
