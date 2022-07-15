//
//  FriendRequestsView.swift
//  Saturday
//
//  Created by Titus Lowe on 6/7/22.
//

import SwiftUI

struct FriendRequestsView: View {
    
    @EnvironmentObject var viewModel: UserViewModel

    var body: some View {
        
        VStack {
            
            // MARK: Navigation Bar
            NavBarView(
                topLeftButtonView: "",
                topRightButtonView: "",
                titleString: "Friend Requests",
                topLeftButtonAction: {},
                topRightButtonAction: {})
            
            Spacer()
            
            ScrollView {
                
                LazyVStack {
                    
                    ForEach(viewModel.friendRequests) { user in
                        
                        UserRowView(user: user, state: .RECEIVE)
                            .environmentObject(viewModel)
                        
                        Divider()
                        
                    }
                    
                }
                
            }
            
        }
        .background(Color.background)
        
    }
    
}

struct FriendRequestsView_Previews: PreviewProvider {
    static var previews: some View {
        FriendRequestsView()
            .environmentObject(UserViewModel())
    }
}
