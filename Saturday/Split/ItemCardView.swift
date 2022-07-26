//
//  ItemCardView.swift
//  Saturday
//
//  Created by Titus Lowe on 6/7/22.
//

import SwiftUI

enum ItemState {
    
    case ADD
    case VIEW
    case DELETE
    
}

struct ItemCardView: View {
    
    @EnvironmentObject var viewModel: UserViewModel
    
    @EnvironmentObject var cartManager: CartManager
    
    let item: Item
    
    var user: User?
    
    @State var state: ItemState = .ADD
    
    var body: some View {
        
        HStack {
            
            VStack(alignment: .leading) {
                
                Text(item.name)
                    .font(.system(size: 14))
                
                Spacer()
                    .frame(height: 1.6)
                
                HStack {
                    Text("$" + String(format: "%.2f", item.price))
                        .font(.system(size: 12))
                        .foregroundColor(Color.gray)
                    
                    Text(item.noOfDuplicates > 1 ? "(Shared by \(item.noOfDuplicates) friends)" : "")
                        .font(.system(size: 12))
                        .foregroundColor(Color.gray)
                }
            }
            .padding(.leading, 8)
            
            Spacer()
            
            if state == .ADD {
                Button {
                    cartManager.addItemToTransaction(item: item)
                } label: {
                    ZStack {
                        Circle()
                            .foregroundColor(Color.systemBlue)
                            .frame(width: 24, height: 24)
                        Image(systemName: "plus")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                    }
                }
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
            } else if state == .DELETE {
                Button {
                    cartManager.removeItemFromTransaction(item: item, user: user!)
                } label: {
                    ZStack {
                        Circle()
                            .foregroundColor(Color.systemRed)
                            .frame(width: 24, height: 24)
                        Image(systemName: "minus")
                            .font(.system(size: 14))
                            .foregroundColor(.white)
                    }
                }
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
            }
            
        }
        .padding(.horizontal, 24)
        .frame(height: 48)
        
    }
    
}

struct ItemCardView_Previews: PreviewProvider {
    static var previews: some View {
        ItemCardView(item: previewItem)
            .environmentObject(UserViewModel())
            .environmentObject(CartManager())
    }
}
