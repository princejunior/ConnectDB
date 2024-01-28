//
//  UploadView.swift
//  ConnectDB
//
//  Created by Elijah Elliott on 1/27/24.
//

import SwiftUI
import SDWebImageSwiftUI
import Firebase
import FirebaseFirestoreSwift
import FirebaseStorage

struct UploadView: View {
    @State private var title = ""
    @State private var description = ""
    @State private var isUploadSuccessful = false
    
    @Binding var showSignInView: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Title", text: $title)
                    .padding()
                
                TextField("Description", text: $description)
                    .padding()
                
                Button("Upload to Firestore") {
                    uploadToFirestore()
                }
                .padding()
                
                NavigationLink(
                    destination: isUploadSuccessful ? DisplayView(showSignInView: $showSignInView) : nil,
                    isActive: $isUploadSuccessful,
                    label: { EmptyView() }
                )
                .hidden()
                
                Spacer()
            }
            .navigationTitle("Upload Data")
        }
    }
    func uploadToFirestore() {
        let db = Firestore.firestore()
        
        // Assuming you have a "content" collection
        let contentCollection = db.collection("content")
        
        var documentData: [String: Any] = [
            "title": title,
            "description": description
            // Add any other fields you need
        ]
        
        // Use document() to automatically generate a unique ID for the document
        let contentDocument = contentCollection.document()
        
        // Set the document ID in the data
        documentData["id"] = contentDocument.documentID
        
        contentDocument.setData(documentData) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document added successfully with ID: \(contentDocument.documentID)")
                // Set the flag to trigger navigation
                isUploadSuccessful = true
            }
        }
    }
    
}

struct UploadView_Previews: PreviewProvider {
    static var previews: some View {
        UploadView(showSignInView: .constant(false))
    }
}
