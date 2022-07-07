//
//  HomeView.swift
//  Saturday2
//
//  Created by Titus Lowe on 28/6/22.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var viewModel: UserViewModel
    
    @State var isShowingSplitView: Bool = false
    
    @State var isShowingSideMenu: Bool = false
    
    var body: some View {
        
            ZStack {
                
                // MARK: Side Menu Bar
                if isShowingSideMenu {
                    SideMenuView(isShowingSideMenu: $isShowingSideMenu)
                        .environmentObject(viewModel)
                }
                
                VStack {
                    
                    ZStack {
                        
                        Color(.white)
                        
                        VStack {
                            
                            // MARK: Navigation Bar
                            NavbarView(
                                topLeftButtonView: "line.horizontal.3",
                                topRightButtonView: "plus",
                                titleString: "Dashboard",
                                topLeftButtonAction: {
                                    viewModel.refresh()
                                    withAnimation(.spring()) {
                                        isShowingSideMenu = true
                                    }
                                },
                                topRightButtonAction: {
                                    isShowingSplitView = true
                                })
                            
                            
                            NavigationLink(isActive: $isShowingSplitView) {
                                SplitView(isShowingSplitView: $isShowingSplitView)
                                    .environmentObject(viewModel)
                                    .navigationBarHidden(true)
                            } label: {}
                            
                            Spacer()
                            
                            // MARK: Transaction Cards
                            ScrollView {
                            
                                LazyVStack {
                                    
                                    ForEach(viewModel.debts, id: \.id) { debt in
                                        DebtCardView(debt: debt)
                                            .environmentObject(viewModel)
                                    }
                                    
                                    ForEach(viewModel.credits, id: \.id) { credit in
                                        CreditCardView(credit: credit)
                                            .environmentObject(viewModel)
                                    }
                                    
                                }
                                
                            }
                            
                            Spacer()
                            
                        }
                        
                        VStack {
                            
                            Spacer()
                            
                            // MARK: Bottom Bar
                            if !isShowingSideMenu {
                                ZStack {
                                    
                                        Rectangle()
                                            .foregroundColor(Color.systemBlue)
                                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                                            .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: -3)
                                        
                                        Text("Bottom bar")
                                            .font(.system(.title2, design: .rounded))
                                            .fontWeight(.bold)
                                            .foregroundColor(.white)
                                    
                                }
                                .frame(maxWidth: .infinity, maxHeight: 80)
                                .ignoresSafeArea()
                            }
                            
                        }
            
                    }
                    .ignoresSafeArea(.all, edges: [.bottom])

                    
                }
                .cornerRadius(isShowingSideMenu ? 20 : 10)
                .offset(x: isShowingSideMenu ? 300: 0, y: isShowingSideMenu ? 44 : 0)
                .scaleEffect(isShowingSideMenu ? 0.8 : 1)
                .ignoresSafeArea(.all, edges: [.bottom])

            }
            
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(UserViewModel())
    }
}
