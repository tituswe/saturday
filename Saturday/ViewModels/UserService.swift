//
//  UserService.swift
//  Saturday
//
//  Created by Titus Lowe on 6/7/22.
//

import Firebase
import FirebaseFirestoreSwift

struct UserService {
    
    func fetchUser(withUid uid: String, completion: @escaping(User) -> Void) {
        Firestore.firestore().collection("users")
            .document(uid)
            .getDocument { snapshot, _ in
                guard let snapshot = snapshot else { return }
                
                guard let user = try? snapshot.data(as: User.self) else { return }
                completion(user)
            }
    }
    
    func fetchUsers(completion: @escaping([User]) -> Void) {
        Firestore.firestore().collection("users")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let users = documents.compactMap({ try? $0.data(as: User.self) })
                completion(users)
            }
    }
    
    func fetchFriendRequests(withUid uid: String, completion: @escaping([User]) -> Void) {
        Firestore.firestore().collection("friendRequests")
            .document(uid)
            .collection("senders")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let users = documents.compactMap({ try? $0.data(as: User.self) })
                completion(users)
            }
    }
    
    func fetchSentFriendRequests(withUid uid: String, completion: @escaping([User]) -> Void) {
        Firestore.firestore().collection("friendRequests")
            .document(uid)
            .collection("receivers")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let users = documents.compactMap({ try? $0.data(as: User.self) })
                completion(users)
            }
    }
    
    func fetchFriends(withUid uid: String, completion: @escaping([User]) -> Void) {
        Firestore.firestore().collection("friends")
            .document(uid)
            .collection("list")
            .getDocuments { snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                let users = documents.compactMap({ try? $0.data(as: User.self) })
                completion(users)
            }
    }
    
}
