//
//  ImagePicker.swift
//  ConnectDB
//
//  Created by Elijah Elliott on 1/27/24.
//

import Foundation
import SwiftUI

import SwiftUI

@MainActor
class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate,ObservableObject{
    @Binding var selectedImage: UIImage?

    init(selectedImage: Binding<UIImage?>) {
        _selectedImage = selectedImage
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[.originalImage] as? UIImage {
            self.selectedImage = selectedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

@MainActor
struct ImagePicker: View {
    @StateObject private var coordinator: ImagePickerCoordinator
    @Binding var isPresented: Bool

    init(selectedImage: Binding<UIImage?>, isPresented: Binding<Bool>) {
        _coordinator = StateObject(wrappedValue: ImagePickerCoordinator(selectedImage: selectedImage))
        _isPresented = isPresented
    }

    var body: some View {
        ImagePickerRepresentable(coordinator: coordinator, isPresented: $isPresented)
    }
}

struct ImagePickerRepresentable: UIViewControllerRepresentable {
    @StateObject var coordinator: ImagePickerCoordinator
    @Binding var isPresented: Bool

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = coordinator
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
        if isPresented {
            DispatchQueue.main.async {
                // Reset the selected image
                self.coordinator.selectedImage = nil
                uiViewController.sourceType = .photoLibrary
                uiViewController.allowsEditing = false
                UIApplication.shared.windows.first?.rootViewController?.present(uiViewController, animated: true, completion: nil)
            }
        }
    }
}
