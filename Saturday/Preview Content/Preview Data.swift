//
//  Datasets.swift
//  Saturday
//
//  Created by Joshua Tan on 11/6/22.
//

import Foundation

var previewItem: Item = Item(name: "Apple", price: 0.50)

var previewItemList: [Item] = [
    Item(name: "Apple", price: 0.50),
    Item(name: "Banana", price: 1.00),
    Item(name: "Cherry", price: 1.50)
]

var previewUser: User = User(username: "tester1", name: "Titus", friendList: [], debtList: [], creditList: [])

var previewUserList: [User] = [
    User(username: "tester1", name: "Titus", friendList: [], debtList: [], creditList: []),
    User(username: "tester2", name: "Josh", friendList: [], debtList: [], creditList: []),
    User(username: "tester3", name: "Kyron", friendList: [], debtList: [], creditList: []),
    User(username: "tester4", name: "Yuze", friendList: [], debtList: [], creditList: [])
]

var previewCartManager: CartManager = CartManager(itemList: previewItemList, userList: previewUserList)

var previewDatabaseManager: DatabaseManager = DatabaseManager(userList: previewUserList)

var tituswe: User = User(username: "tituswe", name: "Titus", friendList: [], debtList: [], creditList: [])
var Joshua_TYH: User = User(username: "Joshua_TYH", name: "Joshua", friendList: [], debtList: [], creditList: [])
var kyteorite: User = User(username: "kyteorite", name: "Kyron", friendList: [], debtList: [], creditList: [])
