//
//  HomeView.swift
//  Saturday2
//
//  Created by Titus Lowe on 28/6/22.
//

import SwiftUI
import Kingfisher

enum HomeState {
    
    case CREDITS
    case DEBTS
    case HISTORY
    
}

struct HomeView: View {
    
    @EnvironmentObject var viewModel: UserViewModel
    
    @State var isShowingSplitView: Bool = false
    
    @State var isShowingSideMenu: Bool = false
    
    @State var homeState: HomeState = .CREDITS
    
    @State var homeStateOffset = CGFloat(-(UIScreen.main.bounds.width-64)/3)
    
    @State var refresh: Refresh = Refresh(started: false, released: false)
    
    let screenThird = (UIScreen.main.bounds.width-64)/3
    
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
            
            VStack(spacing: 0) {
                
                // MARK: Navigation Bar
                NavBarView(
                    topLeftButtonView: "line.horizontal.3",
                    topRightButtonView: "",
                    titleString: "Saturday",
                    topLeftButtonAction: {
                        withAnimation(.spring()) {
                            isShowingSideMenu = true
                        }
                    },
                    topRightButtonAction: {})
                
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
                        
                        Text(netMonthly())
                            .font(.title3)
                            .transition(.opacity)
                            .id(UUID().uuidString)
                        
                        
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
                        
                        Text(totalReceivable())
                            .transition(.opacity)
                            .id(UUID().uuidString)
                        
                    }
                    .frame(width: 68)
                    
                    VStack(alignment: .leading) {
                        
                        Text("To Pay")
                            .font(.system(size: 8))
                            .foregroundColor(Color.systemRed)
                        
                        Text(totalPayable())
                            .transition(.opacity)
                            .id(UUID().uuidString)
                        
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
                        
                        ZStack {
                            
                            Button {
                                homeState = .CREDITS
                                withAnimation {
                                    homeStateOffset = -screenThird
                                }
                            } label: {
                                Text("CREDITS")
                                    .font(.system(size: 16))
                                    .foregroundColor(Color.gray)
                                    .frame(width: screenThird)
                                    
                            }
                            .offset(x: -screenThird)
                            
                            Button {
                                homeState = .DEBTS
                                withAnimation {
                                    homeStateOffset = 0
                                }
                            } label: {
                                Text("DEBTS")
                                    .font(.system(size: 16))
                                    .foregroundColor(Color.gray)
                                    .frame(width: screenThird)
                            }
                            
                            Button {
                                homeState = .HISTORY
                                withAnimation {
                                    homeStateOffset = screenThird
                                }
                            } label: {
                                Text("HISTORY")
                                    .font(.system(size: 16))
                                    .foregroundColor(Color.gray)
                                    .frame(width: screenThird)
                            }
                            .offset(x: screenThird)
                            
                            
                        }
                        
                        RoundedRectangle(cornerRadius: 25)
                            .frame(width: 84, height: 2.4)
                            .foregroundColor(Color.systemViolet)
                            .offset(x: homeStateOffset)
                        
                    }
                    .padding(16)
                    
                    ScrollView {
                       
                        GeometryReader { reader -> AnyView in
                            
                            DispatchQueue.main.async {
                                
                                refresh.offset = reader.frame(in: .global).minY
                                
                                if refresh.offset > 410 && !refresh.started {
                                    refresh.started = true
                                }
                                
                                if refresh.offset > 410 && refresh.started && !refresh.released {
                                    withAnimation(Animation.linear) {
                                        refresh.released = true
                                        refresh.offset = 410
                                    }
                                    updateData()
                                }
                                
                            }
                            
                            return AnyView(Color.black.frame(width: 0, height: 0))
                            
                        }
                        .frame(width: 0, height: 0)
                        
                        ZStack(alignment: Alignment(horizontal: .center, vertical: .top)) {
                            
                            if refresh.started && refresh.released {
                                ProgressView()
                                    .offset(y: -35)
                            } else {
                                Image(systemName: "arrow.down")
                                    .font(.system(size: 16))
                                    .foregroundColor(Color.gray)
                                    .rotationEffect(.init(degrees: refresh.started ? 180 : 0))
                                    .offset(y: -25)
                                    .animation(.easeIn, value: 1)
                            }
                            
                            LazyVStack {
                                
                                switch homeState {
                                case .CREDITS:
                                    if viewModel.credits.isEmpty {
                                        Text("No pending credits to receive")
                                            .font(.system(size: 16))
                                            .foregroundColor(Color.gray)
                                            .padding()
                                    } else {
                                        ForEach(viewModel.credits, id: \.id) { credit in
                                            CreditCardView(credit: credit)
                                                .environmentObject(viewModel)
                                        }
                                    }

                                case .DEBTS:
                                    if viewModel.debts.isEmpty {
                                        Text("No pending debts to pay")
                                            .font(.system(size: 16))
                                            .foregroundColor(Color.gray)
                                            .padding()
                                    } else {
                                        ForEach(viewModel.debts, id: \.id) { debt in
                                            DebtCardView(debt: debt)
                                                .environmentObject(viewModel)
                                        }
                                    }

                                case .HISTORY:
                                    if viewModel.archives.isEmpty {
                                        Text("No past splits found")
                                            .font(.system(size: 16))
                                            .foregroundColor(Color.gray)
                                            .padding()
                                    } else {
                                        ForEach(viewModel.archives, id: \.id) { archive in
                                            HistoryCardView(archive: archive)
                                                .environmentObject(viewModel)
                                            Divider()
                                                .padding(.horizontal, 12)
                                        }
                                    }
                                }

                            }
                            
                        }
                        .offset(y: refresh.released ? 40 : -10)
                        
                    }
                    
                    Spacer()
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.background)
                .cornerRadius(50, corners:[.topLeft, .topRight])
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: -3)
                
                Spacer()
                    .frame(height: 2)
                
                // MARK: Bottom bar
                BottomBarView(viewState: .HOME)
                    .environmentObject(viewModel)
                
            }
            .cornerRadius(isShowingSideMenu ? 20 : 10)
            .offset(x: isShowingSideMenu ? 300: 0)
            .scaleEffect(isShowingSideMenu ? 0.8 : 1)
            .ignoresSafeArea(.all, edges: [.bottom])
            .onAppear {
                viewModel.refresh()
            }
            
        }
        
    }
    
    func updateData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            withAnimation(Animation.linear) {
                viewModel.refresh()
                refresh.released = false
                refresh.started = false
            }
        }
    }
    
    func netMonthly() -> String {
        guard let monthly = viewModel.tracker?.netMonthly else { return "" }
        
        if monthly >= 0 {
            return "$" + String(format: "%.2f", monthly)
        } else {
            return "-$" + String(format: "%.2f", -monthly)
        }
    }
    
    func totalPayable() -> String {
        guard let payable = viewModel.tracker?.totalPayable else { return "" }
        
        return "$" + String(format: "%.2f", payable)
    }
    
    func totalReceivable() -> String {
        guard let receivable = viewModel.tracker?.totalReceivable else { return "" }
        
        return "$" + String(format: "%.2f", receivable)
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(UserViewModel())
        //            .environment(\.colorScheme, .dark)
    }
}
