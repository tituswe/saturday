//
//  FriendsView.swift
//  Saturday
//
//  Created by Titus Lowe on 6/7/22.
//

import SwiftUI

enum FriendState {
    
    case FRIEND
    case REQUEST
    
}

struct FriendsView: View {
    
    @EnvironmentObject var viewModel: UserViewModel
    
    @State var isShowingSplitView: Bool = false
    
    @State var isShowingSideMenu: Bool = false
    
    @State var friendState: FriendState = .FRIEND
    
    @State var friendStateOffset = CGFloat(-89)
    
    var body: some View {
        
        ZStack {
            
            // MARK: Side Menu Bar
            if isShowingSideMenu {
                SideMenuView(isShowingSideMenu: $isShowingSideMenu)
                    .environmentObject(viewModel)
            } else {
                LinearGradient(gradient: Gradient(colors: [Color.systemIndigo, Color.background]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
            }
            
            VStack {
                
                // MARK: Navigation Bar
                NavBarView(
                    topLeftButtonView: "line.horizontal.3",
                    topRightButtonView: "gearshape",
                    titleString: "Your Friends",
                    topLeftButtonAction: {
                        viewModel.refresh()
                        withAnimation(.spring()) {
                            isShowingSideMenu = true
                        }
                    },
                    topRightButtonAction: {})
                
                // MARK: Friends List
                VStack {
                    
                    VStack(spacing: 4) {
                        
                        HStack {
                            
                            Button {
                                friendState = .FRIEND
                                withAnimation {
                                    friendStateOffset = -89
                                }
                            } label: {
                                Text("FRIENDS")
                                    .font(.system(size: 16))
                                    .foregroundColor(Color.gray)
                                    .padding(.horizontal, 24)
                            }
                            
                            
                            Spacer()
                                .frame(width: 48)
                            
                            Button {
                                friendState = .REQUEST
                                withAnimation {
                                    friendStateOffset = 82
                                }
                            } label: {
                                Text("REQUESTS")
                                    .font(.system(size: 16))
                                    .foregroundColor(Color.gray)
                                    .padding(.horizontal, 24)
                            }
                            
                        }
                        
                        RoundedRectangle(cornerRadius: 25)
                            .frame(width: 72, height: 2.4)
                            .foregroundColor(Color.systemViolet)
                            .offset(x: friendStateOffset)
                        
                    }
                    .padding(.top, 16)
                    .padding(.bottom, 8)
                    
                    
                    SearchBar(text: $viewModel.searchText)
                        .padding(.horizontal, 10)
                    
                    ScrollView {
                        
                        LazyVStack {
                            
                            switch friendState {

                            case .FRIEND:
                                if viewModel.searchText.isEmpty {
                                    ForEach(viewModel.friends) { user in
                                        
                                        UserRowView(user: user, state: .FRIEND)
                                            .environmentObject(viewModel)
                                        
                                        Divider()
                                            .padding(.horizontal, 24)
                                        
                                    }
                                } else {
                                    ForEach(viewModel.searchableUsers) { user in
                                        
                                        UserRowView(user: user, state: userState(user: user))
                                            .environmentObject(viewModel)
                                        
                                        Divider()
                                            .padding(.horizontal, 24)
                                        
                                    }
                                }

                            case .REQUEST:
                                if viewModel.searchText.isEmpty {
                                    ForEach(viewModel.friendRequests) { user in
                                        
                                        UserRowView(user: user, state: .RECEIVE)
                                            .environmentObject(viewModel)
                                        
                                        Divider()
                                            .padding(.horizontal, 24)
                                        
                                    }
                                } else {
                                    ForEach(viewModel.searchableRequests) { user in
                                        
                                        UserRowView(user: user, state: .RECEIVE)
                                            .environmentObject(viewModel)
                                        
                                        Divider()
                                            .padding(.horizontal, 24)
                                        
                                    }
                                }

                            }
                            
                        }
                        
                    }
                    
                    Spacer()
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.background)
                .cornerRadius(50, corners:[.topLeft, .topRight])
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: -3)
                .padding(.top, 8)
                
                Spacer()
                    .frame(height: 2)
                
                // MARK: Bottom bar
                BottomBarView(viewState: .FRIENDS)
                    .environmentObject(viewModel)
                
            }
            .cornerRadius(isShowingSideMenu ? 20 : 10)
            .offset(x: isShowingSideMenu ? 300: 0)
            .scaleEffect(isShowingSideMenu ? 0.8 : 1)
            .ignoresSafeArea(.all, edges: [.bottom])
            
        }
        
    }
    
    func userState(user: User) -> RequestState {
        if viewModel.hasFriendRequest(user: user) {
            return .RECEIVE
        } else if viewModel.hasSentFriendRequest(user: user) {
            return .SENT
        } else {
            return .SEND
        }
    }
    
}

struct FriendsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendsView()
            .environmentObject(UserViewModel())
            .environment(\.colorScheme, .dark)
    }
}
