//
//  Avatar.swift
//  Saturday
//
//  Created by Titus Lowe on 22/7/22.
//

import SwiftUI

struct Avatar: View {
    
    @State var avatarColor: Int = 0
    
    var body: some View {
        
//            Image(systemName: "person")
//                .resizable()
//                .scaledToFit()
//                .padding()
//                .clipped()
//                .clipShape(Circle())
//                .overlay(Circle().stroke(Color.background, lineWidth: 2))
//                .padding()
//        .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
            
        Image(systemName: "person")
//            .resizable()
            .padding()
            .foregroundColor(Color.background)
            .background(color())
            .clipShape(Circle())
            .overlay(Circle().stroke(Color.background, lineWidth: 2))
            .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0 , y: 3)

        
    }
    
    func color() -> Color {
        let colors = [0: Color.systemIndigo,
                      1: Color.systemViolet,
                      2: Color.systemRed,
                      3: Color.systemBlue,
                      4: Color.systemGreen,
                      5: Color.black]
        return colors[avatarColor]!
    }
}

struct Avatar_Previews: PreviewProvider {
    static var previews: some View {
        Avatar()
    }
}
