//
//  DatabaseManager.swift
//  Saturday
//
//  Created by Joshua Tan on 14/6/22.
//

import Foundation
import Firebase
import SwiftUI

class DatabaseManager: ObservableObject {
    
    func addUser(email: String, password: String, name: String) {
        
        let db = Firestore.firestore()
        
        db.collection("users").addDocument(data: ["email": email, "id": "\(UUID())","name": name, "password": password])
    }
    
    // TODO: NEED TO UPDATE FOR FRIEND FEATURE
    func addDebt(debtor: User, creditor: User, totalPayable: Double, itemList: [Item]) {
        
        let db = Firestore.firestore()
        
        db.collection("users").document(debtor.id).collection("debts").addDocument(data: ["creditorName": creditor.name, "creditorID": creditor.id, "totalPayable": totalPayable])
        
        for item in itemList {
            db.collection("users").document(debtor.id).collection("debts").document(creditor.id).collection("itemList").addDocument(data: ["itemName": item.name, "itemID": item.id, "price": item.price])
        }
    }
    
    //TODO: var user NOT PROERLY POINTING TO User OBJECT CREATED FROM DB RETRIEVAL
    func getUser(userDocumentID: String) -> User {
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(userDocumentID)
        
        var user: User = User(id: "", name: "nil found", email: "")
        
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                let temp = document.data().map { d in
                    return User(id: d["id"] as? String ?? "nil",
                             name: d["name"] as? String ?? "nil",
                             email: d["email"] as? String ?? "nil")
                }!
                print(temp.toString())
                user = temp
                print(user.toString())
            } else {
                print("Document does not exist")
            }
        }
        print(user.toString())
        return user
    }
    
    //TODO: userList PROBABLY NOT WOKRING EITHER
    func getAllUsers() -> [User] {
        let db = Firestore.firestore()
        var userList = [User]()
        
        db.collection("users").getDocuments(completion: { snapshot, error in
            
            //Check for errors
            if error == nil {
                //No errors
                
                if let snapshot = snapshot {
                    userList = snapshot.documents.map { document in
                        return User(id: document.documentID,
                                    name: document["name"] as? String ?? "",
                                    email: document["email"] as? String ?? "")
                    }
                }
                else {
                }
            }
        })
        
        return userList
    }
    
    func addFriend(target: User, friendEmail: String) {
        let db = Firestore.firestore()
        
        let userList = getAllUsers()
        
        var targetDocumentID: String?
        var friendDocumentID: String?
        var friend: User!
        
        for user in userList {
            if target.email == user.email {
                targetDocumentID = user.id
            }
            else if friendEmail == user.email {
                friendDocumentID = user.id
                friend = getUser(userDocumentID: friendDocumentID ?? "")
            }
        }
        
        db.collection("users").document(targetDocumentID ?? "").collection("friends").addDocument(data: [
            "email": friend.email,
            "id": friend.id,
            "name": friend.name
        ])
    }
}
