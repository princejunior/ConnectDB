//
//  ImagePicker.swift
//  ConnectDB
//
//  Created by Elijah Elliott on 1/27/24.
//

import Foundation
import SwiftUI

// Coordinator class responsible for handling image picker events and managing the selected image
@MainActor
class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate, ObservableObject {
    // Binding to the selected image
    @Binding var selectedImage: UIImage?

    // Initialize the coordinator with a binding to the selected image
    init(selectedImage: Binding<UIImage?>) {
        _selectedImage = selectedImage
    }

    // Delegate method called when an image is picked
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            // Set the selected image
            self.selectedImage = selectedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }

    // Delegate method called when image picking is canceled
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

// View for presenting the image picker
@MainActor
struct ImagePicker: View {
    // StateObject to manage the ImagePickerCoordinator
    @StateObject private var coordinator: ImagePickerCoordinator
    
    // Binding to control the presentation of the image picker
    @Binding var isPresented: Bool

    // Initialize the ImagePicker with a binding to the selected image and a binding for presentation
    init(selectedImage: Binding<UIImage?>, isPresented: Binding<Bool>) {
        _coordinator = StateObject(wrappedValue: ImagePickerCoordinator(selectedImage: selectedImage))
        _isPresented = isPresented
    }

    var body: some View {
        // Present the image picker using ImagePickerRepresentable
        ImagePickerRepresentable(coordinator: coordinator, isPresented: $isPresented)
    }
}

// UIViewControllerRepresentable to wrap the UIImagePickerController
struct ImagePickerRepresentable: UIViewControllerRepresentable {
    // StateObject to manage the ImagePickerCoordinator
    @StateObject var coordinator: ImagePickerCoordinator
    
    // Binding to control the presentation of the image picker
    @Binding var isPresented: Bool

    // Create the UIImagePickerController
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = coordinator
        return imagePicker
    }

    // Update the UIImagePickerController based on the presentation state
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        if isPresented {
            DispatchQueue.main.async {
                // Reset the selected image
                self.coordinator.selectedImage = nil
                
                // Configure and present the image picker
                uiViewController.sourceType = .photoLibrary
                uiViewController.allowsEditing = false
                UIApplication.shared.windows.first?.rootViewController?.present(uiViewController, animated: true, completion: nil)
            }
        }
    }
}
