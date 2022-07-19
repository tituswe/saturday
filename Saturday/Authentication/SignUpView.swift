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
    
    @Binding var isShowingSignUpView: Bool
    
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
    
    @FocusState var isFocused: Bool
    
    var body: some View {
        
        NavigationView {
            
            ZStack {
                
                LinearGradient(gradient: Gradient(colors: [Color.systemViolet, Color.background]), startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                
                Circle()
                    .scale(1.7)
                    .foregroundColor(Color.background.opacity(0.15))
                
                Circle()
                    .scale(1.35)
                    .foregroundColor(Color.background)
                
                // MARK: Navigation Bar
                VStack {
                    NavBarView(
                        topLeftButtonView: "arrow.backward",
                        topRightButtonView: "",
                        titleString: "",
                        topLeftButtonAction: {
                            isShowingSignUpView = false
                        },
                        topRightButtonAction: {})
                    
                    Spacer()
                }
                
                VStack {
                    
                    if (state == .START) {
                        
                        Text("Sign Up")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Spacer()
                            .frame(height: 20)
                        
                        Button {
                            withAnimation(.spring()) {
                                state = .NAME
                            }
                        } label: {
                            Text("Start")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: 100, height: 50)
                                .background(Color.systemBlue)
                                .cornerRadius(50)
                        }
                        
                    } else if (state == .NAME) {
                        
                        Text("Enter your name")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Spacer()
                            .frame(height: 20)
                        
                            TextField("Name", text: $name)
                                .multilineTextAlignment(.center)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .padding()
                                .frame(width: 300, height: 50)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(50)
                                .focused($isFocused)
                        
                        Spacer()
                            .frame(height: 20)
                        
                        Button {
                            withAnimation(.spring()) {
                                state = .USERNAME
                            }
                        } label: {
                            Text("Next")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: 100, height: 50)
                                .background(Color.systemBlue)
                                .cornerRadius(50)
                        }
                        
                    } else if (state == .USERNAME) {
                        
                        Text("Enter a username")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Spacer()
                            .frame(height: 20)
                        
                            TextField("Username", text: $username)
                                .multilineTextAlignment(.center)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .padding()
                                .frame(width: 300, height: 50)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(50)
                                .focused($isFocused)
                        
                        Spacer()
                            .frame(height: 20)
                        
                        Button {
                            withAnimation(.spring()) {
                                state = .EMAIL
                            }
                        } label: {
                            Text("Next")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: 100, height: 50)
                                .background(Color.systemBlue)
                                .cornerRadius(50)
                        }
                        
                    } else if (state == .EMAIL) {
                        
                        Text("Enter an email")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Spacer()
                            .frame(height: 20)
                        
                            TextField("Email", text: $email)
                                .multilineTextAlignment(.center)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .padding()
                                .frame(width: 300, height: 50)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(50)
                                .focused($isFocused)
                        
                        Spacer()
                            .frame(height: 20)
                        
                        Button {
                            withAnimation(.spring()) {
                                state = .PASSWORD1
                            }
                        } label: {
                            Text("Next")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: 100, height: 50)
                                .background(Color.systemBlue)
                                .cornerRadius(50)
                        }
                        
                    } else if (state == .PASSWORD1) {
                        
                        Text("Enter a password")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Spacer()
                            .frame(height: 20)
                        
                            SecureField("Password", text: $password1)
                                .multilineTextAlignment(.center)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .padding()
                                .frame(width: 300, height: 50)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(50)
                                .focused($isFocused)
                        
                        Spacer()
                            .frame(height: 20)
                        
                        Button {
                            withAnimation(.spring()) {
                                state = .PASSWORD2
                            }
                        } label: {
                            Text("Next")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: 100, height: 50)
                                .background(Color.systemBlue)
                                .cornerRadius(50)
                        }
                        
                    } else if (state == .PASSWORD2) {
                        
                        Text("Confirm your password")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Spacer()
                            .frame(height: 20)
                        
                            SecureField("Password", text: $password2)
                                .multilineTextAlignment(.center)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .padding()
                                .frame(width: 300, height: 50)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(50)
                                .focused($isFocused)
                        
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
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                                .frame(width: 100, height: 50)
                                .background(Color.systemBlue)
                                .cornerRadius(50)
                        }
                        
                        NavigationLink(destination: ProfilePictureSelectorView().navigationBarHidden(true), isActive: $viewModel.didAuthenticateUser, label: {})
                        
                    }
                    
                }
                
                if isFocused {
                    Color.white.opacity(0.001)
                        .onTapGesture {
                            isFocused = false
                        }
                }
                
            }
            .navigationBarHidden(true)
            
        }
        
    }
    
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView(isShowingSignUpView: .constant(true))
            .environmentObject(UserViewModel())
            .environment(\.colorScheme, .dark)
    }
}
