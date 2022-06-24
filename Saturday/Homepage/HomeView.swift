//
//  HomeView.swift
//  Saturday
//
//  Created by Joshua Tan on 21/6/22.
//

import SwiftUI

struct HomeView: View {
    
    @State var friends: [User]
    
    var body: some View {
        NavigationView {
            VStack {
                // MARK: Navigation Bar
                NavbarView(topLeftButtonView: "line.horizontal.3", topRightButtonView: "circle.dashed", titleString: "Dashboard", topLeftButtonAction: {}, topRightButtonAction: {}) // TODO: Add toolbar functionality
                
                Spacer()
                
                ForEach(friends) { friend in
                    Text(friend.name)
                }
//
//                // MARK: Friends at a glance
//                HStack {
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        LazyHStack {
//                            ForEach(friends.indices) { i in
//                                VStack {
//                                }
//                            }
//                        }
//                    }
//                }
                
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(friends: friendListU)
    }
}
