//
//  WelcomeView.swift
//  Saturday
//
//  Created by Joshua Tan on 13/6/22.
//

import SwiftUI

struct WelcomeView: View {
    @EnvironmentObject var user: UserLoginModel
    
    var body: some View {
        NavigationView {
            
            //Login View
            if user.signedIn {
                //Display Homepage
                
                Button(action: {
                    user.signOut()
                }, label: {
                    Text("Log Out")
                        .foregroundColor(Color.blue)
                })
            } else {
                LogInView()
                    .environmentObject(user)
            }
        }
        .onAppear(perform: {
            user.signedIn = user.isSignedIn()
        })
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
            .environmentObject(UserLoginModel())
    }
}
