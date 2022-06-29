//
//  ItemCard.swift
//  Saturday2
//
//  Created by Titus Lowe on 28/6/22.
//

import SwiftUI

struct ItemCard: View {
    
    @EnvironmentObject var cartManager: CartManager
    
    let item: Item
    
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
                cartManager.addItem(user: cartManager.selectedUser, item: item)
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

struct ItemCard_Previews: PreviewProvider {
    static var previews: some View {
        ItemCard(item: previewItem)
            .environmentObject(CartManager())
    }
}
