//
//  User.swift
//  Saturday
//
//  Created by Titus Lowe on 6/7/22.
//

import FirebaseFirestoreSwift

struct User: Identifiable, Decodable {
    
    @DocumentID var id: String?
    let name: String
    let username: String
    let profileImageUrl: String
    let email: String
    let deviceToken: String?
    
}
