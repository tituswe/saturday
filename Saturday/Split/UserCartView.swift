//
//  UserCartView.swift
//  Saturday
//
//  Created by Titus Lowe on 8/7/22.
//

import SwiftUI

struct UserCartView: View {
    
    @EnvironmentObject var viewModel: UserViewModel
    
    @EnvironmentObject var cartManager: CartManager
    
    let user: User
    
    var body: some View {
        
        VStack {
            
            // MARK: Navigation Bar
            ZStack {
                LinearGradient(gradient: Gradient(colors: [Color.systemGreen, Color.background]), startPoint: .topLeading, endPoint: .bottomTrailing)
                
                NavBarView(
                    topLeftButtonView: "",
                    topRightButtonView: "",
                    titleString: "\(displayName()) Split",
                    topLeftButtonAction: {},
                    topRightButtonAction: {}
                )
            }
            .frame(height: 60)
            
            Spacer()
            
            ScrollView {
                
                LazyVStack {
                    
                    ForEach(cartManager.getTransactionItems(key: user.id!), id: \.id) { item in
                        ItemCardView(item: item, user: user, state: .DELETE)
                            .environmentObject(viewModel)
                            .environmentObject(cartManager)
                        Divider()
                    }
                    
                }
                
                Divider()
                
                HStack {
                    
                    Text("Total: $" + String(format: "%.2f", cartManager.getTransaction(key: user.id!).total))
                        .padding()
                    
                    Spacer()
                    
                }
                
            }
            
        }
        .ignoresSafeArea(.all, edges: [.bottom])
        
    }
    
    func displayName() -> String {
        let firstName = user.name.components(separatedBy: " ").first!
        if firstName.suffix(1) == "s" {
            return "\(firstName)'"
        } else {
            return "\(firstName)'s"
        }
    }
    
}

struct UserCartView_Previews: PreviewProvider {
    static var previews: some View {
        UserCartView(user: previewUser)
            .environmentObject(UserViewModel())
            .environmentObject(CartManager())
    }
}
