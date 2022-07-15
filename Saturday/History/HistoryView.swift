//
//  HistoryView.swift
//  Saturday
//
//  Created by Titus Lowe on 10/7/22.
//

import SwiftUI

struct HistoryView: View {
    
    @EnvironmentObject var viewModel: UserViewModel
    
    @State var isShowingSideMenu: Bool = false
    
    var body: some View {
        
        ZStack {
            
            // MARK: Side Menu Bar
            if isShowingSideMenu {
                SideMenuView(isShowingSideMenu: $isShowingSideMenu)
                    .environmentObject(viewModel)
            }
            
            ZStack {
                
                Color.background
                
                VStack {
                    
                    // MARK: Navigation Bar
                    NavBarView(
                        topLeftButtonView: "line.horizontal.3",
                        topRightButtonView: "",
                        titleString: "History",
                        topLeftButtonAction: {
                            withAnimation(.spring()) {
                                isShowingSideMenu = true
                            }
                        },
                        topRightButtonAction: {})
                    
                    Spacer()
                    
                    ScrollView {
                        
                        LazyVStack {
                            
                            ForEach(viewModel.archives) { archive in
                                
                                HistoryRowView(archive: archive)
                                    .environmentObject(viewModel)
                                
                                Divider()
                                
                            }
                            
                        }
                        
                    }
                    
                    // MARK: Bottom Bar
                    BottomBarView(viewState: .HISTORY)
                        .environmentObject(viewModel)
                    
                }
                
            }
            .cornerRadius(isShowingSideMenu ? 20 : 10)
            .offset(x: isShowingSideMenu ? 300: 0, y: isShowingSideMenu ? 44 : 0)
            .scaleEffect(isShowingSideMenu ? 0.8 : 1)
            .ignoresSafeArea(.all, edges: [.top, .bottom])
            
        }
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
            .environmentObject(UserViewModel())
            .environment(\.colorScheme, .dark)
    }
}