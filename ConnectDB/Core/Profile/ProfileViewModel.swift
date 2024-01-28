//
//  ProfileViewModel.swift
//  ConnectDB
//
//  Created by Elijah Elliott on 1/27/24.
//

import Foundation

@MainActor
final class ProfileViewModel : ObservableObject {
    
    @Published private(set) var user : AuthDataResultModel? = nil
    
    func loadCurrentUser() throws {
        
        self.user = try AuthenticationManager.shared.getAuthenticatedUser()
    }
}
