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

// View for uploading data to Firestore
struct UploadView: View {
    // State variables to hold title, description, and upload success state
    @State private var title = ""
    @State private var description = ""
    @State private var isUploadSuccessful = false
    
    // Binding to control the visibility of the sign-in view
    @Binding var showSignInView: Bool
    
    var body: some View {
        NavigationView {
            VStack {
                // Text field for entering the title
                TextField("Title", text: $title)
                    .padding()
                
                // Text field for entering the description
                TextField("Description", text: $description)
                    .padding()
                
                // Button to trigger the data upload
                Button("Upload to Firestore") {
                    uploadToFirestore()
                }
                .padding()
                
                // Navigation link to display view upon successful upload
                NavigationLink(
                    destination: isUploadSuccessful ? DisplayView(showSignInView: $showSignInView) : nil,
                    isActive: $isUploadSuccessful,
                    label: { EmptyView() }
                )
                .hidden()  // Hidden, as it's programmatically triggered
                
                // Spacer for layout
                Spacer()
            }
            .navigationTitle("Upload Data")
        }
    }
    
    // Function to upload data to Firestore
    func uploadToFirestore() {
        let db = Firestore.firestore()
        
        // Assuming you have a "content" collection
        let contentCollection = db.collection("content")
        
        // Prepare document data with title and description
        var documentData: [String: Any] = [
            "title": title,
            "description": description
            // Add any other fields you need
        ]
        
        // Use document() to automatically generate a unique ID for the document
        let contentDocument = contentCollection.document()
        
        // Set the document ID in the data
        documentData["id"] = contentDocument.documentID
        
        // Set data in Firestore document
        contentDocument.setData(documentData) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                // Print success message and trigger navigation
                print("Document added successfully with ID: \(contentDocument.documentID)")
                isUploadSuccessful = true
            }
        }
    }
}

// Preview provider for UploadView
struct UploadView_Previews: PreviewProvider {
    static var previews: some View {
        UploadView(showSignInView: .constant(false))
    }
}
