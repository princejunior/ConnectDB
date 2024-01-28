//
//  SignInEmailViewModel.swift
//  ConnectDB
//
//  Created by Elijah Elliott on 1/27/24.
//

import Foundation
@MainActor
final class SignInEmailViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    func signIn() async throws{
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
        let returnUserData = try await AuthenticationManager.shared.signInUser(email: email, password: password)
//        When task is in use it doesn't need async throws
//        Task {
//            do {
//                let returnUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
//                print("Success")
//                print(returnUserData)
//            } catch {
//                print("Erro: \(error)")
//            }
//        }
        
    }
    func signUp() async throws{
        guard !email.isEmpty, !password.isEmpty else {
            print("No email or password found.")
            return
        }
        let returnUserData = try await AuthenticationManager.shared.createUser(email: email, password: password)
    }
}
