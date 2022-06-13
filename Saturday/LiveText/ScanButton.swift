//
//  ScanButton.swift
//  Saturday
//
//  Created by Titus Lowe on 13/6/22.
//

import SwiftUI

struct ScanButton: UIViewRepresentable {
    
    @Binding var text: String
    
    func makeUIView(context: Context) -> UIButton {
        let textFromCamera = UIAction.captureTextFromCamera(responder: context.coordinator, identifier: nil)
        let button = UIButton(primaryAction: textFromCamera)
        return button
    }
    
    func updateUIView(_ uiView: UIButton, context: Context) {
            
    }
    
    func makeCoordinator() -> Coordinator {
      Coordinator(self)
    }

    class Coordinator: UIResponder, UIKeyInput {
      let parent: ScanButton
      init(_ parent: ScanButton) { self.parent = parent }

      var hasText = false
      func insertText(_ text: String) {
          parent.text = text
      }
      func deleteBackward() { }
    }
    
    struct ScanButton_Previews: PreviewProvider {
        static var previews: some View {
            ScanButton(text: .constant(""))
                .previewLayout(.sizeThatFits)
        }
    }

}
