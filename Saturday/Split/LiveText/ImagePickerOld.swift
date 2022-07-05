////
////  ImagePicker.swift
////  Saturday
////
////  Created by Titus Lowe on 26/6/22.
////
//
//import Foundation
//import SwiftUI
//
//class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
//
//    @Binding var image: UIImage?
//    @Binding var isShown: Bool
//    @Binding var hasAddedReceipt: Bool
//    @EnvironmentObject var cartManager: CartManager
//
//    init(image: Binding<UIImage?>, isShown: Binding<Bool>) {
//        _image = image
//        _isShown = isShown
//        _hasAddedReceipt = .constant(false)
//    }
//
//    init(image: Binding<UIImage?>, isShown: Binding<Bool>, hasAddedReceipt: Binding<Bool>, cartManager: EnvironmentObject<CartManager>) {
//        _image = image
//        _isShown = isShown
//        _hasAddedReceipt = hasAddedReceipt
//        _cartManager = cartManager
//    }
//
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
//        if let uiImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
//            image = uiImage
//            isShown = false
//            hasAddedReceipt = true
//            cartManager.addItemList(itemList: TextExtractionModel(referenceReceipt: uiImage).extractItems())
//        }
//    }
//
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        isShown = false
//    }
//}
//
//struct ImagePicker: UIViewControllerRepresentable {
//
//    typealias UIViewControllerType = UIImagePickerController
//    typealias Coordinator = ImagePickerCoordinator
//
//    @Binding var image: UIImage?
//    @Binding var isShown: Bool
//    @Binding var hasAddedReceipt: Bool
//    var sourceType: UIImagePickerController.SourceType = .camera
//    @EnvironmentObject var cartManager: CartManager
//
//    init(image: Binding<UIImage?>, isShown: Binding<Bool>, sourceType: UIImagePickerController.SourceType) {
//        _image = image
//        _isShown = isShown
//        _hasAddedReceipt = .constant(false)
//        self.sourceType = sourceType
//    }
//
//    init(image: Binding<UIImage?>, isShown: Binding<Bool>, hasAddedReceipt: Binding<Bool>, sourceType: UIImagePickerController.SourceType) {
//        _image = image
//        _isShown = isShown
//        _hasAddedReceipt = hasAddedReceipt
//        self.sourceType = sourceType
//    }
//
//    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
//
//    }
//
//    func makeCoordinator() -> ImagePicker.Coordinator {
//        return ImagePickerCoordinator(image: $image, isShown: $isShown, hasAddedReceipt: $hasAddedReceipt, cartManager: _cartManager)
//    }
//
//    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
//        let picker = UIImagePickerController()
//        picker.sourceType = sourceType
//        picker.delegate = context.coordinator
//        return picker
//    }
//
//}
