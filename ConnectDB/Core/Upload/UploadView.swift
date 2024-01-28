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
    @State private var selectedImage: UIImage?
    @State private var imageURL: URL?
    @State private var isImagePickerPresented = false

    var body: some View {
        NavigationView {
            VStack {
                TextField("Title", text: $title)
                    .padding()

                TextField("Description", text: $description)
                    .padding()

                Button("Select Image") {
                    isImagePickerPresented.toggle()
                }
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePicker(selectedImage: $selectedImage, isPresented: $isImagePickerPresented)
                }
                .padding()

                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .padding()
                }

                Button("Upload to Firestore") {
                    uploadToFirestore()
                }
                .padding()

                Spacer()
            }
            .navigationTitle("Upload Data")
        }
    }

    func uploadToFirestore() {
        let db = Firestore.firestore()

        // Assuming you have a "users" collection
        let userDocument = db.collection("users").document()

        var documentData: [String: Any] = [
            "title": title,
            "description": description
            // Add any other fields you need
        ]

        if let imageData = selectedImage?.jpegData(compressionQuality: 0.5) {
            let storage = Storage.storage()
            let storageRef = storage.reference()
            let imageFileName = UUID().uuidString
            let imageRef = storageRef.child("images/\(imageFileName).jpg")

            imageRef.putData(imageData, metadata: nil) { (metadata, error) in
                if let error = error {
                    print("Error uploading image: \(error)")
                    return
                }

                imageRef.downloadURL { (url, error) in
                    if let error = error {
                        print("Error getting download URL: \(error)")
                        return
                    }

                    if let url = url {
                        self.imageURL = url
                        documentData["imageURL"] = url.absoluteString
                        saveDataToFirestore(userDocument: userDocument, documentData: documentData)
                    }
                }
            }
        } else {
            // No image selected, save other data directly
            saveDataToFirestore(userDocument: userDocument, documentData: documentData)
        }
    }

    func saveDataToFirestore(userDocument: DocumentReference, documentData: [String: Any]) {
        userDocument.setData(documentData) { error in
            if let error = error {
                print("Error adding document: \(error)")
            } else {
                print("Document added successfully.")
            }
        }
    }
}

struct UploadView_Previews: PreviewProvider {
    static var previews: some View {
        UploadView()
    }
}



//struct UploadView: View {
//    @State private var title = ""
//    @State private var description = ""
//    
//    @State private var selectedImage: UIImage?
//    @State private var imageURL: URL?
//    @State private var isImagePickerPresented = false
//    
//    
//    var body: some View {
//        NavigationView {
//            VStack {
//                TextField("Title", text: $title)
//                    .padding()
//                
//                TextField("Description", text: $description)
//                    .padding()
//                
//                Button("Select Image") {
//                    isImagePickerPresented.toggle()
//                }
//                .sheet(isPresented: $isImagePickerPresented) {
//                    ImagePicker(selectedImage: $selectedImage)
//                }
//                .padding()
//                
//                if let image = selectedImage {
//                    Image(uiImage: image)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 200, height: 200)
//                        .padding()
//                } else if let imageURL = imageURL {
//                    WebImage(url: imageURL)
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 200, height: 200)
//                        .padding()
//                }
//                
//                Button("Upload to Firestore") {
//                    uploadToFirestore()
//                }
//                .padding()
//                
//                Spacer()
//            }
//            .navigationTitle("Upload Data")
//        }
//    }
//    
//    func uploadToFirestore() {
//        guard let imageData = selectedImage?.jpegData(compressionQuality: 0.5) else {
//            print("Error: Unable to convert image to data.")
//            return
//        }
//        
//        let storage = Storage.storage()
//        let storageRef = storage.reference()
//        let imageFileName = UUID().uuidString
//        
//        let imageRef = storageRef.child("images/\(imageFileName).jpg")
//        
//        imageRef.putData(imageData, metadata: nil) { (metadata, error) in
//            if let error = error {
//                print("Error uploading image: \(error)")
//                return
//            }
//            
//            imageRef.downloadURL { (url, error) in
//                if let error = error {
//                    print("Error getting download URL: \(error)")
//                    return
//                }
//                
//                if let url = url {
//                    self.imageURL = url
//                    self.saveDataToFirestore(downloadURL: url)
//                }
//            }
//        }
//    }
//    
//    func saveDataToFirestore(downloadURL: URL) {
//        let db = Firestore.firestore()
//        
//        let documentData: [String: Any] = [
//            "title": title,
//            "description": description,
//            "imageURL": downloadURL.absoluteString
//            // Add any other fields you need
//        ]
//        
//        db.collection("yourCollectionName")
//            .addDocument(data: documentData) { error in
//                if let error = error {
//                    print("Error adding document: \(error)")
//                } else {
//                    print("Document added successfully.")
//                }
//            }
//    }
//}
//
//#Preview {
//    UploadView()
//}
