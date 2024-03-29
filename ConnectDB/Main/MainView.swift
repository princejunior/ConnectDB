//
//  MainView.swift
//  ConnectDB
//
//  Created by Elijah Elliott on 1/29/24.
//

import SwiftUI

struct MainView: View {
    // Binding to control the visibility of the sign-in view
    @Binding var showSignInView: Bool
    @State private var selection: Int = 1 // Default selection is set to House Icon
    
    var body: some View {
        NavigationView {
            VStack {
                TabView(selection: $selection) {
                    // Profile View
                    ProfileView(showSignInView: $showSignInView)
                        .tabItem {
                            Image(systemName: "person")
                            Text("Profile")
                        }
                        .tag(0)
                    
                    // House Icon
                    DisplayView(showSignInView: $showSignInView)
                        .tabItem {
                            Image(systemName: "house")
                            Text("Home")
                        }
                        .tag(1)
                    
                    // Plus Icon
                    UploadView(showSignInView: $showSignInView)
                        .tabItem {
                            Image(systemName: "plus")
                            Text("Create")
                        }
                        .tag(2)
                }
                .navigationBarHidden(true)
                .onAppear {
                    // Set the default behavior when the view appears
                    // Display content for House Icon
                    // You may need to adjust this logic based on your specific requirements
                    self.selection = 1
                }
            }
            .toolbar {
                // Toolbar item for navigating to the SettingsView
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
}


#Preview {
    MainView(showSignInView: .constant(false))
}
