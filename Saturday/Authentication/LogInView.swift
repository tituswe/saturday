//
//  LogInView.swift
//  Saturday
//
//  Created by Joshua Tan on 10/6/22.
//

import SwiftUI

struct LogInView: View {
    
    @EnvironmentObject var viewModel: UserViewModel
    
    @State var email = ""
    
    @State var password = ""
    
    @State var isShowingSignUpView: Bool = false
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [Color.systemIndigo, Color.background]), startPoint: .topLeading, endPoint: .bottomTrailing)
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
                    topLeftButtonView: "",
                    topRightButtonView: "",
                    titleString: "",
                    topLeftButtonAction: {},
                    topRightButtonAction: {})
                
                Spacer()
            }
            
            VStack {
                
                Text("Login")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                
                TextField("Email", text: $email)
                    .multilineTextAlignment(.center)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(50)
                
                Spacer()
                    .frame(height: 10)
                
                SecureField("Password", text: $password)
                    .multilineTextAlignment(.center)
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .frame(width: 300, height: 50)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(50)
                
                Spacer()
                    .frame(height: 10)
                
                Button {
                    viewModel.login(withEmail: email, password: password)
                    viewModel.refresh()
                } label: {
                    Text("Login")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: 300, height: 50)
                        .background(Color.systemBlue)
                        .cornerRadius(50)
                }
                
                HStack {
                    Text("New around here?")
                        .font(.headline)
                    
                    Button {
                        isShowingSignUpView = true
                    } label: {
                        Text("Sign Up")
                            .foregroundColor(Color.systemBlue)
                            .font(.subheadline)
                    }
                    
                    NavigationLink(isActive: $isShowingSignUpView) {
                        SignUpView(isShowingSignUpView: $isShowingSignUpView)
                            .environmentObject(viewModel)
                            .navigationBarHidden(true)
                    } label: {}
                    
                }
                
            }
            
        }
        .onAppear {
            viewModel.reset()
        }
    }
}


struct LogInView_Previews: PreviewProvider {
    static var previews: some View {
        LogInView()
            .environmentObject(UserViewModel())
            .environment(\.colorScheme, .dark)
    }
}
