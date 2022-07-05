//
//  HomeView.swift
//  Saturday2
//
//  Created by Titus Lowe on 28/6/22.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    @State var isShowingSplitView: Bool = false
    
    @State var isShowingSideMenu: Bool = false
    
    var body: some View {
        
            ZStack {
                
                // MARK: Side Menu Bar
                if isShowingSideMenu {
                    SideMenuView(isShowingSideMenu: $isShowingSideMenu)
                        .environmentObject(viewModel)
                }
                
                ZStack {
                    
                    Color(.white)
                    
                    VStack {
                        
                        // MARK: Navigation Bar
                        NavbarView(
                            topLeftButtonView: "line.horizontal.3",
                            topRightButtonView: "plus",
                            titleString: "Friends",
                            topLeftButtonAction: {
                                withAnimation(.spring()) {
                                    isShowingSideMenu = true
                                }
                                
                                
                            },
                            topRightButtonAction: {
                                isShowingSplitView = true
                            })
                        
                        Spacer()
                        
                        ScrollView {
                        
                            VStack {
                                DebtCard()
                                DebtCard()
                                DebtCard()
                                DebtCard()
                            }
                        }
                        
                        Spacer()
                        
                        NavigationLink(isActive: $isShowingSplitView) {
//                            SplitView(cartManager: CartManager(), isShowingSplitView: $isShowingSplitView)
//                                .environmentObject(previewDatabaseManager)
//                                .navigationBarHidden(true)
                        } label: {
                            Text("")
                        }
                        
                    }
                    
                }
                .cornerRadius(isShowingSideMenu ? 20 : 10)
                .offset(x: isShowingSideMenu ? 300: 0, y: isShowingSideMenu ? 44 : 0)
                .scaleEffect(isShowingSideMenu ? 0.8 : 1)
                
            }
            
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AuthenticationViewModel())
    }
}
