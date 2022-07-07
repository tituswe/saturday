//
//  Debt.swift
//  Saturday2
//
//  Created by Titus Lowe on 30/6/22.
//

import Foundation

struct Transaction: Identifiable {
    
    var id: String
    let transactionId = UUID().uuidString
    let date: String
    var total: Double = 0.0
    var items: [Item] = [Item]()
    
    init(id: String) {
        self.id = id
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm E, d MMM y"
        self.date = formatter.string(from: Date.now)
    }
    
    mutating func addItem(item: Item) {
        self.items.append(item)
        self.total += item.price
    }
    
    mutating func removeItem(item: Item) {
        self.items = self.items.filter { $0.id != item.id }
        self.total -= item.price
    }
    
    func getItems() -> [Item] {
        return self.items
    }
}
