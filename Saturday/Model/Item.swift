//
//  Item.swift
//  Saturday
//
//  Created by Titus Lowe on 6/7/22.
//

import Foundation

struct Item: Identifiable {
    
    let id = UUID()
    let name: String
    let price: Double
    
}
