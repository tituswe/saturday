//
//  SideMenuView.swift
//  Saturday
//
//  Created by Titus Lowe on 4/7/22.
//

import SwiftUI

struct SideMenuView: View {
    
    @EnvironmentObject var viewModel: UserViewModel
    
    @Binding var isShowingSideMenu: Bool
    
    @State var isShowingDashboard: Bool = false
    
    @State var isShowingFriends: Bool = false
    
    @State var isShowingHistory: Bool = false
    
    @State var isShowingDarkMode: Bool = false
    
    @State var isLoggingOut: Bool = false
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [Color.gray, Color.white]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack {
                
                // MARK: Header
                SideMenuHeaderView(isShowingSideMenu: $isShowingSideMenu)
                    .environmentObject(viewModel)
                    .frame(height: 240)
                
                // MARK: Cell Items
                Button {
                    isShowingDashboard = true
                } label: {
                    SideMenuOptionView(title: "Dashboard", imageName: "house")
                }
                
                NavigationLink(isActive: $isShowingDashboard) {
                    HomeView()
                        .environmentObject(viewModel)
                        .navigationBarHidden(true)
                } label: {
                    Text("")
                }
                
                Button {
                    viewModel.fetchFriends()
                    viewModel.fetchUsers()
                    isShowingFriends = true
                } label: {
                    SideMenuOptionView(title: "Friends", imageName: "person.2")
                }
                
                NavigationLink(isActive: $isShowingFriends) {
                    FriendsView()
                        .environmentObject(viewModel)
                        .navigationBarHidden(true)
                } label: {
                    Text("")
                }
                
                Button {
                    isShowingHistory = true
                } label: {
                    SideMenuOptionView(title: "History", imageName: "clock")
                }
                
                NavigationLink(isActive: $isShowingHistory) {
                    HistoryView()
                        .environmentObject(viewModel)
                        .navigationBarHidden(true)
                } label: {
                    Text("")
                }
                
                SideMenuOptionView(title: "Light/Dark", imageName: "lightbulb")
                
                Button {
                    withAnimation(.spring()) {
                        viewModel.logout()
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
            .environmentObject(UserViewModel())
    }
}
