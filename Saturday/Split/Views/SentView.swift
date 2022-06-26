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
        Text("fuck!")
        
        NavigationLink {
            HomeView()
                .environmentObject(user)
        } label: {
            Text("peepeepoopoo")
        }

    }
}

struct SentView_Previews: PreviewProvider {
    static var previews: some View {
        SentView()
            .environmentObject(UserLoginModel())
    }
}
