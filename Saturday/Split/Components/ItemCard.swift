//
//  ItemCard.swift
//  Saturday
//
//  Created by Titus Lowe on 10/6/22.
//

import SwiftUI

struct ItemCard: View {
    
    @EnvironmentObject var cartManager: CartManager
    
    var item: Item
    
    var selectedCart: Int
    
    var body: some View {
        HStack {
            ZStack {
                VStack(alignment: .leading) {
                    Text(item.name)
                        .bold()
                        .font(.system(.body, design: .rounded))
                    
                    Text("$" + String(format: "%.2f", item.price))
                        .font(.system(.subheadline, design: .rounded))
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: 60)
                .background()
                .cornerRadius(20)
            }
            .frame(height: 50)
            .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
            
            Button {
                if (selectedCart == -1) {
                    return
                }
                cartManager.addToCart(index: selectedCart, item: item)
            } label: {
                Image(systemName: "plus")
                    .padding(10)
                    .foregroundColor(.white)
                    .background(Color.systemGreen)
                    .cornerRadius(50)
                    .padding(.leading)
            }
        }
        .padding()
    }
}

struct ItemCard_Previews: PreviewProvider {
    static var previews: some View {
        ItemCard(item: itemList[0], selectedCart: 0)
            .environmentObject(CartManager(items: itemList, friends: friendList))
    }
}
