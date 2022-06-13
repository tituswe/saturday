//
//  DatabaseManager.swift
//  Saturday
//
//  Created by Joshua Tan on 14/6/22.
//

import Foundation
import Firebase

class DatabaseManager: ObservableObject {
    
    func addUser(email: String, password: String, name: String) {
       
        let db = Firestore.firestore()
        
        db.collection("users").addDocument(data: ["email": email, "id": "\(UUID())","name": name, "password": password])
    }
   
    // TODO: NEED TO UPDATE FOR FRIEND FEATURE
    func addDebt(debtor: User, creditor: User, totalPayable: Double) {
        
        let db = Firestore.firestore()
        
        db.collection("users").document(debtor.id).collection("debts").addDocument(data: ["creditorName": creditor.name, "totalPayable": totalPayable])
    }
}
