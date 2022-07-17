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

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

extension View {
    func fixedClipped() -> some View {
        self.modifier(FixedClipped())
    }
    
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

extension Calendar {
    func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
        let numberOfDays = dateComponents([.day], from: from, to: to) 
        
        return numberOfDays.day!
    }
}

struct Refresh {
    var startOffset = CGFloat(0)
    var offset = CGFloat(0)
    var started: Bool
    var released: Bool
}
