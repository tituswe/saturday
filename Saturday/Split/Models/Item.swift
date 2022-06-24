//
//  Item.swift
//  Saturday
//
//  Created by Joshua Tan on 8/6/22.
//

import Foundation

struct Item: Identifiable {
    
    var id: String
    var name: String
    var price: Double
    
}


///// Represents a single receipt item.
//struct Item: Identifiable, Equatable {
//
//    /// Id of the item.
//    let id: UUID
//
//    /// A String representing the name of the item.
//    let name: String
//
//    /// A list of Friends representing the payers of the item.
//    var payers: [Friend]
//
//    /// A Double representing the price of the item.
//    var price: Double
//
//    /// An Int representing the quantity of the item.
//    var quantity: Int
//
//    /// Initialize an Item.
//    /// - Parameters:
//    ///  - id: id of the item.
//    ///  - name: a String representing the name of the item.
//    ///  - payers: a list of Friends representing the payers of the item; default empty.
//    ///  - price: a Double representing the price of the item.
//    ///  - quantity: an Int representing the quantity of the item.
//    init(id: UUID = UUID(), name: String = "", payers: [Friend] = [], price: Double = 0.0, quantity: Int = 1) {
//        self.id = id
//        self.name = name
//        self.payers = payers
//        self.price = price
//        self.quantity = quantity
//    }
//
//    /// Get the total price of the item.
//    /// - Returns: a Double representing the total price of the item.
//    func getItemTotal() -> Double {
//        return price * Double(quantity)
//    }
//
//    /// Get payers of the entry.
//    /// - Returns: a list of Friends representing the payers of the item.
//    func getPayers() -> [Friend] {
//        return payers
//    }
//
//    /// Add a new payer to the item.
//    /// - Parameter add: a Friend representing the new friend to be added.
//    mutating func addPayer(add: Friend) {
//        self.payers.append(add)
//    }
//
//    /// Remove a payer from the item.
//    /// - Parameter remove: a Friend representing the friend to be removed.
//    mutating func removePayer(remove: Friend) {
//        for i in 0...self.payers.count-1 {
//            if self.payers[i] == remove {
//                self.payers.remove(at: i)
//                return
//            }
//        }
//    }
//
//    /// Conforming to Equatable.
//    static func == (lhs: Item, rhs: Item) -> Bool {
//        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.payers == rhs.payers && lhs.price == rhs.price && lhs.quantity == rhs.quantity
//    }
//
//}
//
//
