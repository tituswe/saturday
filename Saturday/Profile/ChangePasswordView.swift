//
//  ChangePasswordView.swift
//  Saturday
//
//  Created by Titus Lowe on 26/7/22.
//

import SwiftUI

struct ChangePasswordView: View {
    
    @EnvironmentObject var viewModel: UserViewModel
    
    @Binding var isShowingChangePasswordView: Bool
    
    @State var isSecured: Bool = true
    
    @State var oldPassword = ""
        
    @State var newPassword = ""
    
    @State var confirmedPassword = ""
    
    @FocusState var isFocused: Bool
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [Color.systemIndigo, Color.background]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
                .blur(radius: 50)
            
            ZStack(alignment: .topTrailing) {
                
                RoundedRectangle(cornerRadius: 50)
                    .foregroundColor(Color.background)
                    .frame(width: 320, height: 320)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                
                Button {
                    withAnimation(.spring()) {
                        isShowingChangePasswordView = false
                    }
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 20))
                        .foregroundColor(Color.text)
                }
                .padding(.top, 24)
                .padding(.trailing, 24)
                
            }
            
            VStack {
                
                Text("Change Password")
                    .font(.title3)
                
                if isSecured {
                    SecureField("Enter your current password", text: $oldPassword)
                        .font(.system(size: 14))
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)
                        .background(Color.black.opacity(0.05))
                        .frame(width: 240, height: 48)
                        .cornerRadius(25)
                        .focused($isFocused)
                    
                    SecureField("Enter your new password", text: $newPassword)
                        .font(.system(size: 14))
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)
                        .background(Color.black.opacity(0.05))
                        .frame(width: 240, height: 48)
                        .cornerRadius(25)
                        .focused($isFocused)
                    
                    SecureField("Confirm your new password", text: $confirmedPassword)
                        .font(.system(size: 14))
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)
                        .background(Color.black.opacity(0.05))
                        .frame(width: 240, height: 48)
                        .cornerRadius(25)
                        .focused($isFocused)
                    
                } else {
                    TextField("Enter your current password", text: $oldPassword)
                        .font(.system(size: 14))
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)
                        .background(Color.black.opacity(0.05))
                        .frame(width: 240, height: 48)
                        .cornerRadius(25)
                        .focused($isFocused)
                    
                    TextField("Enter your new password", text: $newPassword)
                        .font(.system(size: 14))
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)
                        .background(Color.black.opacity(0.05))
                        .frame(width: 240, height: 48)
                        .cornerRadius(25)
                        .focused($isFocused)
                    
                    TextField("Confirm your new password", text: $confirmedPassword)
                        .font(.system(size: 14))
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)
                        .background(Color.black.opacity(0.05))
                        .frame(width: 240, height: 48)
                        .cornerRadius(25)
                        .focused($isFocused)
                }
                
                HStack {
                  
                    Button {
                        isSecured.toggle()
                    } label: {
                        Image(systemName: isSecured ? "eye.slash" : "eye")
                            .font(.system(size: 20))
                            .accentColor(Color.gray)
                            .padding(.top, 8)
                            .padding(.leading, 8)
                    }
                    
                    Spacer()
                    
                    Button {
                        withAnimation(.spring()) {
                            viewModel.updatePassword(oldPassword: oldPassword, newPassword: newPassword)
                            viewModel.refresh()
                            isShowingChangePasswordView = false
                        }
                    } label: {
                        Text("Confirm")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 8)
                            .background(canConfirm() ? Color.systemBlue : Color.gray)
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
                    }
                    .disabled(!canConfirm())
                    .padding(.top, 8)

                }
                .frame(width: 220)
                
            }
            
            if isFocused {
                Color.white.opacity(0.001)
                    .onTapGesture {
                        isFocused = false
                    }
            }
            
        }
    }
    
    func canConfirm() -> Bool {
        return oldPassword != "" && newPassword != "" && confirmedPassword != "" && newPassword == confirmedPassword
    }
}

struct ChangePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePasswordView(isShowingChangePasswordView: .constant(true))
            .environmentObject(UserViewModel())
    }
}
