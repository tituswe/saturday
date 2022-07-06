//
//  AuthenticationViewModel.swift
//  Saturday
//
//  Created by Titus Lowe on 5/7/22.
//

import SwiftUI
import Firebase
import Kingfisher

class AuthenticationViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var didAuthenticateUser: Bool = false
    private var tempUserSession: FirebaseAuth.User?
    
    @Published var currentUser: User?
    @Published var friends: [User] = [User]()
    @Published var friendRequests: [User] = [User]()
    
    @Published var users: [User] = [User]()
    
    private let service = UserService()
    
    init() {
        self.userSession = Auth.auth().currentUser
        self.fetchUser()
        self.fetchUsers()
        self.fetchFriends()
        self.fetchFriendRequests()
    }
    
    func refresh() {
        self.fetchUsers()
        self.fetchFriends()
        self.fetchFriendRequests()
    }
    
    func getUserId() -> String {
        return (self.currentUser?.id)!
    }
    
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to sign in with error \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
            self.fetchUser()
            print("DEBUG: Did log user in... \(user.displayName ?? "")")
        }
    }
    
    func register(withEmail email: String, password: String, name: String, username: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("DEBUG: Failed to register with error \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.tempUserSession = user
            
            let data = ["email": email,
                        "username": username.lowercased(),
                        "name": name,
                        "uid": user.uid]
            
            Firestore.firestore().collection("users")
                .document(user.uid)
                .setData(data) { _ in
                    self.didAuthenticateUser = true
                }
            
        }
    }
    
    func logout() {
        userSession = nil
        try? Auth.auth().signOut()
    }
    
    func uploadProfileImage(_ image: UIImage) {
        guard let uid = tempUserSession?.uid else { return }
        
        ImageUploader.uploadImage(image: image) { profileImageUrl in
            Firestore.firestore().collection("users")
                .document(uid)
                .updateData(["profileImageUrl": profileImageUrl]) { _ in
                    self.userSession = self.tempUserSession
                    self.fetchUser()
                }
        }
    }
    
    func fetchUser() {
        guard let uid = self.userSession?.uid else { return }
        
        service.fetchUser(withUid: uid) { user in
            self.currentUser = user
            print("DEBUG: Fetching data from \(user.name)")
        }
    }
    
    func fetchUsers() {
        service.fetchUsers { users in
            self.users = users
        }
        self.users.sort { $0.name.lowercased() < $1.name.lowercased() }
    }
    
    @Published var searchText = ""
    
    var searchableUsers: [User] {
        let lowercasedQuery = searchText.lowercased()
        
        return users.filter({
            $0.username.contains(lowercasedQuery) ||
            $0.name.lowercased().contains(lowercasedQuery)
        })
    }
    
    func sendFriendRequest(user: User) {
        guard let currentUser = currentUser else { return }
        guard let receiverUid = user.id else { return }
        
        let data = ["email": currentUser.email,
                    "username": currentUser.username.lowercased(),
                    "name": currentUser.name,
                    "profileImageUrl": currentUser.profileImageUrl,
                    "uid": currentUser.id]
        
        Firestore.firestore().collection("friendRequests")
            .document(receiverUid)
            .collection("senders")
            .document(currentUser.id!)
            .setData(data as [String : Any])
        
        self.refresh()
        
        print("DEBUG: Friend request sent!")
    }
    
    
    func fetchFriendRequests() {
        guard let uid = self.userSession?.uid else { return }
        
        service.fetchFriendRequests(withUid: uid) { friendRequests in
            self.friendRequests = friendRequests
            print("DEBUG: Fetching friend requests...")
        }
        
    }
    
    func acceptFriendRequest(user: User) {
        guard let currentUser = currentUser else { return }
        guard let senderUid = user.id else { return }
        
        // Add me to friend
        let data = ["email": currentUser.email,
                    "username": currentUser.username.lowercased(),
                    "name": currentUser.name,
                    "profileImageUrl": currentUser.profileImageUrl,
                    "uid": currentUser.id]
        
        Firestore.firestore().collection("friends")
            .document(senderUid)
            .collection("list")
            .document(currentUser.id!)
            .setData(data as [String : Any])
        
        // Add friend to me
        let data2 = ["email": user.email,
                    "username": user.username.lowercased(),
                    "name": user.name,
                    "profileImageUrl": user.profileImageUrl,
                    "uid": user.id]
        
        Firestore.firestore().collection("friends")
            .document(currentUser.id!)
            .collection("list")
            .document(user.id!)
            .setData(data2 as [String : Any])
        
        // Remove from requests
        Firestore.firestore().collection("friendRequests")
            .document(currentUser.id!)
            .collection("senders")
            .document(senderUid)
            .delete { error in
                if let error = error {
                    print("DEBUG: Could not remove document: \(error.localizedDescription)")
                    return
                }
            }
        
        // Update friend request list
        self.refresh()
        
        print("DEBUG: Friend request accepted!")
    }
    
    func declineFriendRequest(user: User) {
        guard let currentUser = currentUser else { return }
        guard let senderUid = user.id else { return }
        
        // Remove from requests
        Firestore.firestore().collection("friendRequests")
            .document(currentUser.id!)
            .collection("senders")
            .document(senderUid)
            .delete { error in
                if let error = error {
                    print("DEBUG: Could not remove document: \(error.localizedDescription)")
                    return
                }
            }
        
        // Update friend request list
        self.refresh()
        
        print("DEBUG: Friend request declined!")
    }
    
    func fetchFriends() {
        guard let uid = self.userSession?.uid else { return }
        
        service.fetchFriends(withUid: uid) { friends in
            self.friends = friends
            print("DEBUG: Fetching friends...")
        }
        self.friends.sort { $0.name.lowercased() < $1.name.lowercased() }
    }
}
