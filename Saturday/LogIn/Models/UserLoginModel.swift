//
//  UserLoginModel.swift
//  Saturday
//
//  Created by Joshua Tan on 10/6/22.
//

import Foundation
import FirebaseAuth

class UserLoginModel: ObservableObject {
    
    let auth = Auth.auth()
    
    @Published var signedIn: Bool = false
    
    func isSignedIn() -> Bool {
        return auth.currentUser != nil
    }
    
    func signIn(email: String, password: String) -> Void {
        
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                // Failure
                return
            }
            
            //Success
            self?.signedIn = true
        }
    }
    
    func signUp(email: String, password: String, name: String) -> Void {
        
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                //Failure
                return
            }
            
            // Success
            DatabaseManager().addUser(email: email, password: password, name: name)
            self?.signedIn = true
        }
    }
    
    func signOut() -> Void {
        do {
            try auth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
        
        self.signedIn = false
    }
}
