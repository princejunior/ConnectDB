//
//  SettingsView.swift
//  ConnectDB
//
//  Created by Elijah Elliott on 1/26/24.
//

import SwiftUI



struct SettingsView: View {
   
    @StateObject private var viewModel = SettingsViewModel()
    @Binding var showSignInView: Bool
    var body: some View {
        List {
            Button("Log Out") {
                Task {
                    do {
                        try viewModel.signOut()
                        showSignInView = true
                    } catch {
                        print(error)
                    }
                }
            }
            Button(role: .destructive) {
                Task {
                    do {
                        try await viewModel.deleteAccount()
                        showSignInView = true
                    } catch {
                        print(error)
                    }
                }
            } label: {
                Text("Delete Account")
            }
            
            emailSection
           
        }
        .navigationTitle("Settings")
    }
}

#Preview {
    NavigationStack {
        SettingsView(showSignInView: .constant(false))
    }
}

extension SettingsView {
    private var emailSection: some View{
        Section {
            Button("Reset Password") {
                Task {
                    do {
                        try await viewModel.resetPassword()
                        print("Password Reset")
                    } catch {
                        print(error)
                    }
                }
            }
            Button("Update Password") {
                Task {
                    do {
                        try await viewModel.updatePassword()
                        print("Password Updated")
                    } catch {
                        print(error)
                    }
                }
            }
            Button("Update Email") {
                Task {
                    do {
                        try await viewModel.updateEmail()
                        print("Email Updated")
                    } catch {
                        print(error)
                    }
                }
            }
        } header: {
            Text("Email Functions")
        }
    }
}
