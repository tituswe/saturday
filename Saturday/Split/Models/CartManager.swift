//
//  CartManager.swift
//  Saturday
//
//  Created by Titus Lowe on 10/6/22.
//

import Foundation

class CartManager: ObservableObject {
    
    private var model: TextExtractionModel
    @Published private(set) var items: [Item]
    @Published private(set) var friends: [String]
    @Published private(set) var carts: [Cart] = []
    
    init(model: TextExtractionModel, friends: [String]) {
        self.model = model
        self.items = model.extractItems()
        self.friends = friends
        for i in 0..<friends.count {
            self.carts.append(Cart(index: i, name: friends[i]))
        }
    }
    
    func getName(index: Int) -> String {
        return carts[index].name
    }
    
    func getItemCount(index: Int) -> Int {
        return carts[index].getItemCount()
    }
    
    func addToCart(index: Int, item: Item) {
        carts[index].addItem(item: item)
        items = items.filter { $0.id != item.id }
    }

    func removeFromCart(index: Int, item: Item) {
        carts[index].removeItem(item: item)
        items.append(item)
    }
}

class Cart: ObservableObject, Identifiable {
    let index: Int
    let name: String
    @Published private(set) var items: [Item] = []
    @Published private(set) var total: Double = 0.00
    
    init(index: Int, name: String) {
        self.index = index
        self.name = name
    }
    
    func getItemCount() -> Int {
        return items.count
    }
    
    func addItem(item: Item) {
        items.append(item)
        total += item.price
    }
    
    func removeItem(item: Item) {
        items = items.filter { $0.id != item.id }
        total -= item.price
    }
}
