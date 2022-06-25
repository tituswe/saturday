//
//  TextExtractionModel.swift
//  Saturday
//
//  Created by Joshua Tan on 23/6/22.
//

import SwiftUI
import Vision

class TextExtractionModel {
    
    private var referenceReceipt: Image?
    private var extractedText: String = "Receipt not found"
    private var displayedText: String = ""
    
    public func insertReciept(image: Image) {
        self.referenceReceipt = image
    }
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "Starting..."
        return label
    }()
   
    // MARK: "receipt.." is where the uploaded receipt will be pointed at.
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "receipt1")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private func recognizeText(image: UIImage?) {
        guard let cgImage = image?.cgImage else {
            fatalError("Could not get CGImage")
        }
        
        //Handler
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        
        //Request
        let request = VNRecognizeTextRequest { [weak self] request, error in
            guard let observations = request.results as? [VNRecognizedTextObservation],
                  error == nil else {
                return
            }
            
            let text = observations.compactMap({
                $0.topCandidates(1).first?.string
            }).joined(separator: ";")
            
            // Store text to extractedText variable to manipulate
            self?.extractedText = text
            
            let processedText = TextProcessor().presentText(extractedText: text)
            var i = 0
            while i < processedText.count {
                self?.displayedText += "Quantity: \(processedText[i]), "
                self?.displayedText += "Name: \(processedText[i+1]), "
                self?.displayedText += "Price: \(processedText[i+2]) \n"
                i += 3
            }
            
            DispatchQueue.main.async {
                self?.label.text = self?.displayedText
            }
        }
        
        //Process request
        do {
            try handler.perform([request])
        }
        catch {
            print(error)
        }
    }
    
    func extractItems() -> [Item]{
        recognizeText(image: imageView.image)
        
        var itemList: [Item] = []
        
        let processedText = TextProcessor().presentText(extractedText: self.extractedText)
        var i = 0
        while i < processedText.count {
            if i % 3 == 0 { // i = 0, 3, 6, 9,...
                //Do nothing (No quantity)
                itemList.append(Item(id: "item \(i)", name: processedText[i+1], price: Double(processedText[i+2])!))
            }
            i += 1
        }
        return itemList
    }
}
