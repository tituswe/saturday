//
//  Friend.swift
//  Saturday
//
//  Created by Joshua Tan on 8/6/22.
//

import Foundation

/// Represents a friend.
struct Friend: Identifiable, Equatable {
    
    /// Id of the friend.
    let id: UUID
    
    /// A String representing the name of the friend.
    var name: String
    
    /// A list of Items representing the Items to be payed by the friend.
    var items: [Item]
    
    /// A Double representing the total amount to be payed by the friend.
    var totalPayable: Double
    
    /// Initialize a Friend.
    /// - Parameters:
    ///  - id: id of the friend.
    ///  - name: a String representing the name of the friend.
    ///  - items: a list of Items representing the items to be payed by the friend.
    ///  - totalPayable: a Double representing the total amount to to be payed by the friend,
    init(id: UUID = UUID(), name: String = "", items: [Item] = [], totalPayable: Double = 0) {
        self.id = id
        self.name = name
        self.items = items
        self.totalPayable = totalPayable
    }
    
    /// Add an item to the list of items payable.
    /// - Parameter add: an Item representing the item to be added.
    mutating func addItem(add: Item) {
        self.items.append(add)
        totalPayable += add.price
    }
    
    /// Remove an item from the list of items payable.
    /// - Parameter remove: an Item representing the item to be removed.
    mutating func removeItem(remove: Item) {
        for i in 0...self.items.count-1 {
            if self.items[i] == remove {
                self.items.remove(at: i)
                totalPayable -= remove.price
                return
            }
        }
    }
    
    /// Calculate total amount payable.
    /// - Returns: a Double representing the total amount payable.
    func calculateTotalPayable() -> Double {
        var total: Double = 0
        
        for item in items {
            total += item.price
        }
        return total
    }
    
    /// Conforming to Equatable.
    static func == (lhs: Friend, rhs: Friend) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name && lhs.items == rhs.items && lhs.totalPayable == rhs.totalPayable
    }
    
//    func insertItem(itemProviders: [NSItemProvider], itemPrice: Double) {
//        for item in itemProviders.reversed() {
//
//            item.loadObject(ofClass: UIImage.self) { image, error in
//                if let _ = image as? UIImage {
//
//                    DispatchQueue.main.async {
//                        self.totalPayable += itemPrice
//                    }
//                }
//            }
//        }
//    }
    
}

extension Friend {
    static var sample: Friend = Friend(name: "Titus")
}
