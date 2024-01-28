//
//  SignInEmailView.swift
//  ConnectDB
//
//  Created by Elijah Elliott on 1/26/24.
//

import SwiftUI

struct SignInEmailView: View {
    @StateObject private var viewModel = SignInEmailViewModel()
    @StateObject private var authViewModel = AuthenticationViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        VStack {
            TextField("Email...", text: $viewModel.email)
                .padding()
                .background(Color.gray.opacity(0.4)
                .cornerRadius(10))
            
            SecureField("Password...", text: $viewModel.password)
                .padding()
                .background(Color.gray.opacity(0.4)
                .cornerRadius(10))
            Button {
                Task {
                    do {
                        try await viewModel.signUp()
                       
                        showSignInView = false
                        return
                    } catch {
                        print(error)
                    }
                    do {
                        try await viewModel.signIn()
                        showSignInView = false
                        return
                    } catch {
                        print(error)
                    }
                }
                
            } label: {
                Text("Sign in")
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
        .navigationTitle("Sign in With Email")
    }
}

#Preview {
    SignInEmailView(showSignInView: .constant(false))
}
