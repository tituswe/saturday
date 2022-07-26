//
//  ChangeEmailView.swift
//  Saturday
//
//  Created by Titus Lowe on 26/7/22.
//

import SwiftUI
import Kingfisher

struct ChangeEmailView: View {
    
    @EnvironmentObject var viewModel: UserViewModel
    
    @Binding var isShowingChangeEmailView: Bool
    
    @State var isSecured: Bool = true
    
    @State var oldEmail = ""
        
    @State var newEmail = ""
    
    @State var password = ""
    
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
                        isShowingChangeEmailView = false
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
                
                Text("Change Email")
                    .font(.title3)
                
                TextField("Enter your current email", text: $oldEmail)
                    .font(.system(size: 16))
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
                    .background(Color.black.opacity(0.05))
                    .frame(width: 240, height: 48)
                    .cornerRadius(25)
                    .focused($isFocused)
                
                TextField("Enter your new email", text: $newEmail)
                    .font(.system(size: 16))
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 8)
                    .background(Color.black.opacity(0.05))
                    .frame(width: 240, height: 48)
                    .cornerRadius(25)
                    .focused($isFocused)
                
                if isSecured {
                    SecureField("Enter your password", text: $password)
                        .font(.system(size: 16))
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)
                        .background(Color.black.opacity(0.05))
                        .frame(width: 240, height: 48)
                        .cornerRadius(25)
                        .focused($isFocused)
                } else {
                    TextField("Enter your password", text: $password)
                        .font(.system(size: 16))
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
                            viewModel.updateEmail(withEmail: newEmail, oldEmail: oldEmail, password: password)
                            viewModel.refresh()
                            isShowingChangeEmailView = false
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
        return newEmail != "" && oldEmail != "" && password != ""
    }
}

struct ChangeEmailView_Previews: PreviewProvider {
    static var previews: some View {
        ChangeEmailView(isShowingChangeEmailView: .constant(true))
            .environmentObject(UserViewModel())
    }
}
