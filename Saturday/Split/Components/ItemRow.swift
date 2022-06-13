//
//  ItemRow.swift
//  Saturday
//
//  Created by Titus Lowe on 10/6/22.
//

import SwiftUI

struct ItemRow: View {
    
    @EnvironmentObject var cartManager: CartManager
    
    var selectedCart: Int
    
    var item: Item
    
    @State private var scale = 1.0
    
    var body: some View {
        HStack(spacing: 20) {
            RoundedRectangle(cornerSize: .zero)
                .aspectRatio(contentMode: .fit)
                .frame(width: 50)
                .cornerRadius(10)
                .foregroundColor(.gray)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(item.name)
                    .font(.system(.body, design: .rounded))
                    .bold()
                
                Text("$" + String(format: "%.2f", item.price))
                    .font(.system(.subheadline, design: .rounded))
            }
            
            Spacer()
            Button {
                withAnimation(.easeOut(duration: 0.2)) {
                    cartManager.removeFromCart(index: selectedCart, item: item)
                }
            } label: {
                Image(systemName: "trash")
                    .foregroundColor(Color.systemRed)
            }

          
        }
        .padding(.horizontal)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ItemRow_Previews: PreviewProvider {
    static var previews: some View {
        ItemRow(selectedCart: 0, item: itemList[3])
            .environmentObject(CartManager(items: itemList, friends: friendList))
    }
}
