//
//  InfoPersonalView.swift
//  IronMind
//
//  Created by Lenin Chacón on 12/6/25.
//

import SwiftUI

struct InfoPersonalView: View {
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

struct InfoPersonalView_Previews: PreviewProvider {
    static var previews: some View {
        InfoPersonalView()
    }
}
