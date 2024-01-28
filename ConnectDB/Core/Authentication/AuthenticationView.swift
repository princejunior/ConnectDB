//
//  AuthenticationView.swift
//  ConnectDB
//
//  Created by Elijah Elliott on 1/26/24.
//

import SwiftUI

func signInAnonymous() async throws {
    try await AuthenticationManager.shared.signInAnonymous()
}

struct AuthenticationView: View {
    @StateObject private var viewModel = AuthenticationViewModel()
    
    @Binding var showSignInView: Bool
    
    var body: some View {
        VStack {
            Button(action: {
                Task {
                    do {
                        try await viewModel.signInAnonymous()
                        showSignInView = false
                    } catch {
                        print(error)
                    }
                }
            }, label: {
                Text("Sign in Anonymously")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color.blue)
                    .cornerRadius(10)
            })
            NavigationLink {
                SignInEmailView(showSignInView: $showSignInView)
                
            } label: {
                Text("Sign in with Email")
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 55)
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            Spacer()
        }
        .padding()
        .navigationTitle("Sign In")
    }
}

#Preview {
    AuthenticationView(showSignInView: .constant(false))
}
