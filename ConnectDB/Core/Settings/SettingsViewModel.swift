//
//  SettingsViewModel.swift
//  ConnectDB
//
//  Created by Elijah Elliott on 1/27/24.
//

import Foundation

@MainActor
final class SettingsViewModel: ObservableObject {
    
    func signOut() throws {
       try AuthenticationManager.shared.signOut()
    }
    
    func deleteAccount() async throws{
        try await AuthenticationManager.shared.delete()
    }
    
    func resetPassword() async throws {
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
        
        guard let email = authUser.email else {
            throw URLError(.fileDoesNotExist)
        }
        try await AuthenticationManager.shared.resetPassword(email: email)
    }
    
    func updateEmail() async throws {
        let email = "hello@gmail.com"
        try await AuthenticationManager.shared.updateEmail(email: email)
    }
    func updatePassword() async throws {
        let password = "1234567"
        try await AuthenticationManager.shared.updatePassword(password: password)
    }
}
