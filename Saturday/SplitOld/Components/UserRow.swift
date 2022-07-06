//
//  UserRow.swift
//  Saturday2
//
//  Created by Titus Lowe on 29/6/22.
//

import SwiftUI

struct UserRow: View {

    @EnvironmentObject var cartManager: CartManager

//    let user: User

    var body: some View {

        HStack {

            Image("profilePicture")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 3))
                .frame(width: 64, height: 64)
                .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)

//            Text(user.name)
            Text("Titus Lowe")
                .bold()
                .font(.system(.body, design: .rounded))
                .padding()

            Spacer()

            Button {
                
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
        UserRow()
    }
}
