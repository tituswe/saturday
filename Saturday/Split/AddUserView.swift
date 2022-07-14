//
//  AddUserView.swift
//  Saturday
//
//  Created by Titus Lowe on 29/6/22.
//

import SwiftUI

struct AddUserView: View {

    @EnvironmentObject var viewModel: UserViewModel
    
    @EnvironmentObject var cartManager: CartManager

    var body: some View {
        
        VStack {
            
            // MARK: Navigation Bar
            NavbarView(
                topLeftButtonView: "",
                topRightButtonView: "",
                titleString: "Add friends to split",
                topLeftButtonAction: {},
                topRightButtonAction: {}
            )
            
            Spacer()
            
            ScrollView {
                
                LazyVStack {
                    
                    ForEach(cartManager.allUsers) { user in
                        
                        AddUserRowView(user: user)
                            .environmentObject(cartManager)
                        
                        Divider()
                        
                    }
                    
                }
                
            }
            
        }
        .background(Color.background)
        
    }
}

struct AddUserView_Previews: PreviewProvider {
    static var previews: some View {
        AddUserView()
            .environmentObject(UserViewModel())
            .environmentObject(CartManager())
            .environment(\.colorScheme, .dark)
    }
}
