//
//  AuthenticationViewModel.swift
//  Saturday
//
//  Created by Titus Lowe on 5/7/22.
//

import SwiftUI
import Firebase
import FirebaseCore
import FirebaseAuth
import FirebaseStorage
import FirebaseMessaging
import Kingfisher

class UserViewModel: ObservableObject {
    
    @Published var userSession: FirebaseAuth.User?
    @Published var didAuthenticateUser: Bool = false
    private var tempUserSession: FirebaseAuth.User?
    @Published var authErrorMessage = ""
    
    @Published var currentUser: User?
    @Published var friends = [User]()
    @Published var friendRequests = [User]()
    @Published var sentFriendRequests = [User]()
    
    @Published var blockedUsers = [User]()
    @Published var blockedByUsers = [User]()
    
    @Published var users = [User]()
    
    @Published var debts = [Debt]()
    @Published var debtItems = [String : [Item]]() // [transactionId : items]
    
    @Published var credits = [Credit]()
    @Published var creditItems = [String : [Item]]() // [transactionId : items]
    
    @Published var archives = [Archive]()
    @Published var tracker: Tracker?
    
    var fcmRegToken: String = ""
    
    init() {
        
        Messaging.messaging().token { token, error in
          if let error = error {
            print("Error fetching FCM registration token: \(error)")
          } else if let token = token {
            self.fcmRegToken = token
          }
        }
        
        print("DEBUG: Initializing new UserViewModel...")
        self.userSession = Auth.auth().currentUser
        
        let mainQueue = DispatchQueue.main.self
        let group = DispatchGroup()
        group.enter()
        
        mainQueue.async {
            self.fetchUser()
            group.leave()
        }
        
        mainQueue.async {
            group.wait()
            group.enter()
            self.fetchUsers()
            group.leave()
        }
        
        mainQueue.async {
            group.wait()
            group.enter()
            self.fetchBlockedUsers()
            group.leave()
        }
        
        mainQueue.async {
            group.wait()
            group.enter()
            self.fetchBlockedByUsers()
            group.leave()
        }
        
        mainQueue.async {
            group.wait()
            group.enter()
            self.fetchFriends()
            group.leave()
        }
        
        mainQueue.async {
            group.wait()
            group.enter()
            self.fetchFriendRequests()
            group.leave()
        }
        
        mainQueue.async {
            group.wait()
            group.enter()
            self.fetchSentFriendRequests()
            group.leave()
        }
        
        mainQueue.async {
            group.wait()
            group.enter()
            self.fetchDebts()
            group.leave()
        }
        
        mainQueue.async {
            group.wait()
            group.enter()
            self.fetchDebtItems()
            group.leave()
        }
        
        mainQueue.async {
            group.wait()
            group.enter()
            self.fetchCredits()
            group.leave()
        }
        
        mainQueue.async {
            group.wait()
            group.enter()
            self.fetchCreditItems()
            group.leave()
        }
        
        mainQueue.async {
            group.wait()
            group.enter()
            self.fetchArchives()
            group.leave()
        }
        
        mainQueue.async {
            group.wait()
            group.enter()
            self.fetchTracker()
            group.leave()
        }
        
    }
    
    func refresh() {
        print("DEBUG: Refreshing...")
        self.searchText = ""
        self.updateFCMToken()
        let mainQueue = DispatchQueue.main.self
        let group = DispatchGroup()
        group.enter()
        
        mainQueue.async {
            self.fetchUser()
            group.leave()
        }
        
        mainQueue.async {
            group.wait()
            group.enter()
            self.fetchUsers()
            group.leave()
        }
        
        mainQueue.async {
            group.wait()
            group.enter()
            self.fetchBlockedUsers()
            group.leave()
        }
        
        mainQueue.async {
            group.wait()
            group.enter()
            self.fetchBlockedByUsers()
            group.leave()
        }
        
        mainQueue.async {
            group.wait()
            group.enter()
            self.fetchFriends()
            group.leave()
        }
        
        mainQueue.async {
            group.wait()
            group.enter()
            self.fetchFriendRequests()
            group.leave()
        }
        
        mainQueue.async {
            group.wait()
            group.enter()
            self.fetchSentFriendRequests()
            group.leave()
        }
        
        mainQueue.async {
            group.wait()
            group.enter()
            self.fetchDebts()
            group.leave()
        }
        
        mainQueue.async {
            group.wait()
            group.enter()
            self.fetchDebtItems()
            group.leave()
        }
        
        mainQueue.async {
            group.wait()
            group.enter()
            self.fetchCredits()
            group.leave()
        }
        
        mainQueue.async {
            group.wait()
            group.enter()
            self.fetchCreditItems()
            group.leave()
        }
        
        mainQueue.async {
            group.wait()
            group.enter()
            self.fetchArchives()
            group.leave()
        }
        
        mainQueue.async {
            group.wait()
            group.enter()
            self.fetchTracker()
            group.leave()
        }
        
    }
    
    func reset() {
        self.searchText = ""
        self.friendRequests = [User]()
        self.friends = [User]()
        self.users = [User]()
        self.debts = [Debt]()
        self.credits = [Credit]()
    }
    
