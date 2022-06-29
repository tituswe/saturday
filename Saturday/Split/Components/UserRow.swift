//
//  UserRow.swift
//  Saturday2
//
//  Created by Titus Lowe on 29/6/22.
//

import SwiftUI

struct UserRow: View {
    
    @EnvironmentObject var databaseManager: DatabaseManager
    
    @EnvironmentObject var cartManager: CartManager
    
    let user: User
    
    var body: some View {
        
        HStack {
            
            Image("saturdayIcon")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .frame(width: 50, height: 50)
                .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
                .padding(.trailing)

            Text(user.name)
                .bold()
                .font(.system(.body, design: .rounded))
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 60)
                .background()
                .cornerRadius(20)
                .frame(height: 50)
                .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
            
            Button {
                cartManager.addUser(user: user)
                databaseManager.removeUser(user: user)
            } label: {
                Image(systemName: "plus")
                    .padding(10)
                    .foregroundColor(.white)
                    .background(Color.systemGreen)
                    .cornerRadius(50)
                    .padding(.leading)
                    .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
            }
            
        }
        .padding()
        
    }
    
}

struct UserRow_Previews: PreviewProvider {
    static var previews: some View {
        UserRow(user: previewUser)
            .environmentObject(previewDatabaseManager)
            .environmentObject(previewCartManager)
    }
}
