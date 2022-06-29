//
//  Item.swift
//  Saturday2
//
//  Created by Titus Lowe on 28/6/22.
//

import Foundation

class Item: Identifiable, Equatable {
    
    let id = UUID()
    var name: String
    var price: Double
    
    init(name: String, price: Double) {
        self.name = name
        self.price = price
    }
    
    static func == (lhs: Item, rhs: Item) -> Bool {
        return lhs.name == rhs.name && lhs.price == rhs.price
    }
}
