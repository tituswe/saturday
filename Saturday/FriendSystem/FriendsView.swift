//
//  FriendsView.swift
//  Saturday
//
//  Created by Joshua Tan on 21/6/22.
//

import SwiftUI

struct FriendsView: View {
    var body: some View {
        NavigationView {
            VStack {
                // MARK: Navigation Bar
                NavbarView(topLeftButtonView: "line.horizontal.3", topRightButtonView: "circle.dashed", titleString: "Your Friends", topLeftButtonAction: {}, topRightButtonAction: {}) // TODO: Add toolbar functionality
                
                Spacer()
                
               // TODO: Retrive and Display friends from Firebase
            }
        }
    }
}

struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView()
    }
}
