//
//  BottomBarView.swift
//  Saturday
//
//  Created by Titus Lowe on 13/7/22.
//

import SwiftUI

enum ViewState {
    case HOME
    case FRIENDS
    case HISTORY
    case SPLIT
}
struct BottomBarView: View {
    
    @EnvironmentObject var viewModel: UserViewModel
    
    @State var isShowingDashboard: Bool = false
    
    @State var isShowingFriends: Bool = false
    
    //    @State var isShowingHistory: Bool = false
    
    @State var isShowingSplitView: Bool = false
    
    @State var viewState: ViewState
    
    var body: some View {
        
        HStack {
            
            Button {
                if viewState != .HOME {
                    viewModel.refresh()
                    isShowingDashboard = true
                }
            } label: {
                Image(systemName: "house")
                    .font(.system(size: 24))
            }
            .foregroundColor(Color.text)
            .frame(width: 88)
            .padding(.bottom, 8)
            
            NavigationLink(isActive: $isShowingDashboard) {
                ContentView()
                    .environmentObject(viewModel)
                    .navigationBarHidden(true)
            } label: {}
            
            Button {
                if viewState != .FRIENDS {
                    viewModel.refresh()
                    isShowingFriends = true
                }
            } label: {
                Image(systemName: "person.2")
                    .font(.system(size: 24))
            }
            .foregroundColor(Color.text)
            .frame(width: 88)
            .padding(.bottom, 8)
            
            NavigationLink(isActive: $isShowingFriends) {
                FriendsView()
                    .environmentObject(viewModel)
                    .navigationBarHidden(true)
            } label: {}
            
            Button {
                //                viewModel.refresh()
                //                isShowingHistory = true
            } label: {
                Image(systemName: "clock")
                    .font(.system(size: 24))
            }
            .foregroundColor(Color.text)
            .frame(width: 88)
            .padding(.bottom, 8)
            
            Button {
                if viewState != .SPLIT {
                    viewModel.refresh()
                    isShowingSplitView = true
                }
            } label: {
                ZStack {
                    Circle()
                        .foregroundColor(Color.systemGreen.opacity(0.8))
                        .frame(width: 36, height: 36)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                    Image(systemName: "plus")
                        .font(.system(size: 24))
                }
            }
            .foregroundColor(Color.white)
            .frame(width: 88)
            .padding(.bottom, 8)
            
            NavigationLink(isActive: $isShowingSplitView) {
                SplitView(isShowingSplitView: $isShowingSplitView)
                    .environmentObject(viewModel)
                    .navigationBarHidden(true)
            } label: {}
            
        }
        .frame(maxWidth: .infinity, maxHeight: 88)
        .background(Color.background)
        
    }
    
    
}

struct BottomBarView_Previews: PreviewProvider {
    static var previews: some View {
        BottomBarView(viewState: .HOME)
            .environmentObject(UserViewModel())
    }
}