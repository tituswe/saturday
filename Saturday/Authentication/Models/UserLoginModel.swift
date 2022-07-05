////
////  UserLoginModel.swift
////  Saturday
////
////  Created by Joshua Tan on 10/6/22.
////
//
//import Foundation
//import FirebaseAuth
//import UIKit
//
//class UserLoginModel: ObservableObject {
//
//    let auth = Auth.auth()
//
//    @Published var signedIn: Bool = false
//
//    func isSignedIn() -> Bool {
//        return auth.currentUser != nil
//    }
//
//    func signIn(email: String, password: String) -> Void {
//        
//        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
//            guard result != nil, error == nil else {
//                print("Authentication Denied: ", error!)
//                return
//            }
//
//            print("Authentication Granted: \(result?.user.uid ?? "")")
//
//            self?.signedIn = true
//        }
//    }
//
//    func signUp(email: String, password: String, name: String, username: String, image: UIImage?) -> Void {
//
//        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
//            guard result != nil, error == nil else {
//                print("Failed to create user: ", error!)
//                return
//            }
//
//            FirestoreManager().addUser(email: email, name: name, username: username)
//
//            if let currentUser = self!.auth.currentUser?.createProfileChangeRequest() {
//                currentUser.displayName = username
//                currentUser.commitChanges(completion: { error in
//                    if let error = error {
//                        print(error)
//                    } else {
//                        print("DisplayName set!")
//                    }
//                })
//            }
//
//            print("Successfully created user: \(result?.user.uid ?? "")")
//
//            self?.signedIn = true
//        }
//    }
//
//    func signOut() -> Void {
//        do {
//            try auth.signOut()
//        } catch let signOutError as NSError {
//            print("Error signing out: %@", signOutError)
//        }
//
//        self.signedIn = false
//    }
//
//}
