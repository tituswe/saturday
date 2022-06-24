//
//  User.swift
//  Saturday
//
//  Created by Joshua Tan on 14/6/22.
//

import Foundation
import Firebase

struct User: Identifiable {
    
    var id: String
    var name: String
    var email: String
   
    func toString() -> String {
        return "this is " + self.name + " with the userID " + self.id
    }
}
