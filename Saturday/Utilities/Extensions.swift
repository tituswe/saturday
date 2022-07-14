//
//  Extensions.swift
//  Saturday
//
//  Created by Titus Lowe on 19/5/22.
//

import Foundation
import SwiftUI

extension Color {
    static let background = Color("Background")
    static let text = Color("Text")
    static let systemRed = Color("Red")
    static let systemOrange = Color("Orange")
    static let systemYellow = Color("Yellow")
    static let systemGreen = Color("Green")
    static let systemBlue = Color("Blue")
    static let systemIndigo = Color("Indigo")
    static let systemViolet = Color("Violet")
    static let systemBackground = Color(uiColor: .systemBackground)
}

extension String {
    func capitalizeFirstChar() -> String {
        return prefix(1).capitalized + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizeFirstChar()
    }
}

struct FixedClipped: ViewModifier {
    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            content.hidden().layoutPriority(1)
            content.fixedSize(horizontal: true, vertical: false)
        }
        .clipped()
    }
}

extension View {
    func fixedClipped() -> some View {
        self.modifier(FixedClipped())
    }
}
