//
//  TextExtractionModel.swift
//  Saturday
//
//  Created by Joshua Tan on 23/6/22.
//

import SwiftUI
import Vision

class TextExtractionModel: UIViewController {
    
    private var referenceReceipt: Image?
    private var extractedText: String = "Receipt not found"
    private var displayedText: String = ""
    
    public func insertReciept(image: Image) {
        self.referenceReceipt = image
    }
    
    public func getText() -> String {
        return self.extractedText
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        view.addSubview(imageView)
        
        recognizeText(image: imageView.image)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        imageView.frame = CGRect(
            x: 20,
            y: view.safeAreaInsets.top,
            width: view.frame.size.width-40,
            height: view.frame.size.width-40
        )
        label.frame = CGRect(
            x: 20,
            y: view.frame.size.width + view.safeAreaInsets.top,
            width: view.frame.size.width-40,
            height: 200
        )
    }
    
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
}

struct TextExtractionConvert: UIViewControllerRepresentable {
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
    
    func makeUIViewController(context: Context) -> UIViewController {
        return TextExtractionModel()
    }
}
