//
//  CartButton.swift
//  Saturday
//
//  Created by Titus Lowe on 10/6/22.
//

import SwiftUI

struct FriendCard: View {
    
    @EnvironmentObject var cartManager: CartManager
    
    let name: String
   
    let cartNumber: Int
    
    var numberOfProducts: Int
    
    @Binding var isSelected: Bool
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            VStack(alignment: .leading) {
                HStack {
                    Spacer()
                    Text(name)
                        .font(.system(.body, design: .rounded))
                        .fontWeight(.bold)
                        .padding()
                }
                Spacer()
                Text("Total")
                    .foregroundColor(isSelected ? .white : .black)
                    .font(.system(.footnote, design: .rounded))
                    .padding(.leading)
                HStack(alignment: .center) {
                    Text("SGD")
                        .foregroundColor(isSelected ? .white : .black)
                        .font(.system(.footnote, design: .rounded))
                    Text("$" + String(format: "%.2f", cartManager.carts[cartNumber].total))
                        .foregroundColor(isSelected ? .white : .black)
                        .font(.system(.headline, design: .rounded))
                        .fontWeight(.bold)
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .frame(width: 125, height: 125)
            .background(isSelected ? Color.systemBlue : Color.white)
            .cornerRadius(20)
            .padding(10)
            .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
            
            if numberOfProducts > 0 {
                Text("\(numberOfProducts)")
                    .font(.caption).bold()
                    .foregroundColor(.white)
                    .frame(width: 30, height: 30)
                    .background(Color.systemRed)
                    .cornerRadius(50)
            }
        }
    }
}

//struct FriendCard_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            FriendCard(name: "Titus", cartNumber: 0, numberOfProducts: 1, isSelected: .constant(true))
//                .environmentObject(CartManager(items: itemList, friends: friendList))
//                .previewLayout(.sizeThatFits)
//            FriendCard(name: "Titus", cartNumber: 0, numberOfProducts: 1, isSelected: .constant(false))
//                .environmentObject(CartManager(items: itemList, friends: friendList))
//                .previewLayout(.sizeThatFits)
//        }
//    }
//}
