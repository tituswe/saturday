//
//  SideMenuView.swift
//  Saturday
//
//  Created by Titus Lowe on 4/7/22.
//

import SwiftUI

struct SideMenuView: View {
    
    @EnvironmentObject var user: UserLoginModel
    
    @Binding var isShowingSideMenu: Bool
    
    @State var isShowingProfile: Bool = false
    
    @State var isShowingFriends: Bool = false
    
    @State var isShowingHistory: Bool = false
    
    @State var isShowingDarkMode: Bool = false
    
    @State var isLoggingOut: Bool = false
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [Color.gray, Color.white]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack {
                
                // MARK: Header
                SideMenuHeaderView(isShowingSideMenu: $isShowingSideMenu)
                    .frame(height: 240)
                
                // MARK: Cell Items
                Button {
                    isShowingProfile = true
                } label: {
                    SideMenuOptionView(title: "Profile", imageName: "person")
                }

                NavigationLink(isActive: $isShowingProfile) {
                    Text("Profile")
                } label: {
                    Text("")
                }
                
                Button {
                    isShowingFriends = true
                } label: {
                    SideMenuOptionView(title: "Friends", imageName: "person.2")
                }
                
                NavigationLink(isActive: $isShowingFriends) {
                    Text("Friends")
                } label: {
                    Text("")
                }
                
                Button {
                    isShowingHistory = true
                } label: {
                    SideMenuOptionView(title: "History", imageName: "clock")
                }

                NavigationLink(isActive: $isShowingHistory) {
                    Text("History")
                } label: {
                    Text("")
                }
                
                SideMenuOptionView(title: "Light/Dark", imageName: "lightbulb")
                
                Button {
                    withAnimation(.spring()) {
                        user.signOut()
                    }
                } label: {
                    SideMenuOptionView(title: "Logout", imageName: "arrow.left.square")
                }
                
                Spacer()
                
            }
            
        }
        
    }
    
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(isShowingSideMenu: .constant(true))
            .environmentObject(UserLoginModel())
    }
}
