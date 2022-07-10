//
//  Archive.swift
//  Saturday
//
//  Created by Titus Lowe on 10/7/22.
//

import Foundation
import FirebaseFirestoreSwift

struct Archive: Identifiable, Decodable {
 
    @DocumentID var id: String?
    var transactionId: String
    let debtorId: String?
    let creditorId: String?
    let dateIssued: String
    let dateSettled: String
    let total: Double
    let status: String
    let type: String
    
}
