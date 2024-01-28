//
//  observer.swift
//  ConnectDB
//
//  Created by Elijah Elliott on 1/27/24.
//

import Foundation
import SwiftUI
import Firebase

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


// new code
import Foundation
import Firebase

class observer: ObservableObject {
    @Published var users = [DataTypes]()
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        let db = Firestore.firestore()
        db.collection("content").addSnapshotListener { (snap, err) in
            guard let documents = snap?.documents else {
                print("Error fetching documents: \(err?.localizedDescription ?? "Unknown error")")
                return
            }

            self.users = documents.compactMap { document in
                do {
                    let data = try document.data(as: DataTypes.self)
                    return data
                } catch {
                    print("Error decoding document with ID \(document.documentID): \(error)")
                    print("Document data: \(document.data() ?? [:])")
                    return nil
                }
            }
        }
    }

}
