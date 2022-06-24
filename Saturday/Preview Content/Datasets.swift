//
//  Datasets.swift
//  Saturday
//
//  Created by Joshua Tan on 11/6/22.
//

import Foundation

var itemList: [Item] = [
    Item(id: "\(UUID())", name: "Nasi Lemak", price: 2.00),
    Item(id: "\(UUID())", name: "Chicken Rice", price: 2.50),
    Item(id: "\(UUID())", name: "Green Curry", price: 5.00),
    Item(id: "\(UUID())", name: "Hokkien Mee", price: 3.00),
    Item(id: "\(UUID())", name: "Fruit Bowl", price: 1.00)
]

var friendList: [String] = ["Titus", "Joshua", "Kyron", "Yuze"]

var friendListU: [User] = [
    DatabaseManager().getUser(userDocumentID: "wwwpjtMYACwzdMLWjzYN"), //Tester 1 - Titus Lowe
    DatabaseManager().getUser(userDocumentID: "tO5QnGNX0W97FKTOC95E"), //Tester 2 - Joshua Tan
    DatabaseManager().getUser(userDocumentID: "Qev2PCDqNFuvbGYfsMJt"), //Tester 3 - Kyron Teo
    DatabaseManager().getUser(userDocumentID: "PWV3dCRgN4he8oOWvQhO"), //Tester 4 - Yuze Ang
]
