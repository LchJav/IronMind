import SwiftUI

struct SeleccionView: View {
    @State private var seleccionGenero: String? = nil
    
    var body: some View {
        NavigationStack {
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
                ContentView(seleccionGenero: seleccionGenero)
            }
        }
        .navigationDestination(isPresented: Binding(
            get: { seleccionGenero != nil },
            set: { if !$0 { seleccionGenero = nil } }
        )) {
            ContentView(seleccionGenero: seleccionGenero)
        }
    }
}

struct SeleccionView_Previews: PreviewProvider {
    static var previews: some View {
        SeleccionView()
    }
}
