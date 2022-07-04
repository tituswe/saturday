//
//  FirestoreManager.swift
//  Saturday
//
//  Created by Joshua Tan on 30/6/22.
//

import Foundation
import Firebase

class FirestoreManager: ObservableObject {
    
    let db = Firestore.firestore()
    
    func addUser(email: String, name: String, username: String) {
        
        let usersRef = db.collection("users")
        
        usersRef.document("\(username)").setData([
            "name" : name,
            "email" : email,
            "id" : "\(UUID())",
            "username" : username,
            "friendList" : []
        ])
    }
    
    func addFriend(selfUsername: String, friendUsername: String) {
        // Add friend to self's friendList
        let selfRef = db.collection("users").document("\(selfUsername)")
        
        selfRef.updateData([
            "friendList" : FieldValue.arrayUnion(["\(friendUsername)"])
        ])
        
        // Add to self to friend's friendList
        let friendRef = db.collection("users").document("\(friendUsername)")
        
        friendRef.updateData([
            "friendList" : FieldValue.arrayUnion(["\(selfUsername)"])
        ])
    }
    
    // TODO: Create an array of Debts in the Cart Manager, then just pump it into the Firestore. Will auto put in nicely lol
    // Call
    func addDebt(debt: Debt) {
        let debtorUsername = debt.debtor.username
        let creditorUsername = debt.creditor.username
        // Add DEBT to debtor
        let debtorRef = db.collection("users").document("\(debtorUsername)")
        
        debtorRef.collection("debtList").document("\(debt.id)").setData([
            "id" : "\(debt.id)",
            "date" : debt.date,
            "debtor" : debtorUsername,
            "creditor" : creditorUsername,
            "name" : debt.name,
            "totalPayable" : debt.totalPayable
        ])
        
        // Add itemList
        let debtorItemListRef = debtorRef.collection("debtList").document("\(debt.id)").collection("itemList")
        
        for item in debt.itemList {
            debtorItemListRef.document("\(item.id)").setData([
                "id" : "\(item.id)",
                "name" : item.name,
                "price" : item.price
            ])
        }
        
        // Add CREDIT to creditor
        let creditorRef = db.collection("users").document("\(creditorUsername)")
        
        creditorRef.collection("creditList").document("\(debt.id)").setData([
            "id" : "\(debt.id)",
            "date" : debt.date,
            "debtor" : debtorUsername,
            "creditor" : creditorUsername,
            "name" : debt.name,
            "totalPayable" : debt.totalPayable
        ])
        
        // Add itemList
        let creditorItemListRef = creditorRef.collection("creditList").document("\(debt.id)").collection("itemList")
        
        for item in debt.itemList {
            creditorItemListRef.document("\(item.id)").setData([
                "id" : "\(item.id)",
                "name" : item.name,
                "price" : item.price
            ])
        }
    }
}
