//
//  Item.swift
//  Saturday
//
//  Created by Titus Lowe on 6/7/22.
//

import FirebaseFirestoreSwift

struct Item: Identifiable, Decodable {
    
    @DocumentID var id: String?
    let name: String
    var price: Double
    var noOfDuplicates: Int = 1
    
}
