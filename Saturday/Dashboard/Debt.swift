//
//  Debt.swift
//  Saturday2
//
//  Created by Titus Lowe on 30/6/22.
//

import Foundation

class Debt: Identifiable {
    
    let id = UUID()
    var name: String
    var date: Date = Date.now
    var creditor: User
    var debtor: User
    var itemList: [Item]
    var totalPayable: Double
    
    init(creditor: User, debtor: User, name: String, itemList: [Item], totalPayable: Double) {
        self.creditor = creditor
        self.debtor = debtor
        self.name = name
        self.itemList = itemList
        self.totalPayable = totalPayable
    }
    
}
