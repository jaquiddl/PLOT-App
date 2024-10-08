//
//  WelcomeView.swift
//  Final-Project
//
//  Created by Jacqueline Diaz de Leon on 08/08/24.
//


import SwiftUI

struct WelcomeView: View {
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                Rectangle()
                    .frame(height: 400)
                    .foregroundStyle(Color.clear)
                
                Title(title: "Welcome to PLOT", alignment: .leading)
                    .padding()
                Text("Connect with fellow book lovers, track your reading journey, and exchange books with your local community.")
                    .font(.body)
                    .foregroundStyle(Color.brandPrimary)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                Spacer()
                NavigationLink (destination: LoginView()) {
                    WelcomeButton(title: "Log in to Plotf",
                                  BGColor: .clear,
                                  FontColor: .brandPrimary)
                    .padding(.bottom, 10)
                }
                
                NavigationLink (destination: SignUpView()) {
                    WelcomeButton(title: "Sign up",
                                  BGColor: .brandPrimary,
                                  FontColor: .white)
                    .padding(.bottom, 25)
                    
                }

                
            }
        }
        
    }
}

#Preview {
    WelcomeView()
}
