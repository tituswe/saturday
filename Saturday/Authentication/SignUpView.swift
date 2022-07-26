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
    
//    @State var profilePicture: UIImage?
    
    @State var isShowingActionSheet: Bool = false
    
    @State var isShowingImagePicker: Bool = false
    
    @State var sourceType: UIImagePickerController.SourceType = .camera
    
    @State var errorMessage = ""
    
    @State var isShowingNameError: Bool = false
    
    @State var isShowingUsernameError: Bool = false
    
    @State var isShowingEmailError: Bool = false
    
    @State var isShowingPassword1Error: Bool = false
    
    @State var isShowingPassword2Error: Bool = false
    
    let timer = Timer.publish(every: 2.4, on: .main, in: .common).autoconnect()
    
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
                            withAnimation(.spring()) {
                                goBack()
                            }
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
                        
                        TextField(isShowingNameError ? "Enter a name" : "Name", text: $name)
                                .multilineTextAlignment(.center)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .padding()
                                .frame(width: 300, height: 50)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(50)
                                .focused($isFocused)
                                .overlay(Capsule()
                                    .stroke(isShowingNameError ? Color.systemRed : Color.clear, lineWidth: 3))
                                .onReceive(timer) { _ in
                                    withAnimation(.spring()) {
                                        errorMessage = ""
                                        isShowingNameError = false
                                    }
                                }
                        
                        Spacer()
                            .frame(height: 20)
                        
                        Button {
                            do {
                                try isValidName(name)
                                withAnimation(.spring()) {
                                    state = .USERNAME
                                }
                            } catch {
                                print(error.localizedDescription)
                                withAnimation(.spring()) {
                                    errorMessage = AuthError.invalidName.localizedDescription
                                    isShowingNameError = true
                                }
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
                        
                        TextField(isShowingUsernameError ? "Enter a username" : "Username", text: $username)
                                .multilineTextAlignment(.center)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .padding()
                                .frame(width: 300, height: 50)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(50)
                                .focused($isFocused)
                                .overlay(Capsule()
                                    .stroke(isShowingUsernameError ? Color.systemRed : Color.clear, lineWidth: 3))
                                .onReceive(timer) { _ in
                                    withAnimation(.spring()) {
                                        errorMessage = ""
                                        isShowingUsernameError = false
                                    }
                                }

                        
                        Spacer()
                            .frame(height: 20)
                        
                        Button {
                            do {
                                try isValidUsername(username)
                                withAnimation(.spring()) {
                                    state = .EMAIL
                                }
                            } catch {
                                print(error.localizedDescription)
                                withAnimation(.spring()) {
                                    errorMessage = AuthError.invalidUsername.localizedDescription
                                    isShowingUsernameError = true
                                }
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
                        
                        TextField(isShowingEmailError ? "Enter an email" : "Email", text: $email)
                                .multilineTextAlignment(.center)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .padding()
                                .frame(width: 300, height: 50)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(50)
                                .focused($isFocused)
                                .overlay(Capsule()
                                    .stroke(isShowingEmailError ? Color.systemRed : Color.clear, lineWidth: 3))
                                .onReceive(timer) { _ in
                                    withAnimation(.spring()) {
                                        errorMessage = ""
                                        isShowingEmailError = false
                                    }
                                }
                        
                        Spacer()
                            .frame(height: 20)
                        
                        Button {
                            do {
                                try isValidEmail(email)
                                withAnimation(.spring()) {
                                    state = .PASSWORD1
                                }
                            } catch {
                                print(error.localizedDescription)
                                withAnimation(.spring()) {
                                    errorMessage = AuthError.invalidEmail.localizedDescription
                                    isShowingEmailError = true
                                }
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
                        
                        SecureField(isShowingPassword1Error ? "Enter a password" : "Password", text: $password1)
                                .multilineTextAlignment(.center)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .padding()
                                .frame(width: 300, height: 50)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(50)
                                .focused($isFocused)
                                .overlay(Capsule()
                                    .stroke(isShowingPassword1Error ? Color.systemRed : Color.clear, lineWidth: 3))
                                .onReceive(timer) { _ in
                                    withAnimation(.spring()) {
                                        errorMessage = ""
                                        isShowingPassword1Error = false
                                    }
                                }
                        
                        Spacer()
                            .frame(height: 20)
                        
                        Button {
                            do {
                                try isValidPassword1(password1)
                                withAnimation(.spring()) {
                                    state = .PASSWORD2
                                }
                            } catch {
                                withAnimation(.spring()) {
                                    errorMessage = AuthError.invalidPassword1.localizedDescription
                                    isShowingPassword1Error = true
                                }
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
                        
                        SecureField(isShowingPassword2Error ? "Enter a password" : "Password", text: $password2)
                                .multilineTextAlignment(.center)
                                .disableAutocorrection(true)
                                .autocapitalization(.none)
                                .padding()
                                .frame(width: 300, height: 50)
                                .background(Color.black.opacity(0.05))
                                .cornerRadius(50)
                                .focused($isFocused)
                                .overlay(Capsule()
                                    .stroke(isShowingPassword2Error ? Color.systemRed : Color.clear, lineWidth: 3))
                                .onReceive(timer) { _ in
                                    withAnimation(.spring()) {
                                        errorMessage = ""
                                        isShowingPassword2Error = false
                                    }
                                }
                        
                        Spacer()
                            .frame(height: 20)
                        
                        Button {
                            do {
                                try isValidPassword2(password1, password2)
                                withAnimation(.spring()) {
                                    viewModel.register(withEmail: email,
                                                       password: password2,
                                                       name: name,
                                                       username: username)
                                }
                            } catch {
                                withAnimation(.spring()) {
                                    errorMessage = AuthError.invalidPassword2.localizedDescription
                                    isShowingPassword2Error = true
                                }
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
                    
                    Spacer()
                        .frame(height: 20)
                    
                    Text(errorMessage)
                        .font(.system(size: 12))
                        .foregroundColor(Color.systemRed)
                    
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
    
    func goBack() {
        switch state {
        case .START:
            self.isShowingSignUpView = false
        case .NAME:
            state = .START
        case .USERNAME:
            state = .NAME
        case .EMAIL:
            state = .USERNAME
        case .PASSWORD1:
            state = .EMAIL
        case .PASSWORD2:
            state = .PASSWORD1
        case .PROFILEPICTURE:
            state = .PASSWORD2
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
