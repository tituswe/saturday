//
//  TextProcessor.swift
//  Saturday
//
//  Created by Joshua Tan on 23/6/22.
//

import Foundation

class TextProcessor {
    
    var initialArray: [String] = [""]
    var cleanArray: [String] = []
    var presentedText: [String] = []

    /* MARK: NEW APPROACH
     * Store the extracted text string into an array.
     * Each element in the array is demarkated by the ";" seperator
     * After which, using the quantity as a marker, take elements of quanitity, name and price.
     * Quantities are always in the format of \(Integer)"x"
     * Name and Price always follows the quantity element in order of Name, Price.
     */
    
    func presentText(extractedText: String) -> [String] {
        // Transform string to array
        self.cleanData(extractedText: extractedText)
        print("DEBUG: clean array \n\(cleanArray)\n")

        // Check for \(Integer)"x" denoting quantity
        var i = 0
        for (index, substring) in self.cleanArray.enumerated() {
            if substring.count > 1 {
                let firstChar = substring[substring.index(substring.startIndex, offsetBy: 0)]
                let sndChar = substring.last
                if firstChar.isASCII && firstChar.isNumber && (sndChar == "x") {
                    i = index
                    self.presentedText.append(substring) // Quantity
                    self.presentedText.append(cleanArray[i+1]) // Name
                    self.presentedText.append(cleanArray[i+2]) // Price
                }
            }
        }

        print("DEBUG: presented text \n\(presentedText)\n")
        return self.presentedText
    }
    
    // Helper function to put extracted text string into an array
    private func cleanData(extractedText: String) {
        print("DEBUG: extracted text \n\(extractedText)")
        let temp = extractedText.replacingOccurrences(of: " S$ ", with: ";") // for foodpanda
        let temp2 = temp.replacingOccurrences(of: ";S$ ", with: ";")
        let text = temp2.replacingOccurrences(of: "$", with: "") // for deliveroo
        
        print("DEBUG: initial text \n\(text)\n")
        var arrayIndex = 0
        
                
        // For loop to put each line into the array in the format of ";..."
        for (_, char) in text.enumerated() {
            if char == ";" {
                arrayIndex += 1
                initialArray.append("\(char)")
            } else {
                initialArray[arrayIndex] += "\(char)"
            }
        }
        print("DEBUG: inserted ; \n\(initialArray)\n")
        
        // For loop to remove the ";" seperator at the start of each string element
        for substring in initialArray {
            var cleanedSubstring: String = substring
            if let i = cleanedSubstring.firstIndex(of: ";") {
                cleanedSubstring.remove(at: i)
            }
            self.cleanArray.append(cleanedSubstring)
        }
    }
}
