//
//  User.swift
//  Saturday2
//
//  Created by Titus Lowe on 28/6/22.
//

import Foundation

class User: Identifiable, Equatable {
    
    let id = UUID()
    var username: String
    var name: String

    // MARK: Cart Manager
    var itemList: [Item] = []
    var totalPayable: Double = 0.00
    var isSelected: Bool = false
    
    // MARK: Database Manager
    @Published var friendList: [User]
    @Published var debtList: [Debt]
    @Published var creditList: [Debt]
    
    init(username: String, name: String, friendList: [User], debtList: [Debt], creditList: [Debt]) {
        self.username = username
        self.name = name
        self.friendList = friendList
        self.debtList = debtList
        self.creditList = creditList
    }
    
    func addItem(item: Item) {
        self.itemList.append(item)
        self.totalPayable += item.price
    }
    
    func removeItem(item: Item) {
        self.itemList = itemList.filter { $0.id != item.id }
        self.totalPayable -= item.price
    }
    
    static func == (lhs: User, rhs: User) -> Bool {
        return lhs.name == rhs.name && lhs.itemList == rhs.itemList && lhs.totalPayable == rhs.totalPayable && lhs.isSelected == rhs.isSelected
    }
    
}
