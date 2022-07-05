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
    @Published var currentUser: User?
    @Published var friendRequests: [User] = [User]()
    private var tempUserSession: FirebaseAuth.User?
    
    private let service = UserService()
    
    init() {
        self.userSession = Auth.auth().currentUser
        self.fetchUser()
        self.fetchRequests()
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
        
        print("DEBUG: Friend request sent!")
    }
    
    
    func fetchRequests() {
        guard let uid = self.userSession?.uid else { return }
        
        service.fetchRequests(withUid: uid) { friendRequests in
            self.friendRequests = friendRequests
            print("DEBUG: Fetching friend requests...")
        }
    }
    
}
