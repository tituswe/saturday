//
//  HomeView.swift
//  Saturday
//
//  Created by Joshua Tan on 21/6/22.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var user: UserLoginModel
    
    var body: some View {
            VStack {
                // MARK: Navigation Bar
                NavbarView(topLeftButtonView: "line.horizontal.3", topRightButtonView: "circle.dashed", titleString: "Dashboard", topLeftButtonAction: {}, topRightButtonAction: {}) // TODO: Add toolbar functionality
                
                Spacer()
                
                NavigationLink(destination: TextExtractionView()) {
                    Text("Add Split")
                        .bold()
                        .frame(width: 150, height: 50)
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(20)
                }
                
                Spacer()
                
                Button(action: {
                    user.signOut()
                }, label: {
                    Text("Log Out")
                        .foregroundColor(Color.blue)
                })
            }
            .navigationBarHidden(true)
    }
}

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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(UserLoginModel())
    }
}
