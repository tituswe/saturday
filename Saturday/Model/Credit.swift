//
//  Credit.swift
//  Saturday
//
//  Created by Titus Lowe on 7/7/22.
//

import FirebaseFirestoreSwift

struct Credit: Identifiable, Decodable {
 
    @DocumentID var id: String?
    var transactionId: String
    let date: String
    let debtorId: String
    let total: Double
    
}
