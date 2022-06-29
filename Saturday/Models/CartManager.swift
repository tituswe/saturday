//
//  CartManager.swift
//  Saturday2
//
//  Created by Titus Lowe on 28/6/22.
//

import Foundation

class CartManager: ObservableObject {
    
    @Published var itemList: [Item] = []
    @Published var userList: [User] = []
    @Published var selectedUser: User?
    
    init() {
        
    }
    
    init(itemList: [Item], userList: [User]) {
        self.itemList = itemList
        self.userList = userList
    }
    
    func selectNone() {
        for user in self.userList {
            user.isSelected = false
        }
    }
    
    func selectUser(user: User) {
        for user in self.userList {
            user.isSelected = false
        }
        user.isSelected = true
        selectedUser = user
    }
    
    func addItem(user: User?, item: Item) {
        if user != nil {
            user!.addItem(item: item)
            self.itemList = self.itemList.filter { $0.id != item.id }
        }
    }
    
    func addItemList(itemList: [Item]) {
        self.itemList = itemList
    }
    
    func removeItem(user: User?, item: Item) {
        if user != nil {
            user!.removeItem(item: item)
            self.itemList.append(item)
        }
    }
    
    func addUser(user: User) {
        self.userList.append(user)
    }
    
    func removeUser(user: User) {
        if (user == self.selectedUser) {
            self.selectedUser = nil
            user.isSelected.toggle()
        }
        for item in user.itemList {
            removeItem(user: user, item: item)
        }
        self.userList = self.userList.filter { $0.id != user.id }
    }
}
