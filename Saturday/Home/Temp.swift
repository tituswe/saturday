//
//  Temp.swift
//  Saturday
//
//  Created by Titus Lowe on 15/7/22.
//

import SwiftUI
import Kingfisher

enum HomeState {
    
    case CREDITS
    case DEBTS
    case HISTORY
    
}

struct Temp: View {
    
    @EnvironmentObject var viewModel: UserViewModel
    
    @State var isShowingSplitView: Bool = false
    
    @State var isShowingSideMenu: Bool = false
    
    @State var homeState: HomeState = .CREDITS
    
    @State var homeStateOffset = CGFloat(-121)
    
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
            
            ZStack {
                
                
                
                VStack {
                    
                    // MARK: Navigation Bar
                    NavBarView(
                        topLeftButtonView: "line.horizontal.3",
                        topRightButtonView: "plus",
                        titleString: "Saturday",
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
                    
                    // MARK: Profile Picture
                    if let user = viewModel.currentUser {
                        
                        KFImage(URL(string: user.profileImageUrl))
                            .resizable()
                            .scaledToFill()
                            .clipped()
                            .frame(width: 88, height: 88)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.background, lineWidth: 2))
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                            .padding()
                        
                    }
                    
                    // MARK: Information Bar
                    HStack {
                        
                        VStack(alignment: .leading) {
                            
                            Text("TODO")
                                .font(.title3)
                                
                            
                            Text("NET MONTH BALANCE")
                                .font(.system(size: 10))
                                .foregroundColor(.gray)
                            
                        }
                        .frame(width: 152)
                        .padding(.leading, 32)
                        
                        Divider()
                            .frame(height: 56)
                        
                        VStack(alignment: .leading) {
                            
                            Text("To Receive")
                                .font(.system(size: 8))
                                .foregroundColor(Color.systemGreen)
                            
                            Text("$" + String(format: "%.2f", viewModel.totalReceivable))
                            
                        }
                        .frame(width: 68)
                        
                        VStack(alignment: .leading) {
                            
                            Text("To Pay")
                                .font(.system(size: 8))
                                .foregroundColor(Color.systemRed)
                            
                            Text("$" + String(format: "%.2f", viewModel.totalPayable))
                            
                        }
                        .frame(width: 68)
                        .padding(.trailing, 32)
                        
                    }
                    .frame(width: 352, height: 72)
                    .background(Color.background)
                    .cornerRadius(25)
                    .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
                    .padding(.bottom)
                    
                    // MARK: Transaction Cards
                    VStack {
                        
                        VStack(spacing: 4) {
                            
                            HStack {
                                
                                Button {
                                    homeState = .CREDITS
                                    withAnimation {
                                        homeStateOffset = -121
                                    }
                                } label: {
                                    Text("CREDITS")
                                        .font(.system(size: 16))
                                        .foregroundColor(Color.gray)
                                        .padding(.horizontal, 24)
                                }
                                
                                
                                Spacer()
                                
                                Button {
                                    homeState = .DEBTS
                                    withAnimation {
                                        homeStateOffset = 0
                                    }
                                } label: {
                                    Text("DEBTS")
                                        .font(.system(size: 16))
                                        .foregroundColor(Color.gray)
                                        .padding(.horizontal, 24)
                                }
                                
                                Spacer()
                                
                                Button {
                                    homeState = .HISTORY
                                    withAnimation {
                                        homeStateOffset = 121
                                    }
                                } label: {
                                    Text("HISTORY")
                                        .font(.system(size: 16))
                                        .foregroundColor(Color.gray)
                                        .padding(.horizontal, 24)
                                }
                                
                            }
                            
                            RoundedRectangle(cornerRadius: 25)
                                .frame(width: 72, height: 2.4)
                                .foregroundColor(Color.systemViolet)
                                .offset(x: homeStateOffset)
                        }
                        .padding(16)
                        
                        ScrollView {
                            
                            LazyVStack {
                                
                                switch homeState {
                                case .CREDITS:
                                    ForEach(viewModel.credits, id: \.id) { credit in
                                        CreditCardView(credit: credit)
                                            .environmentObject(viewModel)
                                    }
                                    
                                case .DEBTS:
                                    ForEach(viewModel.debts, id: \.id) { debt in
                                        DebtCardView(debt: debt)
                                            .environmentObject(viewModel)
                                    }
                                    
                                case .HISTORY:
                                    ForEach(viewModel.archives, id: \.id) { archive in
                                        HistoryCardView(archive: archive)
                                            .environmentObject(viewModel)
                                    }
                                }
                                
                            }
                            
                        }
                        
                        Spacer()
    
                    }
                    .frame(maxWidth: .infinity, maxHeight: 528)
                    .background(Color.background)
                    .cornerRadius(50)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: -3)
                    
                }
                .cornerRadius(isShowingSideMenu ? 20 : 10)
                .offset(x: isShowingSideMenu ? 300: 0)
                .scaleEffect(isShowingSideMenu ? 0.8 : 1)
                .ignoresSafeArea(.all, edges: [.bottom])
                
            }
            
        }
        
    }
    
}

struct Temp_Previews: PreviewProvider {
    static var previews: some View {
        Temp()
            .environmentObject(UserViewModel())
    }
}
