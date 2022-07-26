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
    
    @State var isShowingChangePictureView: Bool = false
        
    @State var isShowingChangeEmailView: Bool = false
    
    @State var isShowingChangePasswordView: Bool = false
    
    @State var isShowingDeleteAlert: Bool = false
    
    @State var isShowingImagePicker: Bool = false
    
    @State var selectedImage: UIImage?
    
    @State var name = ""
    
    @State var username = ""
    
    @FocusState var isFocused: Bool
        
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
                
                ZStack {
                    
                    VStack(spacing: 0) {
                        
                        // MARK: Navigation Bar
                        NavBarView(
                            topLeftButtonView: "line.horizontal.3",
                            topRightButtonView: "",
                            titleString: "Your Profile",
                            topLeftButtonAction: {
                                withAnimation(.spring()) {
                                    viewModel.refresh()
                                    isShowingSideMenu = true
                                }
                            },
                            topRightButtonAction: {})
                        
                        // MARK: Profile Picture
                        if let user = viewModel.currentUser {
    //                    if let user = previewUser {
                            
                            ZStack(alignment: .bottomTrailing) {
                                if let selectedImage = selectedImage {
                                    Image(uiImage: selectedImage)
                                        .resizable()
                                        .scaledToFill()
                                        .clipped()
                                        .frame(width: 88, height: 88)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(Color.background, lineWidth: 2))
                                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                                } else {
                                    KFImage(URL(string: user.profileImageUrl))
                                        .resizable()
                                        .scaledToFill()
                                        .clipped()
                                        .frame(width: 88, height: 88)
                                        .clipShape(Circle())
                                        .overlay(Circle().stroke(Color.background, lineWidth: 2))
                                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                                }
                                
                                Button {
                                    isShowingImagePicker = true
                                } label: {
                                    Image(systemName: "pencil")
                                        .font(.system(size: 16))
                                        .foregroundColor(Color.white)
                                        .padding(4)
                                        .background(Color.gray)
                                        .cornerRadius(50)
                                        .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
                                }
                            }
                            .padding()
                            
                            VStack {
                                
                                Text("Hello, \(user.name)")
                                    .font(.system(size: 16))
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
                                    Text("EDIT PROFILE")
                                        .font(.system(size: 16))
                                        .foregroundColor(Color.gray)
                                    
                                    RoundedRectangle(cornerRadius: 25)
                                        .frame(width: 84, height: 2.4)
                                        .foregroundColor(Color.systemViolet)
                                }
                                .padding(16)
                                
                                VStack {
                                    HStack {
                                        TextField("Name: \(user.name)", text: $name)
                                            .font(.system(size: 16))
                                            .padding(.leading, 24)
                                            .padding(.vertical, 6)
                                            .background(Color.gray.opacity(0.5))
                                            .cornerRadius(10)
                                            .focused($isFocused)
                                        
                                        Button {
                                            viewModel.updateName(withName: name)
                                            viewModel.refresh()
                                            self.name = ""
                                            isFocused = false
                                        } label: {
                                            Text("Confirm")
                                                .font(.system(size: 12))
                                                .foregroundColor(Color.white)
                                                .padding(8)
                                                .background(name == "" ? Color.gray : Color.systemBlue)
                                                .cornerRadius(10)
                                                .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
                                        }
                                        .disabled(name == "")
                                    }
                                    .padding(.horizontal, 16)
                                    
                                    HStack {
                                        TextField("Username: @\(user.username)", text: $username)
                                            .font(.system(size: 16))
                                            .padding(.leading, 24)
                                            .padding(.vertical, 6)
                                            .background(Color.gray.opacity(0.5))
                                            .cornerRadius(10)
                                            .focused($isFocused)
                                        
                                        Button {
                                            viewModel.updateUsername(withUsername: username)
                                            viewModel.refresh()
                                            self.username = ""
                                            isFocused = false
                                        } label: {
                                            Text("Confirm")
                                                .font(.system(size: 12))
                                                .foregroundColor(Color.white)
                                                .padding(8)
                                                .background(username == "" ? Color.gray : Color.systemBlue)
                                                .cornerRadius(10)
                                                .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
                                        }
                                        .disabled(username == "")
                                    }
                                    .padding(.horizontal, 16)
                                    
                                    HStack {
                                        Text("Enter a new name and username and add an optional profile photo")
                                            .font(.system(size: 12))
                                            .foregroundColor(Color.gray)
                                        Spacer()
                                    }
                                    .padding(.horizontal, 24)
                                    .padding(.bottom, 8)
                                    Spacer()

                                        Button {
                                            isShowingChangeEmailView = true
                                        } label: {
                                            Text("Email: \(user.email)")
                                                .font(.system(size: 16))
                                                .foregroundColor(Color.white)
                                                .frame(maxWidth: .infinity)
                                                .padding(.horizontal, 24)
                                                .padding(.vertical, 6)
                                                .background(Color.gray.opacity(0.5))
                                                .cornerRadius(10)
                                                .padding(.horizontal)
                                                .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
                                        }

                                        HStack {
                                            Text("Change a valid email with @domain.com")
                                                .font(.system(size: 12))
                                                .foregroundColor(Color.gray)
                                            Spacer()
                                        }
                                        .padding(.horizontal, 24)
                                        .padding(.bottom, 8)

                                        Button {
                                            isShowingChangePasswordView = true
                                        } label: {
                                            Text("Change Password")
                                                .font(.system(size: 16))
                                                .foregroundColor(Color.white)
                                                .frame(maxWidth: .infinity)
                                                .padding(.horizontal, 24)
                                                .padding(.vertical, 6)
                                                .background(Color.gray.opacity(0.5))
                                                .cornerRadius(10)
                                                .padding(.horizontal)
                                                .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
                                        }
                                    
                                    HStack {
                                        Text("Change your password")
                                            .font(.system(size: 12))
                                            .foregroundColor(Color.gray)
                                        Spacer()
                                    }
                                    .padding(.horizontal, 24)
                                    .padding(.bottom, 8)

                                        Spacer()

                                        HStack {
                                            Button {
                                                withAnimation(.spring()) {
                                                    viewModel.logout()
                                                }
                                            } label: {
                                                Text("Log Out")
                                                    .font(.system(size: 14))
                                                    .foregroundColor(Color.white)
                                            }
                                            .frame(width: 120, height: 40)
                                            .background(Color.gray)
                                            .cornerRadius(10)
                                            .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)

                                            Button {
                                                withAnimation(.spring()) {
                                                    isShowingDeleteAlert = true
                                                }
                                            } label: {
                                                Text("Delete Account")
                                                    .font(.system(size: 14))
                                                    .bold()
                                                    .foregroundColor(Color.white)
                                            }
                                            .frame(width: 120, height: 40)
                                            .background(Color.systemRed)
                                            .cornerRadius(10)
                                            .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
                                        }
                                        .padding(16)
                                    
                                }
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                
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
                    .fullScreenCover(isPresented: $isShowingImagePicker, onDismiss: updateImage) {
                        ImagePicker(selectedImage: $selectedImage)
                    }
                    .fullScreenCover(isPresented: $isShowingChangeEmailView) {
                        ChangeEmailView(isShowingChangeEmailView: $isShowingChangeEmailView)
                            .environmentObject(viewModel)
                    }
                    .fullScreenCover(isPresented: $isShowingChangePasswordView) {
                        ChangePasswordView(isShowingChangePasswordView: $isShowingChangePasswordView)
                            .environmentObject(viewModel)
                    }
                    
                    if isShowingSideMenu {
                        Color.white.opacity(0.001)
                            .onTapGesture {
                                withAnimation(.spring()) {
                                    isShowingSideMenu = false
                                }
                            }
                    }
                    
                }
                .cornerRadius(isShowingSideMenu ? 20 : 10)
                .offset(x: isShowingSideMenu ? 300: 0)
                .scaleEffect(isShowingSideMenu ? 0.8 : 1)
                .ignoresSafeArea(.all, edges: [.bottom])
                
                if isFocused {
                    VStack {
                        Color.white.opacity(0.001)
                            .frame(height: 240)
                            .onTapGesture {
                                isFocused = false
                            }
                        Spacer()
                    }
                }
                
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
    
    func updateImage() {
        print("Checking selectedImage...")
        guard let selectedImage = selectedImage else { return }
        
        print("uploading Profile image...")
        withAnimation(.spring()) {
            viewModel.updateProfileImage(selectedImage)
            viewModel.refresh()
        }
    }

}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(UserViewModel())
    }
}
