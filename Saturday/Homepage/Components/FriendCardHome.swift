//
//  FriendCardHome.swift
//  Saturday
//
//  Created by Joshua Tan on 21/6/22.
//

import SwiftUI

struct FriendCardHome: View {
    
    var friend: User
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading) {
                HStack {
                    //Spacer()
                    Text(friend.name)
                        .font(.system(.body, design: .rounded))
                        .fontWeight(.bold)
                        .padding()
                }
            }
        }
    }
}

struct FriendCardHome_Previews: PreviewProvider {
    static var previews: some View {
        FriendCardHome(friend: friendListU[0])
    }
}
