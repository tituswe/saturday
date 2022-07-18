//
//  Tracker.swift
//  Saturday
//
//  Created by Titus Lowe on 18/7/22.
//

import FirebaseFirestoreSwift

struct Tracker: Identifiable, Decodable {
    
    @DocumentID var id: String?
    var netMonthly: Double
    var netLifetime: Double
    var totalPayable: Double
    var totalReceivable: Double
    
}
