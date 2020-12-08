//
//  ImagePicker.swift
//  GiftHunteriOS
//
//  Created by Aswani G on 8/8/20.
//

import UIKit
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {

    @Environment(\.presentationMode)
    var presentationMode

    @Binding var image: Image?
    @Binding var profile: Profile


    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {

        @Binding var presentationMode: PresentationMode
        @Binding var image: Image?
        @Binding var profile: Profile

        init(
            presentationMode: Binding<PresentationMode>,
            image: Binding<Image?>,
            profile: Binding<Profile>) {
            _presentationMode = presentationMode
            _image = image
            _profile = profile
        }

        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            let imageURL = info[UIImagePickerController.InfoKey.imageURL] as? URL
            let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
            self.image = Image(uiImage: uiImage)

            if let url = imageURL {
                FirebaseDataService().updateDisplayPicture(filePath: url, profileData: profile)
            }
            presentationMode.dismiss()

        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            presentationMode.dismiss()
        }

    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(presentationMode: presentationMode, image: $image, profile: $profile)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<ImagePicker>) {

    }

}

