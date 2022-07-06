//
//  Debt.swift
//  Saturday2
//
//  Created by Titus Lowe on 30/6/22.
//

import Foundation

struct Debt: Identifiable {
    
    var id: String
    let debtId = UUID()
    let date: String = ISO8601DateFormatter().string(from: Date.now)
    var total: Double = 0.0
    var items: [Item] = [Item]()
    
    mutating func addItem(item: Item) {
        self.items.append(item)
        self.total += item.price
    }
    
    func getItems() -> [Item] {
        return self.items
    }
}
