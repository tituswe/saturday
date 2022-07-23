//
//  AddUserRowView.swift
//  Saturday
//
//  Created by Titus Lowe on 6/7/22.
//

import SwiftUI
import Kingfisher

struct AddUserRowView: View {
    
    @EnvironmentObject var cartManager: CartManager

    let user: User
    
    var body: some View {
        
        HStack(spacing: 12) {
            
            KFImage(URL(string: user.profileImageUrl))
                .resizable()
                .scaledToFill()
                .clipShape(Circle())
                .frame(width: 48, height: 48)
            
            VStack(alignment: .leading, spacing: 2) {
                
                Text(user.id == cartManager.userSession?.uid ? "Me" : user.name)
                    .font(.subheadline)
                
                Text("@\(user.username)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
                Button {
                    cartManager.addPayableUser(user: user)
                    cartManager.transactions[user.id!] = Transaction(id: user.id!)
                } label: {
                    Text("Add")
                        .font(.system(size: 10))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 56, height: 24)
                        .background(Color.blue)
                        .cornerRadius(50)
                        .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
                }

        }
        .padding(.vertical, 8)
        .padding(.horizontal, 24)
        .background(Color.background)

    }
    
}

//struct AddUserRowView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddUserRowView(user: previewUser)
//            .environmentObject(CartManager())
//    }
//}
