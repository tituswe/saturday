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
    
    @State var isShowingProfileView: Bool = false
    
    @State var isLoggingOut: Bool = false
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [Color.systemIndigo, Color.background]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack {
                
                // MARK: Header
                SideMenuHeaderView(isShowingSideMenu: $isShowingSideMenu)
                    .environmentObject(viewModel)
                    .frame(height: 240)
                
                // MARK: Cell Items
                Button {
                    withAnimation(.spring()) {
                        isShowingProfileView = true
                    }
                } label: {
                    SideMenuOptionView(title: "Profile", imageName: "person")
                }
                
                NavigationLink(isActive: $isShowingProfileView) {
                    ProfileView()
                        .environmentObject(viewModel)
                        .navigationBarHidden(true)
                } label: {}

                Link(destination: URL(string: "https://teamsaturdaydevs.wixsite.com/saturday")!) {
                    SideMenuOptionView(title: "Help", imageName: "questionmark.circle")
                }
                
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

//struct SideMenuView_Previews: PreviewProvider {
//    static var previews: some View {
//        SideMenuView(isShowingSideMenu: .constant(true))
//            .environmentObject(UserViewModel())
//    }
//}
