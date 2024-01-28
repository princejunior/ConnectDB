////
////  DisplayView.swift
////  ConnectDB
////
////  Created by Elijah Elliott on 1/27/24.
////
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct DisplayView: View {
    @ObservedObject var obser = observer()
    @Binding var showSignInView: Bool

    var body: some View {
        NavigationView {
            List(obser.users) { user in
                NavigationLink(destination: Details(userItem: user)) {
                    HStack {
                        // Assuming 'image' is a property of DataTypes
//                        WebImage(url: URL(string: user.image))
//                            .resizable()
//                            .frame(width: 60, height: 60)
//                            .clipShape(Circle())
//                            .shadow(radius: 20)

                        VStack(alignment: .leading) {
                            Text(user.title)
                                .font(.headline)
                            Text(user.description)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                        .padding(.leading, 10)
                    }
                }
            }
            .navigationTitle("Display")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    NavigationLink {
                        UploadView(showSignInView: .constant(false))
                    } label: {
                        Image(systemName: "plus")
                            .font(.headline)
                    }
                }
            }
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
}

//import SwiftUI
//import Firebase
//import SDWebImageSwiftUI
//
//struct DisplayView: View {
//    @ObservedObject var obser = observer()
////    @ObservedObject var obser = content()
//    @Binding var showSignInView: Bool
//    
//    var body: some View {
//        NavigationView {
//            List (obser.users) { i in
//                Text(i.title).padding(.leading, 10)
//            }
//            List {
//                ForEach(obser.users) { i in
//                    NavigationLink(destination: Details(userItem: i)) {
//                        HStack {
////                            AnimatedImage(url: URL(string: i.image)).resizable().frame(width: 60, height: 60).clipShape(Circle()).shadow(radius: 20)
//                            Text(i.title).padding(.leading, 10) // Assuming 'name' is a property of ContentType
//                        }
//                    }
//                }
//            }
//
////            List (obser.users) { i in
////                NavigationLink(destination: Details(userItem: i)) {
////                    HStack {
////                        AnimatedImage(url: URL(string: i.image)).resizable().frame(width: 60,height: 60).clipShape(Circle()).shadow(radius: 20)
////                        Text(i.name).padding(.leading, 10)
////                    }
////                }
////            }
//        }
//        .navigationTitle("Display")
//        .toolbar {
//            ToolbarItem(placement: .topBarTrailing) {
//                NavigationLink {
//                    UploadView(showSignInView: .constant(false))
//                } label: {
//                    Image(systemName: "plus")
//                        .font(.headline)
//                    }
//            }
//        }
//        .toolbar {
//            ToolbarItem(placement: .topBarTrailing) {
//                NavigationLink {
//                    SettingsView(showSignInView: $showSignInView)
//                } label: {
//                    Image(systemName: "gear")
//                        .font(.headline)
//                }
//            }
//        }
//    }
//}
//
//#Preview {
//    DisplayView(showSignInView: .constant(false))
//}
