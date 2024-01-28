//
//  AuthenticationViewModel.swift
//  ConnectDB
//
//  Created by Elijah Elliott on 1/27/24.
//

import Foundation

@MainActor
final class AuthenticationViewModel: ObservableObject {
    func signInAnonymous() async throws {
       let authDataResult = try await AuthenticationManager.shared.signInAnonymous()
        try await UserManager.shared.createNewUser(auth: authDataResult)
    }
    
    func signInEmail(email: String, password: String) async throws {
       let authDataResult = try await AuthenticationManager.shared.signInEmail(email: email, password: password)
        try await UserManager.shared.createNewUser(auth: authDataResult)
    }
}
