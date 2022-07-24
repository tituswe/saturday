//
//  ProfileView.swift
//  Saturday
//
//  Created by Titus Lowe on 21/7/22.
//

import SwiftUI
import Kingfisher

struct ProfileView: View {
    
    @EnvironmentObject var viewModel: UserViewModel
    
    @State var isShowingSideMenu: Bool = false
    
    @State var isShowingDeleteAlert: Bool = false
    
    var body: some View {
        NavigationView {
            
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
                        titleString: "Your Profile",
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
                        
                        VStack {
                            
                            Text("Hello, \(user.name)")
                                .font(.system(size: 16))
                                .bold()
                                .foregroundColor(Color.gray)
                            
                        }
                        .frame(width: 352, height: 64)
                        .background(Color.background)
                        .cornerRadius(50)
                        .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
                        .padding(.bottom)
                        
                        // MARK: Profile
                        VStack {
                            
                            VStack(spacing: 4) {
                                Text("PROFILE")
                                    .font(.system(size: 16))
                                    .foregroundColor(Color.gray)
                                
                                RoundedRectangle(cornerRadius: 25)
                                    .frame(width: 84, height: 2.4)
                                    .foregroundColor(Color.systemViolet)
                            }
                            .padding(16)
                            
                            HStack {
                                Text("\(viewModel.tracker?.currMonth.uppercased() ?? "MONTH") OVERVIEW:")
                                    .font(.system(size: 20))
                                    .foregroundColor(Color.gray)
                                    .padding(.horizontal, 24)
                                Spacer()
                                Text(netMonthly())
                                    .font(.system(size: 20))
                                    .foregroundColor(Color.gray)
                                    .padding(.horizontal, 24)
                            }
                            .frame(width: 320, height: 72)
                            .background()
                            .cornerRadius(25)
                            .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
                            .padding(.bottom, 8)
                            
                            HStack {
                                Button {
                                    withAnimation(.spring()) {
                                        viewModel.logout()
                                    }
                                } label: {
                                    Text("Log Out")
                                        .bold()
                                        .foregroundColor(Color.white)
                                }
                                .frame(width: 160, height: 40)
                                .background(Color.gray)
                                .cornerRadius(10)
                                .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
                                
                                Button {
                                    withAnimation(.spring()) {
                                        isShowingDeleteAlert = true
                                    }
                                } label: {
                                    Text("Delete Account")
                                        .bold()
                                        .foregroundColor(Color.white)
                                }
                                .frame(width: 160, height: 40)
                                .background(Color.systemRed)
                                .cornerRadius(10)
                                .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
                            }
                            .padding(16)

                                
                            Spacer()
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(Color.background)
                        .cornerRadius(50, corners:[.topLeft, .topRight])
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: -3)
                        .padding(.top, 8)
                        
                    }
                    
                    Spacer()
                        .frame(height: 2)
                    
                    // MARK: Bottom bar
                    BottomBarView()
                        .environmentObject(viewModel)
                    
                }
                .ignoresSafeArea(.all, edges: [.bottom])
                .alert("Are you sure you want to delete your account?", isPresented: $isShowingDeleteAlert) {
                    Button("Yes") {
                        viewModel.refresh()
                        viewModel.deleteAccount()
                        
                    }
                    Button("No", role: .cancel) {}
                }
                .cornerRadius(isShowingSideMenu ? 20 : 10)
                .offset(x: isShowingSideMenu ? 300: 0)
                .scaleEffect(isShowingSideMenu ? 0.8 : 1)
                .ignoresSafeArea(.all, edges: [.bottom])
            }
            .navigationBarHidden(true)
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
    
    func netLifetime() -> String {
        guard let lifetime = viewModel.tracker?.netLifetime else { return "" }
        
        if lifetime >= 0 {
            return "$" + String(format: "%.2f", lifetime)
        } else {
            return "-$" + String(format: "%.2f", -lifetime)
        }
    }
}

//struct ProfileView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfileView()
//            .environmentObject(UserViewModel())
//    }
//}
