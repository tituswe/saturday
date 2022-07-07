//
//  UserCardView.swift
//  Saturday
//
//  Created by Titus Lowe on 6/7/22.
//

import SwiftUI
import Kingfisher

struct UserCardView: View {
    
    @EnvironmentObject var viewModel: UserViewModel
    
    @EnvironmentObject var cartManager: CartManager
    
    let user: User
    
    @State var isShowingDeleteButton: Bool = false
    
    @State var isShowingUserCartView: Bool = false
    
    var body: some View {
        
        VStack {
            
            ZStack {
                
                // Long press to change to red x, for deleting
                KFImage(URL(string: user.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 64, height: 64)
                    .overlay(Circle()
                        .stroke(isShowingDeleteButton
                                ? Color.systemRed.opacity(0.8)
                                : cartManager.selectedMap[user.id!] ?? false
                                ? Color.systemBlue.opacity(0.8)
                                : Color.clear, lineWidth: 5))
                    .onTapGesture {
                        cartManager.selectUser(user: user)
                    }
                    .onLongPressGesture {
                        isShowingDeleteButton.toggle()
                    }
                    
                
                // Item counter/Button to Cart View
                if isShowingDeleteButton {
                    
                    Button {
                        self.isShowingDeleteButton = false
                        cartManager.removePayableUser(user: user)
                    } label: {
                        ZStack {
                            Circle()
                                .frame(width: 24, height: 24)
                                .foregroundColor(Color.systemRed)
                            
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 10, height: 10)
                                .foregroundColor(.white)
                                
                        }
                    }
                    .offset(x: 40, y: -32)
                    
                } else if cartManager.getTransactionItemsCount(key: user.id!) > 0 {
                    
                    Button {
                        cartManager.selectUser(user: user)
                        isShowingUserCartView = true
                    } label: {
                        ZStack {
                            Circle()
                                .frame(width: 24, height: 24)
                                .foregroundColor(Color.systemBlue)
                            
                            Text("\(cartManager.getTransactionItemsCount(key: user.id!))")
                                .font(.caption).bold()
                                .foregroundColor(.white)
                        }
                    }
                    .offset(x: 40, y: -32)
                    
                }
                
            }
            .sheet(isPresented: $isShowingUserCartView) {
                UserCartView(user: user)
                    .environmentObject(viewModel)
                    .environmentObject(cartManager)
            }
            
            Text(user.name.components(separatedBy: " ").first!)
                .font(.system(.body, design: .rounded))
                .fontWeight(.semibold)
            
        }
        .padding(.top)
        .padding(.horizontal)
    }
    
}

struct UserCardView_Previews: PreviewProvider {
    static var previews: some View {
        UserCardView(user: previewUser)
            .environmentObject(UserViewModel())
            .environmentObject(CartManager(transactions: [previewUser.id!: Transaction(id: previewUser.id!)]))
    }
}
