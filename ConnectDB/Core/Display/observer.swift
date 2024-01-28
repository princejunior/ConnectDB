//
//  observer.swift
//  ConnectDB
//
//  Created by Elijah Elliott on 1/27/24.
//

//import Foundation
//import SwiftUI
//import Firebase
//
//class observer : ObservableObject {
////    @Published var users =
//    @Published var users = [DataTypes]()
//    
//    static let shared = UserManager()
//    
//    init() {
//        let db = Firestore.firestore()
//        db.collection("users").getDocuments { (snap,err) in
//            if err != nil {
//                print((err?.localizedDescription)!)
//            }
//            
//            for i in snap!.documents {
//                let name = i.get("name") as! String
//                let age = i.get("age") as! String
//                let image = i.get("image") as! String
//                let id = i.documentID
//                let status = i.get("status") as! String
//                
//                if status == "" {
//                    self.users.append(DataTypes(id:id, name:name, image:image, age:age, status: status))
//                }
//            }
//        }
//    }
//    
//}


import Foundation
import SwiftUI
import Firebase

class observer : ObservableObject {
//    @Published var users =
//    @Published var users = [ContentType]()
    @Published var users = [DataTypes]()
    
    static let shared = UserManager()
    init() {
        let db = Firestore.firestore()
        db.collection("content").getDocuments { (snap, err) in
            if let error = err {
                print("Error fetching documents: \(error.localizedDescription)")
                return
            }

            for i in snap!.documents {
                guard
                    let title = i.get("title") as? String,
                    let image = i.get("image") as? String,
                    let id = i.documentID as? String,  // Assuming documentID is a String
                    let description = i.get("description") as? String,
                    let status = i.get("status") as? String
                else {
                    print("Failed to unwrap values for document with ID: \(i.documentID)")
                    continue
                }

                if status.isEmpty {
                    // Assuming DataTypes is a struct with an initializer
                    let dataType = DataTypes(id: id, title: title, image: image, description: description, status: status)
                    self.users.append(dataType)
                }
            }
        }
    }

//    init() {
//        let db = Firestore.firestore()
//        db.collection("content").getDocuments { (snap,err) in
//            if err != nil {
//                print((err?.localizedDescription)!)
//            }
//            
//            for i in snap!.documents {
//                let title = i.get("title") as! String
//        
//                let image = i.get("image") as! String
//                let id = i.documentID
//                let description = i.get("description") as! String
//                let status = i.get("status") as! String
//                if status == "" {
////                    self.users.append(ContentType(id:id, title:title, image:image, description: description, status: status))
//                    self.users.append(DataTypes(id:id, title:title, image:image, description: description, status: status))
//                }
//            }
//        }
//    }
    
}
