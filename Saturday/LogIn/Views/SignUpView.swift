//
//  SignUpView.swift
//  Saturday
//
//  Created by Titus Lowe on 13/6/22.
//

import SwiftUI

struct SignUpView: View {
    
    /// Stateful property that takes in the input for the email
    @State var email = ""
    
    /// Stateful property that takes in the input for the password
    @State var password = ""
    
    /// Stateful property that takes in the input for the password
    @State var name = ""
    
    @EnvironmentObject var user: UserLoginModel
    
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
                    
                    user.signUp(email: email, password: password, name: name)
                    
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
        }
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
            .environmentObject(UserLoginModel())
    }
}
