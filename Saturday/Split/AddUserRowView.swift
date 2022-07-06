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
            
                Button {
                    cartManager.addPayableUser(user: user)
                    cartManager.debts[user.id!] = Debt(id: user.id!)
                } label: {
                    Text("Add")
                        .font(.system(.caption2, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 60, height: 30)
                        .background(Color.systemBlue)
                        .cornerRadius(50)
                        .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
                }

        }
        .padding()

    }
    
}

struct AddUserRowView_Previews: PreviewProvider {
    static var previews: some View {
        AddUserRowView(user: previewUser)
            .environmentObject(CartManager())
    }
}
