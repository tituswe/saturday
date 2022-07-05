//
//  UserRowView.swift
//  Saturday
//
//  Created by Titus Lowe on 6/7/22.
//

import SwiftUI
import Kingfisher

enum RequestState {
    
    case SEND
    case RECEIVE
    
}

struct UserRowView: View {
    
    @EnvironmentObject var authenticationViewModel: AuthenticationViewModel

    let user: User
    
    @State var state: RequestState = .SEND
    
    var body: some View {
        
        HStack(spacing: 12) {
            
            KFImage(URL(string: user.profileImageUrl))
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: 56, height: 56)
            
            VStack(alignment: .leading, spacing: 4) {
                
                Text(user.name)
                    .font(.system(.subheadline, design: .rounded))
                    .fontWeight(.bold)
                
                Text("@\(user.username)")
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            if state == .SEND {
                Button {
                    authenticationViewModel.sendFriendRequest(user: user)
                } label: {
                    Text("Add Friend")
                        .font(.system(.caption2, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 100, height: 30)
                        .background(Color.systemBlue)
                        .cornerRadius(50)
                        .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
                }
            } else if state == .RECEIVE {
                Button {
                    print("DEBUG: Accept request...")
                } label: {
                    Text("Accept")
                        .font(.system(.caption2, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 100, height: 30)
                        .background(Color.systemBlue)
                        .cornerRadius(50)
                        .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
                }
            }
            

        }
        .padding()

    }
    
}

//struct UserRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserRowView()
//    }
//}
