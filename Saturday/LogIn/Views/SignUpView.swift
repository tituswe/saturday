//
//  SignUpView.swift
//  Saturday
//
//  Created by Titus Lowe on 13/6/22.
//

import SwiftUI

struct SignUpView: View {
    
    @EnvironmentObject var user: UserLoginModel
    
    @State var name = ""
    
    @State var username = ""
    
    @State var email = ""
    
    @State var password = ""
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            SaturdayLogo()
                .frame(width: 300, height: 300, alignment: .center)
            
            VStack {
                
                TextField("Name", text: $name)
                    .multilineTextAlignment(.center)
                    .font(.system(.body, design: .rounded))
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(50)
                
                Spacer()
                    .frame(height: 10)
                
                TextField("Username", text: $username)
                    .multilineTextAlignment(.center)
                    .font(.system(.body, design: .rounded))
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(50)
                
                Spacer()
                    .frame(height: 10)
                
                TextField("Email", text: $email)
                    .multilineTextAlignment(.center)
                    .font(.system(.body, design: .rounded))
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(50)
                
                Spacer()
                    .frame(height: 10)
                
                SecureField("Password", text: $password)
                    .multilineTextAlignment(.center)
                    .font(.system(.body, design: .rounded))
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .padding()
                    .background(Color(.secondarySystemBackground))
                    .cornerRadius(50)
                
                Button(action: {
                    guard !email.isEmpty, !password.isEmpty else {
                        return
                    }
                    user.signUp(email: email, password: password, name: name, username: username)
                }, label: {
                    Text("Sign Up")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .background(Color.systemBlue)
                })
                .cornerRadius(50)
                .padding()
                
            }
            .padding(50)
            .navigationTitle("Sign Up")
            
        }
        .navigationBarHidden(true)
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(UserLoginModel())
    }
}
