//
//  SentView.swift
//  Saturday
//
//  Created by Titus Lowe on 27/6/22.
//

import SwiftUI

struct SentView: View {
    
    @EnvironmentObject var user: UserLoginModel
    
    var body: some View {
        VStack {
            Text("Split Sent!")
                .padding()
            
            NavigationLink {
                HomeView()
                    .environmentObject(user)
            } label: {
                Text("Return to Dashboard")
                    .font(.system(.body, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .frame(width: 200, height: 50)
                    .background(Color.systemBlue)
                    .cornerRadius(50)
                    .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
                    .padding()
            }
        }
        .navigationBarHidden(true)
    }
}

struct SentView_Previews: PreviewProvider {
    static var previews: some View {
        SentView()
            .environmentObject(UserLoginModel())
    }
}
