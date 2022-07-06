//
//  ItemCardView.swift
//  Saturday
//
//  Created by Titus Lowe on 6/7/22.
//

import SwiftUI

struct ItemCardView: View {
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    @EnvironmentObject var cartManager: CartManager
    
    let item: Item
    
    var body: some View {
        
        HStack {
            
            VStack(alignment: .leading) {
                
                Text(item.name)
                    .font(.system(.body, design: .rounded))
                    .fontWeight(.semibold)
                
                Spacer()
                    .frame(height: 1.6)
                
                Text("$" + String(format: "%.2f", item.price))
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.gray)
            }
            .padding(.leading, 8)
            
            Spacer()
            
            Button {
                cartManager.addItemToDebt(item: item)
            } label: {
                Image(systemName: "plus")
                    .padding(8)
                    .foregroundColor(.white)
                    .background(Color.systemBlue)
                    .cornerRadius(20)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
            }
            
        }
        .padding(.horizontal, 24)
        .frame(height: 56)
        
    }
    
}

struct ItemCardView_Previews: PreviewProvider {
    static var previews: some View {
        ItemCardView(item: previewItem)
            .environmentObject(AuthenticationViewModel())
            .environmentObject(CartManager())
    }
}
