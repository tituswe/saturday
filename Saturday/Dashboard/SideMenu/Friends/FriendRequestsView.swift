//
//  FriendRequestsView.swift
//  Saturday
//
//  Created by Titus Lowe on 6/7/22.
//

import SwiftUI

struct FriendRequestsView: View {
    
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel
    
    @Binding var isShowingFriendRequestsView: Bool
    
    var body: some View {
        
        VStack {
            
            // MARK: Navigation Bar
            NavbarView(
                topLeftButtonView: "arrow.backward",
                topRightButtonView: "",
                titleString: "Friend Requests",
                topLeftButtonAction: {
                    isShowingFriendRequestsView = false
                    print(isShowingFriendRequestsView)
                },
                topRightButtonAction: {})
            
            Spacer()
            
            ScrollView {
                
                LazyVStack {
                    
                    ForEach(authenticationViewModel.friendRequests) { user in
                        
                        UserRowView(user: user, state: .RECEIVE)
                            .environmentObject(authenticationViewModel)
                        
                        Divider()
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
}

struct FriendRequestsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendRequestsView(isShowingFriendRequestsView: .constant(true))
            .environmentObject(AuthenticationViewModel())
    }
}
