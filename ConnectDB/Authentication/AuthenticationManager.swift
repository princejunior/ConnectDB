//
//  AuthenticationManager.swift
//  ConnectDB
//
//  Created by Elijah Elliott on 1/26/24.
//

import Foundation
import FirebaseAuth

struct AuthDataResultModel {
    let uid: String
    let email: String?
    let photoUrl: String?

    init(user: User) {
        self.uid = user.uid
        self.email = user.email
        self.photoUrl = user.photoURL?.absoluteString
        
    }
}

enum AuthProviderOption: String {
    case email = "password"
    case google = "google.com"
    case appl = "apple.com"
}

final class AuthenticationManager {
    
    static let shared = AuthenticationManager()
    private init() {} 
    
    func getAuthenticatedUser() throws -> AuthDataResultModel {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
        return AuthDataResultModel(user: user)
    }
    
    @discardableResult
    func createUser(email:String, password: String ) async throws -> AuthDataResultModel{
        let authDataResult = try await Auth.auth().createUser(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func signInUser (email:String, password: String ) async throws -> AuthDataResultModel{
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    func resetPassword(email: String) async throws{
        try await Auth.auth().sendPasswordReset(withEmail: email)
    }
    
    func updatePassword(password: String) async throws{
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
       try await user.updatePassword(to: password)
    }
    
    func updateEmail(email: String) async throws{
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badServerResponse)
        }
//       try await user.updateEmail(to: email)
        try await user.sendEmailVerification(beforeUpdatingEmail: email)
    }
    
    func signOut() throws {
        try Auth.auth().signOut()
    }
    
    func delete() async throws {
        guard let user = Auth.auth().currentUser else {
            throw URLError(.badURL)
        }
        try await user.delete()
    }
}

// SIGN IN ANONYMOUS
extension AuthenticationManager {
    @discardableResult
    func signInAnonymous() async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signInAnonymously()
        return AuthDataResultModel(user: authDataResult.user)
    }
    
    @discardableResult
    func signInEmail(email:String,password: String) async throws -> AuthDataResultModel {
        let authDataResult = try await Auth.auth().signIn(withEmail: email, password: password)
        return AuthDataResultModel(user: authDataResult.user)
    }
}
