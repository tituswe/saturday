//
//  CartView.swift
//  Saturday
//
//  Created by Titus Lowe on 10/6/22.
//

import SwiftUI

struct CartView: View {
    
    @EnvironmentObject var cartManager: CartManager
    
    @State var cartNumber: Int
    
    var body: some View {
        VStack {
            Text("\(cartManager.carts[cartNumber].name)'s Cart")
                .font(.system(.title2, design: .rounded))
                .fontWeight(.bold)
            
            if cartManager.getItemCount(index: cartNumber) > 0 {
                ScrollView {
                    ForEach(cartManager.carts[cartNumber].items, id: \.id) { item in
                        ItemRow(selectedCart: cartNumber, item: item)
                    }
                    .animation(.easeOut)
                    
                    HStack {
                        Text("Your cart total is")
                            .font(.system(.body, design: .rounded))
                        
                        Spacer()
                        Text("$" + String(format: "%.2f", cartManager.carts[cartNumber].total))
                            .font(.system(.body, design: .rounded))
                            .fontWeight(.bold)
                    }
                    .padding()
                }
//                .navigationTitle(Text("\(cartManager.carts[cartNumber].name)'s Cart"))
                .padding(.top)
            } else {
                VStack {
                    Spacer()
                    Text("Your cart is empty")
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundColor(Color.gray)
                    Spacer()
                }
//                .navigationTitle(Text("\(cartManager.carts[cartNumber].name)'s Cart"))
                .padding(.top)
            }
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(cartNumber: 0)
            .environmentObject(CartManager(model: TextExtractionModel(referenceReceipt: UIImage(named: "receipt1")!), friends: friendList))
    }
}
