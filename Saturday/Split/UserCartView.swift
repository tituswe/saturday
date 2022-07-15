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
            NavBarView(
                topLeftButtonView: "",
                topRightButtonView: "",
                titleString: "\(displayName()) split",
                topLeftButtonAction: {},
                topRightButtonAction: {})
            
            Spacer()
            
            ScrollView {
                
                LazyVStack {
                    
                    ForEach(cartManager.getTransactionItems(key: user.id!), id: \.id) { item in
                        ItemCardView(item: item, state: .DELETE)
                            .environmentObject(viewModel)
                            .environmentObject(cartManager)
                        Divider()
                    }
                    
                }
                
                HStack {
                    
                    Text("Total: $" + String(format: "%.2f", cartManager.getTransaction(key: user.id!).total))
                        .font(.system(.body, design: .rounded))
                        .fontWeight(.semibold)
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
