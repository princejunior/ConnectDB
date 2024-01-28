//
//  RootView.swift
//  ConnectDB
//
//  Created by Elijah Elliott on 1/26/24.
//

import SwiftUI

struct RootView: View {
    
    @State private var showSignInView: Bool = false
    
    var body: some View {
        ZStack {
            if !showSignInView {
                NavigationStack {
                    DisplayView(showSignInView: $showSignInView)
//                    ProfileView(showSignInView: $showSignInView)
//                   SettingsView(showSignInView: $showSignInView)
                }
            }
        }
        .onAppear() {
            let authUser = try? AuthenticationManager.shared.getAuthenticatedUser()
            
            self.showSignInView = authUser == nil
        }
        .fullScreenCover(isPresented: $showSignInView, content: {
            NavigationStack {
                AuthenticationView(showSignInView: $showSignInView)
            }
        })
    }
}

#Preview {
    RootView()
}
