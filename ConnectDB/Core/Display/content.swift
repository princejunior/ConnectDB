//
//  content.swift
//  ConnectDB
//
//  Created by Elijah Elliott on 1/27/24.
//
import Foundation
import SwiftUI
import Firebase

class content : ObservableObject {
//    @Published var users =
    @Published var users = [ContentType]()
    
    static let shared = UserManager()
    
    init() {
        let db = Firestore.firestore()
        db.collection("users").getDocuments { (snap,err) in
            if err != nil {
                print((err?.localizedDescription)!)
            }
            
            for i in snap!.documents {
                let title = i.get("name") as! String
        
                let image = i.get("image") as! String
                let id = i.documentID
                let description = i.get("description") as! String
                let status = i.get("status") as! String
                if image == "" {
                    let image = ""
                }
                self.users.append(ContentType(id:id, title:title, image:image, description: description, status: status))
            }
        }
    }
    
}