    func updateFCMToken() {
        guard let uid = self.userSession?.uid else { return }
        
        if self.fcmRegToken == "" { return }
        
        Firestore.firestore().collection("users")
            .document(uid)
            .setData(["deviceToken": self.fcmRegToken], merge: true)
        
        print("UPDATE KEY: \(self.fcmRegToken)")
    }
    
    func login(withEmail email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                print("ERROR: Failed to sign in with error \(error.localizedDescription)")
                return
            }
            
            guard let user = result?.user else { return }
            self.userSession = user
        }
    }
    
    func register(withEmail email: String, password: String, name: String, username: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                print("ERROR: Failed to register with error \(error.localizedDescription)")
                self.authErrorMessage = error.localizedDescription
                return
            }
            
            guard let user = result?.user else { return }
            self.tempUserSession = user
            
            let data = ["email": email,
                        "username": username.lowercased(),
                        "name": name,
                        "uid": user.uid,
                        "deviceToken": self.fcmRegToken]
            
            Firestore.firestore().collection("users")
                .document(user.uid)
                .setData(data) { _ in
                    self.didAuthenticateUser = true
                }
            
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM"
            
            let currMonth = formatter.string(from: Date.now)
            
            let data2 = ["currMonth": currMonth,
                         "netMonthly": 0.00,
                         "netLifetime": 0.00,
                         "totalPayable": 0.00,
                         "totalReceivable": 0.00] as [String : Any]
            
            Firestore.firestore().collection("trackers")
                .document(user.uid)
                .setData(data2)
        }
    }
    
    func updateName(withName name: String) {
        guard let uid = self.userSession?.uid else { return }

        Firestore.firestore().collection("users")
            .document(uid)
            .setData(["name": name], merge: true)
        
        userService.fetchFriends(withUid: uid) { friends in
            friends.forEach { friend in
                Firestore.firestore().collection("friends")
                    .document(friend.id!)
                    .collection("list")
                    .whereField("uid", isEqualTo: uid)
                    .limit(to: 1)
                    .getDocuments { snapshot, _ in
                        guard let documents = snapshot?.documents else { return }
                        for document in documents {
                            document.reference.setData(["name": name], merge: true)
                        }
                    }
            }
        }
        
        userService.fetchFriendRequests(withUid: uid) { requests in
            requests.forEach { request in
                Firestore.firestore().collection("friendRequests")
                    .document(request.id!)
                    .collection("receivers")
                    .whereField("uid", isEqualTo: uid)
                    .limit(to: 1)
                    .getDocuments { snapshot, _ in
                        guard let documents = snapshot?.documents else { return }
                        for document in documents {
                            document.reference.setData(["name": name], merge: true)
                        }
                    }
            }
        }
        
        userService.fetchSentFriendRequests(withUid: uid) { requests in
            requests.forEach { request in
                Firestore.firestore().collection("friendRequests")
                    .document(request.id!)
                    .collection("senders")
                    .whereField("uid", isEqualTo: uid)
                    .limit(to: 1)
                    .getDocuments { snapshot, _ in
                        guard let documents = snapshot?.documents else { return }
                        for document in documents {
                            document.reference.setData(["name": name], merge: true)
                        }
                    }
            }
        }
        
    }
    
    func updateUsername(withUsername username: String) {
        guard let uid = self.userSession?.uid else { return }

        Firestore.firestore().collection("users")
            .document(uid)
            .setData(["username": username.lowercased()], merge: true)
        
        userService.fetchFriends(withUid: uid) { friends in
            friends.forEach { friend in
                Firestore.firestore().collection("friends")
                    .document(friend.id!)
                    .collection("list")
                    .whereField("uid", isEqualTo: uid)
                    .limit(to: 1)
                    .getDocuments { snapshot, _ in
                        guard let documents = snapshot?.documents else { return }
                        for document in documents {
                            document.reference.setData(["username": username.lowercased()], merge: true)
                        }
                    }
            }
        }
        
        userService.fetchFriendRequests(withUid: uid) { requests in
            requests.forEach { request in
                Firestore.firestore().collection("friendRequests")
                    .document(request.id!)
                    .collection("receivers")
                    .whereField("uid", isEqualTo: uid)
                    .limit(to: 1)
                    .getDocuments { snapshot, _ in
                        guard let documents = snapshot?.documents else { return }
                        for document in documents {
                            document.reference.setData(["username": username.lowercased()], merge: true)
                        }
                    }
            }
        }
        
        userService.fetchSentFriendRequests(withUid: uid) { requests in
            requests.forEach { request in
                Firestore.firestore().collection("friendRequests")
                    .document(request.id!)
                    .collection("senders")
                    .whereField("uid", isEqualTo: uid)
                    .limit(to: 1)
                    .getDocuments { snapshot, _ in
                        guard let documents = snapshot?.documents else { return }
                        for document in documents {
                            document.reference.setData(["username": username.lowercased()], merge: true)
                        }
                    }
            }
        }
    }
    
    func updateEmail(withEmail email: String, oldEmail: String, password: String) {
        guard let currentUser = currentUser else { return }
        guard let uid = self.userSession?.uid else { return }
        
        let credential = EmailAuthProvider.credential(withEmail: oldEmail, password: password)
        
        Auth.auth().currentUser?.reauthenticate(with: credential) { authData, error in
            if let error = error {
                print("ERROR: Could not reauthenticate \(error)")
                return
            } else {
                print("REAUTHENTICATED")
            }
        }
        
        Auth.auth().currentUser?.updateEmail(to: email) { error in
            if let error = error {
                print("ERROR: Could not update email \(error)")
                return
            } else {
                print("EMAIL CHANGED")
            }
        }
        
        Firestore.firestore().collection("users")
            .document(currentUser.id!)
            .setData(["email": email], merge: true)
        
        userService.fetchFriends(withUid: uid) { friends in
            friends.forEach { friend in
                Firestore.firestore().collection("friends")
                    .document(friend.id!)
                    .collection("list")
                    .whereField("uid", isEqualTo: uid)
                    .limit(to: 1)
                    .getDocuments { snapshot, _ in
                        guard let documents = snapshot?.documents else { return }
                        for document in documents {
                            document.reference.setData(["email": email], merge: true)
                        }
                    }
            }
        }
        
        userService.fetchFriendRequests(withUid: uid) { requests in
            requests.forEach { request in
                Firestore.firestore().collection("friendRequests")
                    .document(request.id!)
                    .collection("receivers")
                    .whereField("uid", isEqualTo: uid)
                    .limit(to: 1)
                    .getDocuments { snapshot, _ in
                        guard let documents = snapshot?.documents else { return }
                        for document in documents {
                            document.reference.setData(["email": email], merge: true)
                        }
                    }
            }
        }
        
        userService.fetchSentFriendRequests(withUid: uid) { requests in
            requests.forEach { request in
                Firestore.firestore().collection("friendRequests")
                    .document(request.id!)
                    .collection("senders")
                    .whereField("uid", isEqualTo: uid)
                    .limit(to: 1)
                    .getDocuments { snapshot, _ in
                        guard let documents = snapshot?.documents else { return }
                        for document in documents {
                            document.reference.setData(["email": email], merge: true)
                        }
                    }
            }
        }
    }
    
    func updatePassword(oldPassword: String, newPassword: String) {
        guard let currentUser = currentUser else { return }

        let credential = EmailAuthProvider.credential(withEmail: currentUser.email, password: oldPassword)
        
        Auth.auth().currentUser?.reauthenticate(with: credential) { authData, error in
            if let error = error {
                print("ERROR: Could not reauthenticate \(error)")
                return
            } else {
                print("REAUTHENTICATED")
            }
        }
        
        Auth.auth().currentUser?.updatePassword(to: newPassword) { error in
            if let error = error {
                print("ERROR: Could not update password \(error)")
                return
            } else {
                print("PASSWORD CHANGED")
            }
        }
    }
    
    func logout() {
        self.reset()
        userSession = nil
        print("DEBUG: USERSESSION \(String(describing: userSession))")
        try? Auth.auth().signOut()
    }
    
    func deleteAccount() {
        refresh()
        guard let user = Auth.auth().currentUser else { return }
        guard let uid = self.userSession?.uid else { return }
        user.delete { error in
            if let error = error {
                print("ERROR: Could not remove document: \(error.localizedDescription)")
            } else {
                print("USER DELETED")
            }
            
            self.logout()
        }
        
        // Delete from users collection
        Firestore.firestore().collection("users")
            .document(uid)
            .delete { error in
                if let error = error {
                    print("ERROR: Could not remove document: \(error.localizedDescription)")
                    return
                }
            }
        
        // Delete from trackers collection
        Firestore.firestore().collection("trackers")
            .document(uid)
            .delete { error in
                if let error = error {
                    print("ERROR: Could not remove document: \(error.localizedDescription)")
                    return
                }
            }
        
        // Delete from friends collection
        userService.fetchFriends(withUid: uid) { friends in
            friends.forEach { friend in
                Firestore.firestore().collection("friends")
                    .document(uid)
                    .collection("list")
                    .document(friend.id!)
                    .delete { error in
                        if let error = error {
                            print("ERROR: Could not remove document: \(error.localizedDescription)")
                            return
                        }
                    }
            }
        }
        
        userService.fetchFriends(withUid: uid) { friends in
            friends.forEach { friend in
                Firestore.firestore().collection("friends")
                    .document(friend.id!)
                    .collection("list")
                    .whereField("uid", isEqualTo: uid)
                    .limit(to: 1)
                    .getDocuments { snapshot, _ in
                        guard let documents = snapshot?.documents else { return }
                        for document in documents {
                            document.reference.delete { error in
                                if let error = error {
                                    print("ERROR: Could not remove document: \(error.localizedDescription)")
                                    return
                                }
                            }
                        }
                    }
            }
        }
        
        Firestore.firestore().collection("friends")
            .document(uid)
            .delete { error in
                if let error = error {
                    print("ERROR: Could not remove document: \(error.localizedDescription)")
                    return
                }
            }
        
        // Delete from friendRequests collection
        userService.fetchFriendRequests(withUid: uid) { requests in
            requests.forEach { request in
                Firestore.firestore().collection("friendRequests")
                    .document(uid)
                    .collection("senders")
                    .document(request.id!)
                    .delete { error in
                        if let error = error {
                            print("ERROR: Could not remove document: \(error.localizedDescription)")
                            return
                        }
                    }
            }
        }
        
        userService.fetchSentFriendRequests(withUid: uid) { requests in
            requests.forEach { request in
                Firestore.firestore().collection("friendRequests")
                    .document(uid)
                    .collection("receivers")
                    .document(request.id!)
                    .delete { error in
                        if let error = error {
                            print("ERROR: Could not remove document: \(error.localizedDescription)")
                            return
                        }
                    }
            }
        }
        
        userService.fetchFriendRequests(withUid: uid) { requests in
            requests.forEach { request in
                Firestore.firestore().collection("friendRequests")
                    .document(request.id!)
                    .collection("receivers")
                    .whereField("uid", isEqualTo: uid)
                    .limit(to: 1)
                    .getDocuments { snapshot, _ in
                        guard let documents = snapshot?.documents else { return }
                        for document in documents {
                            document.reference.delete { error in
                                if let error = error {
                                    print("ERROR: Could not remove document: \(error.localizedDescription)")
                                    return
                                }
                            }
                        }
                    }
            }
        }
        
        userService.fetchSentFriendRequests(withUid: uid) { requests in
            requests.forEach { request in
                Firestore.firestore().collection("friendRequests")
                    .document(request.id!)
                    .collection("senders")
                    .whereField("uid", isEqualTo: uid)
                    .limit(to: 1)
                    .getDocuments { snapshot, _ in
                        guard let documents = snapshot?.documents else { return }
                        for document in documents {
                            document.reference.delete { error in
                                if let error = error {
                                    print("ERROR: Could not remove document: \(error.localizedDescription)")
                                    return
                                }
                            }
                        }
                    }
            }
        }
        
        Firestore.firestore().collection("friendRequests")
            .document(uid)
            .delete { error in
                if let error = error {
                    print("ERROR: Could not remove document: \(error.localizedDescription)")
                    return
                }
            }
        
        // Delete from debts collection
        for debt in self.debts {
            let transactionId = debt.transactionId
            
            self.debtItems[transactionId]?.forEach({ item in
                guard let itemId = item.id else { return }
                
                Firestore.firestore().collection("debts").document(uid).collection("transactions").document(transactionId).collection("items").document(itemId)
                    .delete { error in
                        if error != nil { return }
                    }
            })
            
            Firestore.firestore().collection("debts").document(uid).collection("transactions").document(transactionId)
                .delete { error in
                    if error != nil { return }
                }
            
            self.debtItems[transactionId]?.forEach({ item in
                guard let itemId = item.id else { return }
                
                Firestore.firestore().collection("credits").document(debt.creditorId).collection("transactions").document(transactionId).collection("items").document(itemId)
                    .delete { error in
                        if error != nil { return }
                    }
            })
            
            Firestore.firestore().collection("credits").document(debt.creditorId).collection("transactions").document(transactionId)
                .delete { error in
                    if error != nil { return }
                }
            
            Firestore.firestore().collection("trackers").document(debt.creditorId)
                .updateData(["totalReceivable": FieldValue.increment(-debt.total)])
        }
        
        Firestore.firestore().collection("debts")
            .document(uid)
            .delete { error in
                if let error = error {
                    print("ERROR: Could not remove document: \(error.localizedDescription)")
                    return
                }
            }
        
        // Delete from credits collection
        for credit in self.credits {
            let transactionId = credit.transactionId
            
            self.creditItems[transactionId]?.forEach({ item in
                guard let itemId = item.id else { return }

                Firestore.firestore().collection("credits").document(uid).collection("transactions").document(transactionId).collection("items").document(itemId)
                    .delete { error in
                        if error != nil { return }
                    }
            })
            
            Firestore.firestore().collection("credits").document(uid).collection("transactions").document(transactionId)
                .delete { error in
                    if error != nil { return }
                }
            
            self.creditItems[transactionId]?.forEach({ item in
                guard let itemId = item.id else { return }
                
                Firestore.firestore().collection("debts").document(credit.debtorId).collection("transactions").document(transactionId).collection("items").document(itemId)
                    .delete { error in
                        if error != nil { return }
                    }
            })
            
            Firestore.firestore().collection("debts").document(credit.debtorId).collection("transactions").document(transactionId)
                .delete { error in
                    if error != nil { return }
                }
            
            Firestore.firestore().collection("trackers").document(credit.debtorId)
                .updateData(["totalPayable": FieldValue.increment(-credit.total),
                             "netMonthly": FieldValue.increment(credit.total)])
        }
        
        Firestore.firestore().collection("credits")
            .document(uid)
            .delete { error in
                if let error = error {
                    print("ERROR: Could not remove document: \(error.localizedDescription)")
                    return
                }
            }
        
        // Delete from history collection
        for archive in archives {
            let transactionId = archive.transactionId
            
            Firestore.firestore().collection("history").document(uid).collection("archives").document(transactionId)
                .delete { error in
                    if error != nil { return }
                }
        }
        
        Firestore.firestore().collection("history")
            .document(uid)
            .delete { error in
                if let error = error {
                    print("ERROR: Could not remove document: \(error.localizedDescription)")
                    return
                }
            }
    }
        
    func uploadProfileImage(_ image: UIImage) {
        guard let uid = tempUserSession?.uid else { return }
        
        ImageUploader.uploadImage(image: image) { profileImageUrl in
            Firestore.firestore().collection("users")
                .document(uid)
                .setData(["profileImageUrl": profileImageUrl], merge: true) { _ in
                    self.userSession = self.tempUserSession
                    self.fetchUser()
                }
        }
    }
    
    func updateProfileImage(_ image: UIImage) {
        guard let uid = self.userSession?.uid else { return }
        
        ImageUploader.uploadImage(image: image) { profileImageUrl in
            Firestore.firestore().collection("users")
                .document(uid)
                .setData(["profileImageUrl": profileImageUrl], merge: true)
            
            self.userService.fetchFriends(withUid: uid) { friends in
                friends.forEach { friend in
                    Firestore.firestore().collection("friends")
                        .document(friend.id!)
                        .collection("list")
                        .whereField("uid", isEqualTo: uid)
                        .limit(to: 1)
                        .getDocuments { snapshot, _ in
                            guard let documents = snapshot?.documents else { return }
                            for document in documents {
                                document.reference.setData(["profileImageUrl": profileImageUrl], merge: true)
                            }
                        }
                }
            }
            
            self.userService.fetchFriendRequests(withUid: uid) { requests in
                requests.forEach { request in
                    Firestore.firestore().collection("friendRequests")
                        .document(request.id!)
                        .collection("receivers")
                        .whereField("uid", isEqualTo: uid)
                        .limit(to: 1)
                        .getDocuments { snapshot, _ in
                            guard let documents = snapshot?.documents else { return }
                            for document in documents {
                                document.reference.setData(["profileImageUrl": profileImageUrl], merge: true)
                            }
                        }
                }
            }
            
            self.userService.fetchSentFriendRequests(withUid: uid) { requests in
                requests.forEach { request in
                    Firestore.firestore().collection("friendRequests")
                        .document(request.id!)
                        .collection("senders")
                        .whereField("uid", isEqualTo: uid)
                        .limit(to: 1)
                        .getDocuments { snapshot, _ in
                            guard let documents = snapshot?.documents else { return }
                            for document in documents {
                                document.reference.setData(["profileImageUrl": profileImageUrl], merge: true)
                            }
                        }
                }
            }
        }
    }
    
    
    // MARK: User Services
    private let userService = UserService()
    
    func fetchUser() {
        guard let uid = self.userSession?.uid else { return }
        
        userService.fetchUser(withUid: uid) { user in
            self.currentUser = user
        }
    }
    
    func fetchTracker() {
        guard let uid = self.userSession?.uid else { return }
        
        userService.fetchTracker(withUid: uid) { tracker in
            
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM"
            
            let currMonth = formatter.string(from: Date.now)
            
            if tracker.currMonth != currMonth {
                Firestore.firestore().collection("trackers")
                    .document(uid)
                    .updateData(["currMonth": currMonth,
                                 "netMonthly": 0])
                
                self.tracker = Tracker(currMonth: currMonth,
                                       netMonthly: 0,
                                       netLifetime: tracker.netLifetime,
                                       totalPayable: tracker.totalPayable,
                                       totalReceivable: tracker.totalReceivable)
            } else {
                self.tracker = tracker
            }
            
        }
    }
    
    func queryUser(withUid uid: String) -> User {
        guard let query = (self.users.first { $0.id == uid }) else {
            return User(id: "",
                        name: "",
                        username: "",
                        profileImageUrl: "",
                        email: "",
                        deviceToken: "")
        }
        return query
    }
    
    func fetchUsers() {
        userService.fetchUsers { users in
            self.users = [User]()
            self.users = users
        }
        self.users.sort { $0.name.lowercased() < $1.name.lowercased() }
    }
    
    @Published var searchText = ""
    
    var searchableUsers: [User] {
        let lowercasedQuery = searchText.lowercased()
        
        if let currentUser = currentUser {
            var users = users.filter({
                ($0.username.contains(lowercasedQuery) ||
                 $0.name.lowercased().contains(lowercasedQuery)) &&
                $0.id! != currentUser.id
            })
            
            self.blockedByUsers.forEach { blockedByUser in
                users = users.filter({ $0.id != blockedByUser.id })
            }
            
            print("RETURN USERS: \(users)")
            return users
        } else {
            var users = users.filter({
                $0.username.contains(lowercasedQuery) ||
                $0.name.lowercased().contains(lowercasedQuery)
            })
            
            self.blockedByUsers.forEach { blockedByUser in
                users = users.filter({ $0.id != blockedByUser.id })
            }
            
            return users
        }
    }
    
    var searchableRequests: [User] {
        let lowercasedQuery = searchText.lowercased()
        
        return friendRequests.filter({
            $0.username.contains(lowercasedQuery) ||
            $0.name.lowercased().contains(lowercasedQuery)
        })
    }
    
    func fetchFriends() {
        guard let uid = self.userSession?.uid else { return }
        
        userService.fetchFriends(withUid: uid) { friends in
            self.friends = friends
        }
    }
    
    func removeFriend(friend: User) {
        guard let uid = self.userSession?.uid else { return }
        
        Firestore.firestore().collection("friends")
            .document(uid)
            .collection("list")
            .document(friend.id!)
            .delete { error in
                if let error = error {
                    print("ERROR: Could not remove document: \(error.localizedDescription)")
                    return
                }
            }
        
        self.friends = self.friends.filter { $0.id != friend.id }
        
        Firestore.firestore().collection("friends")
            .document(friend.id!)
            .collection("list")
            .document(uid)
            .delete { error in
                if let error = error {
                    print("ERROR: Could not remove document: \(error.localizedDescription)")
                    return
                }
            }
    }
    
    func sendFriendRequest(user: User) {
        guard let currentUser = currentUser else { return }
        guard let receiverUid = user.id else { return }
        
        let data = ["email": currentUser.email,
                    "username": currentUser.username.lowercased(),
                    "name": currentUser.name,
                    "profileImageUrl": currentUser.profileImageUrl,
                    "uid": currentUser.id,
                    "deviceToken": currentUser.deviceToken]
        
        Firestore.firestore().collection("friendRequests")
            .document(receiverUid)
            .collection("senders")
            .document(currentUser.id!)
            .setData(data as [String : Any])
        
        self.sentFriendRequests.append(user)
        
        let data2 = ["email": user.email,
                     "username": user.username.lowercased(),
                     "name": user.name,
                     "profileImageUrl": user.profileImageUrl,
                     "uid": receiverUid,
                     "deviceToken": user.deviceToken]
        
        Firestore.firestore().collection("friendRequests")
            .document(currentUser.id!)
            .collection("receivers")
            .document(receiverUid)
            .setData(data2 as [String : Any])
        
        let receiverUser = queryUser(withUid: receiverUid)
        
        NotificationManager.instance.sendFriendRequest(requestSender: currentUser, requestReceiver: receiverUser)
        
    }
    
    func retractFriendRequest(user: User) {
        guard let currentUser = currentUser else { return }
        guard let receiverUid = user.id else { return }
        
        Firestore.firestore().collection("friendRequests")
            .document(receiverUid)
            .collection("senders")
            .document(currentUser.id!)
            .delete { error in
                if let error = error {
                    print("ERROR: Could not remove document: \(error.localizedDescription)")
                    return
                }
            }
        
        self.sentFriendRequests = self.sentFriendRequests.filter { $0.id != receiverUid }
        
        Firestore.firestore().collection("friendRequests")
            .document(currentUser.id!)
            .collection("receivers")
            .document(receiverUid)
            .delete { error in
                if let error = error {
                    print("ERROR: Could not remove document: \(error.localizedDescription)")
                    return
                }
            }
    }
    
    func fetchFriendRequests() {
        guard let uid = self.userSession?.uid else { return }
        
        userService.fetchFriendRequests(withUid: uid) { friendRequests in
            self.friendRequests = friendRequests
        }
    }
    
    func fetchSentFriendRequests() {
        guard let uid = self.userSession?.uid else { return }
        
        userService.fetchSentFriendRequests(withUid: uid) { requests in
            self.sentFriendRequests = requests
        }
    }
    
    func hasFriendRequest(user: User) -> Bool {
        for request in friendRequests {
            if user.id == request.id {
                return true
            }
        }
        return false
    }
    
    func hasSentFriendRequest(user: User) -> Bool {
        for request in sentFriendRequests {
            if user.id == request.id {
                return true
            }
        }
        return false
    }
    
    func isFriend(user: User) -> Bool {
        for friend in friends {
            if user.id == friend.id {
                return true
            }
        }
        return false
    }
    
    func isBlocked(user: User) -> Bool {
        for block in blockedUsers {
            if user.id == block.id {
                return true
            }
        }
        return false
    }
    
    func isBlockedBy(user: User) -> Bool {
        for blockedBy in blockedByUsers {
            if user.id == blockedBy.id {
                return true
            }
        }
        return false
    }
    
    func acceptFriendRequest(user: User) {
        guard let currentUser = currentUser else { return }
        guard let senderUid = user.id else { return }
        
        // Add me to friend
        let data = ["email": currentUser.email,
                    "username": currentUser.username.lowercased(),
                    "name": currentUser.name,
                    "profileImageUrl": currentUser.profileImageUrl,
                    "uid": currentUser.id,
                    "deviceToken": currentUser.deviceToken]
        
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
                     "uid": user.id,
                     "deviceToken": user.deviceToken]
        
        Firestore.firestore().collection("friends")
            .document(currentUser.id!)
            .collection("list")
            .document(user.id!)
            .setData(data2 as [String : Any])
        
        self.friends.append(user)
        
        // Remove from requests
        Firestore.firestore().collection("friendRequests")
            .document(currentUser.id!)
            .collection("senders")
            .document(senderUid)
            .delete { error in
                if let error = error {
                    print("ERROR: Could not remove document: \(error.localizedDescription)")
                    return
                }
            }
        
        
        Firestore.firestore().collection("friendRequests")
            .document(senderUid)
            .collection("receivers")
            .document(currentUser.id!)
            .delete { error in
                if let error = error {
                    print("ERROR: Could not remove document: \(error.localizedDescription)")
                    return
                }
            }
        
        self.friendRequests = self.friendRequests.filter { $0.id != user.id }
        // Update friend request list
        self.refresh()
        
        // Send notification to both users
        let user2 = queryUser(withUid: senderUid)
        NotificationManager.instance.sendAcceptedFriendRequest(user1: currentUser, user2: user2)
        NotificationManager.instance.sendAcceptedFriendRequest(user1: user2, user2: currentUser)
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
                    print("ERROR: Could not remove document: \(error.localizedDescription)")
                    return
                }
            }
        
        Firestore.firestore().collection("friendRequests")
            .document(senderUid)
            .collection("receivers")
            .document(currentUser.id!)
            .delete { error in
                if let error = error {
                    print("ERROR: Could not remove document: \(error.localizedDescription)")
                    return
                }
            }
        
        // Update friend request list
        self.friendRequests = self.friendRequests.filter { $0.id != user.id }
        
        self.refresh()
    }
    
    func blockUser(user: User) {
        guard let currentUser = currentUser else { return }
        guard let blockUid = user.id else { return }
        
        let data = ["email": user.email,
                    "username": user.username.lowercased(),
                    "name": user.name,
                    "profileImageUrl": user.profileImageUrl,
                    "uid": user.id,
                    "deviceToken": user.deviceToken]
        
        Firestore.firestore().collection("blocks")
            .document(currentUser.id!)
            .collection("blocked")
            .document(blockUid)
            .setData(data as [String : Any])
        
        self.blockedUsers.append(user)
        
        let data2 = ["email": currentUser.email,
                     "username": currentUser.username.lowercased(),
                     "name": currentUser.name,
                     "profileImageUrl": currentUser.profileImageUrl,
                     "uid": currentUser.id,
                     "deviceToken": currentUser.deviceToken]
        
        Firestore.firestore().collection("blocks")
            .document(blockUid)
            .collection("blockedby")
            .document(currentUser.id!)
            .setData(data2 as [String : Any])
        
        Firestore.firestore().collection("friends")
            .document(currentUser.id!)
            .collection("list")
            .document(blockUid)
            .delete { error in
                if let error = error {
                    print("ERROR: Could not remove document: \(error.localizedDescription)")
                    return
                }
            }
        
        self.friends = self.friends.filter{ $0.id != blockUid }
        
        Firestore.firestore().collection("friends")
            .document(blockUid)
            .collection("list")
            .document(currentUser.id!)
            .delete { error in
                if let error = error {
                    print("ERROR: Could not remove document: \(error.localizedDescription)")
                    return
                }
            }
    }
    
    func unblockUser(user: User) {
        guard let currentUser = currentUser else { return }
        guard let blockUid = user.id else { return }
        
        Firestore.firestore().collection("blocks")
            .document(currentUser.id!)
            .collection("blocked")
            .document(blockUid)
            .delete { error in
                if let error = error {
                    print("ERROR: Could not remove document: \(error.localizedDescription)")
                    return
                }
            }
        
        self.blockedUsers = self.blockedUsers.filter { $0.id != blockUid }
        
        Firestore.firestore().collection("blocks")
            .document(blockUid)
            .collection("blockedby")
            .document(currentUser.id!)
            .delete { error in
                if let error = error {
                    print("ERROR: Could not remove document: \(error.localizedDescription)")
                    return
                }
            }

    }
    
    func fetchBlockedUsers() {
        guard let uid = self.userSession?.uid else { return }
        
        userService.fetchBlockedUsers(withUid: uid) { blockedUsers in
            self.blockedUsers = blockedUsers
        }
    }
    
    func fetchBlockedByUsers() {
        guard let uid = self.userSession?.uid else { return }
        
        userService.fetchBlockedByUsers(withUid: uid) { blockedByUsers in
            self.blockedByUsers = blockedByUsers
        }
    }
    
    
    // MARK: Transaction Services
    let debtService = DebtService()
    
    func fetchDebts() {
        guard let uid = self.userSession?.uid else { return }
        
        debtService.fetchDebts(withUid: uid) { debts in
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm E, d MMM y"
            
            let sortedDebts = debts.sorted(by: { formatter.date(from: $0.date)!.compare(formatter.date(from: $1.date)!) == .orderedAscending })
            
            self.debts = sortedDebts
        }
    }
    
    func fetchDebtItems() {
        guard let uid = self.userSession?.uid else { return }
        
        self.debts.forEach { debt in
            debtService.fetchItems(withUid: uid, transId: debt.transactionId) { items in
                self.debtItems[debt.transactionId] = items
            }
        }
    }
    
    let creditService = CreditService()
    
    func fetchCredits() {
        guard let uid = self.userSession?.uid else { return }
        
        creditService.fetchCredits(withUid: uid) { credits in
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm E, d MMM y"
            
            let sortedCredits = credits.sorted(by: { formatter.date(from: $0.date)!.compare(formatter.date(from: $1.date)!) == .orderedAscending })
            
            self.credits = sortedCredits
        }
    }
    
    func fetchCreditItems() {
        guard let uid = self.userSession?.uid else { return }
        
        self.credits.forEach { credit in
            creditService.fetchItems(withUid: uid, transId: credit.transactionId) { items in
                self.creditItems[credit.transactionId] = items
            }
        }
    }
    
    // For settling payment
    func cacheTransaction(debt: Debt) {
        let transactionId = debt.transactionId
        guard let uid = self.userSession?.uid else { return }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm E, d MMM y"
        
        let currDate = formatter.string(from: Date.now)
        
        let data = ["transactionId": transactionId,
                    "creditorId": debt.creditorId,
                    "dateIssued": debt.date,
                    "dateSettled": currDate,
                    "total": debt.total,
                    "status": "paid",
                    "type": "debt"] as [String : Any]
        
        Firestore.firestore().collection("history").document(uid).collection("archives").document(transactionId)
            .setData(data)
        
        self.debtItems[transactionId]?.forEach({ item in
            guard let itemId = item.id else { return }
            
            Firestore.firestore().collection("debts").document(uid).collection("transactions").document(transactionId).collection("items").document(itemId)
                .delete { error in
                    if error != nil { return }
                }
        })
        
        Firestore.firestore().collection("debts").document(uid).collection("transactions").document(transactionId)
            .delete { error in
                if error != nil { return }
            }
        
        Firestore.firestore().collection("trackers").document(uid)
            .updateData(["totalPayable": FieldValue.increment(-debt.total)])
        
        let data2 = ["transactionId": transactionId,
                     "debtorId": uid,
                     "dateIssued": debt.date,
                     "dateSettled": currDate,
                     "total": debt.total,
                     "status": "paid",
                     "type": "credit"] as [String : Any]
        
        Firestore.firestore().collection("history").document(debt.creditorId).collection("archives").document(transactionId)
            .setData(data2)
        
        self.debtItems[transactionId]?.forEach({ item in
            guard let itemId = item.id else { return }
            
            Firestore.firestore().collection("credits").document(debt.creditorId).collection("transactions").document(transactionId).collection("items").document(itemId)
                .delete { error in
                    if error != nil { return }
                }
        })
        
        Firestore.firestore().collection("credits").document(debt.creditorId).collection("transactions").document(transactionId)
            .delete { error in
                if error != nil { return }
            }
        
        Firestore.firestore().collection("trackers").document(debt.creditorId)
            .updateData(["totalReceivable": FieldValue.increment(-debt.total)])
        
        NotificationManager.instance.sendPaidNotification(creditor: self.queryUser(withUid: debt.creditorId), debtor: self.currentUser!, amount: debt.total)
    }
    
    // For cancelling debt
    func cacheTransaction(credit: Credit) {
        let transactionId = credit.transactionId
        guard let uid = self.userSession?.uid else { return }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm E, d MMM y"
        
        let currDate = formatter.string(from: Date.now)
        
        let data = ["transactionId": transactionId,
                    "debtorId": credit.debtorId,
                    "dateIssued": credit.date,
                    "dateSettled": currDate,
                    "total": credit.total,
                    "status": "cancelled",
                    "type": "credit"] as [String : Any]
        
        Firestore.firestore().collection("history").document(uid).collection("archives").document(transactionId)
            .setData(data)
        
        self.creditItems[transactionId]?.forEach({ item in
            guard let itemId = item.id else { return }

            Firestore.firestore().collection("credits").document(uid).collection("transactions").document(transactionId).collection("items").document(itemId)
                .delete { error in
                    if error != nil { return }
                }
        })
        
        Firestore.firestore().collection("credits").document(uid).collection("transactions").document(transactionId)
            .delete { error in
                if error != nil { return }
            }
        
        Firestore.firestore().collection("trackers").document(uid)
            .updateData(["totalReceivable": FieldValue.increment(-credit.total),
                         "netMonthly": FieldValue.increment(-credit.total)])
        
        let data2 = ["transactionId": transactionId,
                     "creditorId": uid,
                     "dateIssued": credit.date,
                     "dateSettled": currDate,
                     "total": credit.total,
                     "status": "cancelled",
                     "type": "debt"] as [String : Any]
        
        Firestore.firestore().collection("history").document(credit.debtorId).collection("archives").document(transactionId)
            .setData(data2)
        
        self.creditItems[transactionId]?.forEach({ item in
            guard let itemId = item.id else { return }
            
            Firestore.firestore().collection("debts").document(credit.debtorId).collection("transactions").document(transactionId).collection("items").document(itemId)
                .delete { error in
                    if error != nil { return }
                }
        })
        
        Firestore.firestore().collection("debts").document(credit.debtorId).collection("transactions").document(transactionId)
            .delete { error in
                if error != nil { return }
            }
        
        Firestore.firestore().collection("trackers").document(credit.debtorId)
            .updateData(["totalPayable": FieldValue.increment(-credit.total),
                         "netMonthly": FieldValue.increment(credit.total)])
        
        NotificationManager.instance.sendSplitCancelled(creditor: self.currentUser!, debtor: self.queryUser(withUid: credit.debtorId), amount: credit.total)
    }
    
    let archiveService = ArchiveService()
    
    func fetchArchives() {
        guard let uid = self.userSession?.uid else { return }
        
        archiveService.fetchArchives(withUid: uid) { archives in
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm E, d MMM y"
            
            let sortedArchives = archives.sorted(by: { formatter.date(from: $0.dateSettled)!.compare(formatter.date(from: $1.dateSettled)!) == .orderedDescending })
            
            self.archives = sortedArchives
        }
    }
    
}
