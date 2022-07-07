//
//  CreditService.swift
//  Saturday
//
//  Created by Titus Lowe on 7/7/22.
//

import Foundation
import Firebase

struct CreditService {
    
    func fetchCredits(withUid uid: String, completion: @escaping([Credit]) -> Void) {
        Firestore.firestore().collection("credits")
            .document(uid)
            .collection("transactions")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let credits = documents.compactMap({ try? $0.data(as: Credit.self) })
                completion(credits)
            }
    }
    
    func fetchItems(withUid uid: String, transId: String, completion: @escaping([Item]) -> Void) {
        Firestore.firestore().collection("credits")
            .document(uid)
            .collection("transactions")
            .document(transId)
            .collection("items")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let items = documents.compactMap({ try? $0.data(as: Item.self) })
                completion(items)
            }
    }
}
