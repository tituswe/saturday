//
//  DatabaseManager.swift
//  Saturday2
//
//  Created by Titus Lowe on 29/6/22.
//

import Foundation
import Firebase

class DatabaseManager: ObservableObject {
    
    @Published private(set) var userList: [User] = []

    init() { }
    
    init(userList: [User]) {
//        // TODO: Read Users from Firebase
//        let db = Firestore.firestore()
//        var userList = [User]()
//
//        db.collection("users").getDocuments(completion: { snapshot, error in
//
//            //Check for errors
//            if error == nil {
//                //No errors
//
//                if let snapshot = snapshot {
//                    userList = snapshot.documents.map { document in
//                        return User(username: document["username"] as? String ?? "",
//                                    name: document["name"] as? String ?? "",
//                                    friendList: document["friendList"] as? String ?? "",
//                                    debtList: document["debtList"] as? String ?? "",
//                                    creditList: document("creditList") as? String ?? "")
//                    }
//                }
//                else {
//                }
//            }
//        })
//
        self.userList = userList
    }
    
    func addUser(user: User) {
        self.userList.append(user)
    }
    
    func removeUser(user: User) {
        self.userList = self.userList.filter { $0.id != user.id }
    }
    
}
