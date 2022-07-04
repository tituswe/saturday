//
//  AddUserView.swift
//  Saturday2
//
//  Created by Titus Lowe on 29/6/22.
//

import SwiftUI

struct AddUserView: View {
    
    @EnvironmentObject var databaseManager: DatabaseManager
    
    @EnvironmentObject var cartManager: CartManager
    
    @State private var searchText = ""
    
    var body: some View {
        
        VStack {
            
            // MARK: Navigation Bar
            NavbarView(
                topLeftButtonView: "",
                topRightButtonView: "",
                titleString: "Add Users",
                topLeftButtonAction: {},
                topRightButtonAction: {})
            
            // MARK: Search Bar
            TextField(text: $searchText) {
                Text("Find a friend")
            }
            .multilineTextAlignment(.center)
            .padding()
            .background()
            .cornerRadius(50)
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
            .padding()
            
            // MARK: User List
            ScrollView {
                
                ForEach(searchResults, id: \.id) { user in
                    UserRow(user: user)
                        .environmentObject(databaseManager)
                        .environmentObject(cartManager)
                    Divider()
                }
                .searchable(text: $searchText)
                
            }
            
        }
        
    }
    
    var searchResults: [User] {
        if searchText.isEmpty {
            return databaseManager.userList
        } else {
            return databaseManager.userList.filter { $0.name.contains(searchText) }
        }
    }
}

struct AddUserView_Previews: PreviewProvider {
    static var previews: some View {
        AddUserView()
            .environmentObject(previewDatabaseManager)
            .environmentObject(previewCartManager)
    }
}
