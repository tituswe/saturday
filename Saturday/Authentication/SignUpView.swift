//
//  SignUpView.swift
//  Saturday
//
//  Created by Titus Lowe on 13/6/22.
//

import SwiftUI

enum SignUpState {
    
    case START
    case NAME
    case USERNAME
    case EMAIL
    case PROFILEPICTURE
    case PASSWORD1
    case PASSWORD2
    
}

struct SignUpView: View {
    
    @EnvironmentObject var viewModel: UserViewModel
    
    @State var state: SignUpState = .START
    
    @State var name = ""
    
    @State var username = ""
    
    @State var email = ""
    
    @State var password1 = ""
    
    @State var password2 = ""
    
    @State var profilePicture: UIImage?
    
    @State var isShowingActionSheet: Bool = false
    
    @State var isShowingImagePicker: Bool = false
    
    @State var sourceType: UIImagePickerController.SourceType = .camera
    
    var body: some View {
        
        ZStack {
            
            Color.systemGreen
                .ignoresSafeArea()
            
            Circle()
                .scale(1.7)
                .foregroundColor(.white.opacity(0.15))
            
            Circle()
                .scale(1.35)
                .foregroundColor(.white)
            
            VStack {
                
                if (state == .START) {
                    
                    Text("Sign Up")
                        .font(.system(.largeTitle, design: .rounded))
                        .fontWeight(.bold)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    Button {
                        withAnimation(.spring()) {
                            state = .NAME
                        }
                    } label: {
                        Text("Start")
                            .font(.system(.body, design: .rounded))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 100, height: 50)
                            .background(Color.systemBlue)
                            .cornerRadius(50)
                    }
                    
                } else if (state == .NAME) {
                    
                    Text("Enter your name")
                        .font(.system(.largeTitle, design: .rounded))
                        .fontWeight(.bold)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    TextField("Name", text: $name)
                        .multilineTextAlignment(.center)
                        .font(.system(.body, design: .rounded))
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(50)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    Button {
                        withAnimation(.spring()) {
                            state = .USERNAME
                        }
                    } label: {
                        Text("Next")
                            .font(.system(.body, design: .rounded))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 100, height: 50)
                            .background(Color.systemBlue)
                            .cornerRadius(50)
                    }
                    
                } else if (state == .USERNAME) {
                    
                    Text("Enter a username")
                        .font(.system(.largeTitle, design: .rounded))
                        .fontWeight(.bold)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    TextField("Username", text: $username)
                        .multilineTextAlignment(.center)
                        .font(.system(.body, design: .rounded))
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(50)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    Button {
                        withAnimation(.spring()) {
                            state = .EMAIL
                        }
                    } label: {
                        Text("Next")
                            .font(.system(.body, design: .rounded))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 100, height: 50)
                            .background(Color.systemBlue)
                            .cornerRadius(50)
                    }
                    
                } else if (state == .EMAIL) {
                    
                    Text("Enter an email")
                        .font(.system(.largeTitle, design: .rounded))
                        .fontWeight(.bold)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    TextField("Email", text: $email)
                        .multilineTextAlignment(.center)
                        .font(.system(.body, design: .rounded))
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(50)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    Button {
                        withAnimation(.spring()) {
                            state = .PASSWORD1
                        }
                    } label: {
                        Text("Next")
                            .font(.system(.body, design: .rounded))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 100, height: 50)
                            .background(Color.systemBlue)
                            .cornerRadius(50)
                    }
                    
                } else if (state == .PASSWORD1) {
                    
                    Text("Enter a password")
                        .font(.system(.largeTitle, design: .rounded))
                        .fontWeight(.bold)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    SecureField("Password", text: $password1)
                        .multilineTextAlignment(.center)
                        .font(.system(.body, design: .rounded))
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(50)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    Button {
                        withAnimation(.spring()) {
                            state = .PASSWORD2
                        }
                    } label: {
                        Text("Next")
                            .font(.system(.body, design: .rounded))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 100, height: 50)
                            .background(Color.systemBlue)
                            .cornerRadius(50)
                    }
                    
                } else if (state == .PASSWORD2) {
                    
                    Text("Confirm your password")
                        .font(.system(.largeTitle, design: .rounded))
                        .fontWeight(.bold)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    SecureField("Password", text: $password2)
                        .multilineTextAlignment(.center)
                        .font(.system(.body, design: .rounded))
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .frame(width: 300, height: 50)
                        .background(Color.black.opacity(0.05))
                        .cornerRadius(50)
                    
                    Spacer()
                        .frame(height: 20)
                    
                    Button {
                        if (password1 == password2) {
                            viewModel.register(withEmail: email,
                                               password: password2,
                                               name: name,
                                               username: username)
                        }
                    } label: {
                        Text("Next")
                            .font(.system(.body, design: .rounded))
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(width: 100, height: 50)
                            .background(Color.systemYellow)
                            .cornerRadius(50)
                    }
                    
                    
//                } else if (state == .PROFILEPICTURE) {
//
//                    Text("Add a profile picture")
//                        .font(.system(.largeTitle, design: .rounded))
//                        .fontWeight(.bold)
//
//                    Spacer()
//                        .frame(height: 20)
//
//                    if (profilePicture != nil) {
//
//                        Button {
//                            if (password1 == password2) {
//                                viewModel.register(withEmail: email,
//                                                   password: password2,
//                                                   name: name,
//                                                   username: username)
//                            }
//                        } label: {
//                            Text("Finish")
//                                .font(.system(.body, design: .rounded))
//                                .fontWeight(.semibold)
//                                .foregroundColor(.white)
//                                .frame(width: 100, height: 50)
//                                .background(Color.systemGreen)
//                                .cornerRadius(50)
//                        }
//
//                    } else {
//
//                        Button {
//                            withAnimation(.spring()) {
//                                isShowingActionSheet = true
//                            }
//                        } label: {
//                            Text("Select")
//                                .font(.system(.body, design: .rounded))
//                                .fontWeight(.semibold)
//                                .foregroundColor(.white)
//                                .frame(width: 100, height: 50)
//                                .background(Color.systemBlue)
//                                .cornerRadius(50)
//                        }
//                        .actionSheet(isPresented: $isShowingActionSheet) {
//                            ActionSheet(title: Text("Select Photo"),
//                                        message: Text("Choose"), buttons: [
//                                            .default(Text("Photo Library")) {
//                                                self.isShowingImagePicker = true
//                                                self.sourceType = .photoLibrary
//                                            },
//                                            .default(Text("Camera")) {
//                                                self.isShowingImagePicker = true
//                                                self.sourceType = .camera
//                                            },
//                                            .cancel()
//                                        ])
//                        }
//                        .sheet(isPresented: $isShowingImagePicker) {
//                            ImagePicker(image: self.$profilePicture, isShown: self.$isShowingImagePicker, sourceType: self.sourceType)
//                                .environmentObject(CartManager())
//                        }
//                        Button {
//                            print("DEBUG: Pick image here...")
//                        } label: {
//                            ZStack {
//
//                                Color.systemBlue.opacity(0.75)
//                                    .cornerRadius(50)
//                                    .frame(width: 100, height: 100)
//
//                                Image(systemName: "plus.circle")
//                                    .resizable()
//                                    .renderingMode(.template)
//                                    .foregroundColor(.white)
//                                    .scaledToFill()
//                                    .background(Color.systemBlue)
//                                    .cornerRadius(50)
//                                    .frame(width: 90, height: 90)
//
//                            }
//
//                        }
//
//                    }
                    
                    NavigationLink(destination: ProfilePictureSelectorView().navigationBarHidden(true), isActive: $viewModel.didAuthenticateUser, label: {})
                    
                }
                
            }
            
        }
        
    }
    
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(UserViewModel())
    }
}
