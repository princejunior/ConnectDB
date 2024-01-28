//
//  UserManager.swift
//  ConnectDB
//
//  Created by Elijah Elliott on 1/27/24.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

final class UserManager {
    
//    @Published var users = [DataTypes]()
    static let shared = UserManager()
    
    init() {
        let db = Firestore.firestore()
        db.collection("users").getDocuments { (snap,err) in
            
        }
    }
//    profile
    
    func createNewUser(auth: AuthDataResultModel) async throws{
        var userData: [String:Any] = [
            "user_id" : auth.uid,
//            "is_anonymous": auth.isAnonymous,
            "data_created" : Timestamp(),
        ]
        if let email = auth.email {
            userData["email"] = email
        }
//        if let url = auth.photoUrl {
//            userData["photo_url"] = photoUrl
//        }
        
        try await Firestore.firestore().collection("users").document(auth.uid).setData(userData, merge: false)
    }
    
    
}
