//
//  CartManager.swift
//  Saturday
//
//  Created by Titus Lowe on 10/6/22.
//

import Foundation

class CartManager: ObservableObject {
    
    @Published private(set) var items: [Item]
    @Published private(set) var friends: [String]
    @Published private(set) var carts: [Cart] = []
    
    init(items: [Item], friends: [String]) {
        self.items = items
        self.friends = friends
        for i in 0..<friends.count {
            print(i)
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


//class CartManager: ObservableObject {
//    var name: String
//    @Published private(set) var items: [Item] = []
//    @Published private(set) var total: Double = 0.00
//
//    init(name: String) {
//        self.name = name
//    }
//
//    func addToCart(item: Item) {
//        items.append(item)
//        total += item.price
//    }
//
//    func removeFromCart(item: Item) {
//        items = items.filter { $0.id != item.id }
//        total -= item.price
//    }
//}
