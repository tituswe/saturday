//
//  DebtService.swift
//  Saturday
//
//  Created by Titus Lowe on 7/7/22.
//

import Foundation
import Firebase

struct DebtService {
    
    //MARK: Original methods
    func fetchDebts(withUid uid: String, completion: @escaping([Debt]) -> Void) {
        Firestore.firestore().collection("debts")
            .document(uid)
            .collection("transactions")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let debts = documents.compactMap({ try? $0.data(as: Debt.self) })
                completion(debts)
            }
    }
    
    func fetchItems(withUid uid: String, transId: String, completion: @escaping([Item]) -> Void) {
        Firestore.firestore().collection("debts")
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
