//
//  ProfileView.swift
//  ConnectDB
//
//  Created by Elijah Elliott on 1/27/24.
//

import SwiftUI



struct ProfileView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    
    @Binding var showSignInView: Bool
    
    
    var body: some View {
        
        List {
            if let user = viewModel.user {
                Text("UserId: \(user.uid)")
            }
        }
        .onAppear {
           try? viewModel.loadCurrentUser()
        }
        .navigationTitle("Profile")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink {
                    SettingsView(showSignInView: $showSignInView)
                } label: {
                    Image(systemName: "gear")
                        .font(.headline)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ProfileView(showSignInView: .constant(false))
    }
}
