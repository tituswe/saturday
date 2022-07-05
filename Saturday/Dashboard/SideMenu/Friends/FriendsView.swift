//
//  FriendsView.swift
//  Saturday
//
//  Created by Titus Lowe on 6/7/22.
//

import SwiftUI

struct FriendsView: View {
    
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    
    @ObservedObject var friendViewModel = FriendsViewModel()
    
    @State var isShowingSideMenu: Bool = false
    
    @State var isShowingFriendRequestsView: Bool = false
    
    var body: some View {
        
        ZStack {
            
            // MARK: Side Menu Bar
            if isShowingSideMenu {
                SideMenuView(isShowingSideMenu: $isShowingSideMenu)
                    .environmentObject(authenticationViewModel)
            }
            
            ZStack {
                
                Color(.white)
                
                VStack {
                    
                    // MARK: Navigation Bar
                    NavbarView(
                        topLeftButtonView: "line.horizontal.3",
                        topRightButtonView: "",
                        titleString: "Friends",
                        topLeftButtonAction: {
                            withAnimation(.spring()) {
                                isShowingSideMenu = true
                            }
                        },
                        topRightButtonAction: {})
                    
                    Spacer()
                    
                    HStack {
                        
                        Spacer()
                        
                        Button {
                            isShowingFriendRequestsView = true
                        } label: {
                            Text("Friend Requests")
                                .font(.system(.caption, design: .rounded))
                                .padding(8)
                                .background()
                                .cornerRadius(20)
                                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 3)
                        }
                        .padding(.top, 10)
                        .padding(.horizontal, 15)
                        
                        NavigationLink(isActive: $isShowingFriendRequestsView) {
                            FriendRequestsView(isShowingFriendRequestsView: $isShowingFriendRequestsView)
                                .environmentObject(authenticationViewModel)
                                .navigationBarHidden(true)
                        } label: {
                            Text("")
                        }
                        
                    }
                    
                    SearchBar(text: $friendViewModel.searchText)
                        .padding(.top, 10)
                        .padding(.horizontal, 10)
                   
                    
                    ScrollView {
                        
                        LazyVStack {
                            
                            ForEach(friendViewModel.searchableUsers) { user in
                                
                                UserRowView(user: user)
                                    .environmentObject(authenticationViewModel)
                                
                                Divider()
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            .cornerRadius(isShowingSideMenu ? 20 : 10)
            .offset(x: isShowingSideMenu ? 300: 0, y: isShowingSideMenu ? 44 : 0)
            .scaleEffect(isShowingSideMenu ? 0.8 : 1)
            
        }
        
    }
    
}

struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView()
            .environmentObject(AuthenticationViewModel())
    }
}
