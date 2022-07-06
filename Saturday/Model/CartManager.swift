//
//  CartManager.swift
//  Saturday2
//
//  Created by Titus Lowe on 28/6/22.
//

import Foundation
import Firebase
import UIKit

class CartManager: ObservableObject {
    
    var userSession: FirebaseAuth.User?
    var creditor: User?
    @Published var payableItems = [Item]()
    @Published var payableUsers = [User]()
    @Published var allUsers = [User]()
    @Published var debts = [String: Debt]()
    @Published var selectedMap = [String: Bool]()
    @Published var selectedUserId: String?
    
    init() {
        self.userSession = Auth.auth().currentUser
        self.fetchCreditor()
    }
    
    // TODO: Delete later
    init(debts: [String: Debt]) {
        self.debts = debts
    }
    
    private let service = UserService()
    
    func fetchCreditor() {
        guard let uid = self.userSession?.uid else { return }
        
        service.fetchUser(withUid: uid) { creditor in
            self.creditor = creditor
        }
    }
    
    func updateAllUsers(allUsers: [User]) {
        self.allUsers = allUsers
        self.allUsers.sort { $0.name.lowercased() < $1.name.lowercased() }
    }
    
    func addPayableUser(user: User) {
        self.payableUsers.append(user)
        
        guard let uid = user.id else { return }
        
        self.allUsers = self.allUsers.filter { $0.id != uid }
        
        self.selectedMap[uid] = false
    }
    
    func removePayableUser(user: User) {
        guard let uid = user.id else { return }
        
        self.payableUsers = self.payableUsers.filter { $0.id != uid }
        
        self.allUsers.append(user)
        self.allUsers.sort { $0.name.lowercased() < $1.name.lowercased() }
        
        self.selectedMap.removeValue(forKey: uid)
        
        guard let items = self.debts[uid]?.getItems() else { return }
        
        self.addItemsToPayableItems(items: items)
        self.debts.removeValue(forKey: uid)
    }
    
    func selectUser(user: User) {
        guard let uid = user.id else { return }
        
        self.selectedMap.keys.forEach { selectedMap[$0] = false }
        self.selectedMap[uid] = true
        
        self.selectedUserId = uid
    }
    
    func selectNone() {
        self.selectedMap.keys.forEach { selectedMap[$0] = false }
        
        self.selectedUserId = nil
    }
    
    func getDebt(key: String) -> Debt {
        guard let debt = self.debts[key] else { return Debt(id: "NIL") }
        
        return debt
    }
    
    func getDebtItems(key: String) -> [Item] {
        return self.getDebt(key: key).items
    }
    
    func getDebtItemsCount(key: String) -> Int {
        return self.getDebtItems(key: key).count
    }
    
    func updatePayableItems(items: [Item]) {
        self.payableItems = items
    }
    
    func addItemToPayableItems(item: Item) {
        self.payableItems.append(item)
    }
    
    func addItemsToPayableItems(items: [Item]) {
        self.payableItems.append(contentsOf: items)
    }
    
    func addItemToDebt(item: Item) {
        guard let selectedUserId = selectedUserId else { return }

        self.debts[selectedUserId]?.addItem(item: item)
        
        self.payableItems = self.payableItems.filter { $0.id != item.id }
    }
    
    
    // MARK: Firestore
    
    func broadcastDebts() {
        guard let creditor = creditor else { return }
        guard let creditorId = creditor.id else { return }
        
        self.debts.keys.forEach { debtorId in
            guard let debt = debts[debtorId] else { return }
            
            self.broadcastDebt(debtorId: debtorId, creditorId: creditorId, debt: debt)
        }
        
    }
    
    func broadcastDebt(debtorId: String, creditorId: String, debt: Debt) {
        let debtId = debt.debtId.uuidString
        let debtData = ["date": debt.date,
                        "total": debt.total,
                        "creditorId": creditorId] as [String : Any]
        let creditData = ["date": debt.date,
                          "total": debt.total,
                          "debtorId": debtorId] as [String : Any]
        
        // Writing to debts
        let debtStore = Firestore.firestore().collection("debts").document(debtorId).collection("list").document(debtId)
        debtStore.setData(debtData)
        
        // Writing to credits
        let creditStore = Firestore.firestore().collection("credits").document(creditorId).collection("list").document(debtId)
        creditStore.setData(creditData)
        
        for item in debt.items {
            self.storeDebtItem(debtorId: debtorId, creditorId: creditorId, debtId: debtId, item: item)
        }
    }
    
    func storeDebtItem(debtorId: String, creditorId: String, debtId: String, item: Item) {
        let data = ["name": item.name,
                    "price": item.price] as [String : Any]
        
        Firestore.firestore().collection("debts")
            .document(debtorId)
            .collection("list")
            .document(debtId)
            .collection("items")
            .document(item.id.uuidString)
            .setData(data)
        
        Firestore.firestore().collection("credits")
            .document(creditorId)
            .collection("list")
            .document(debtId)
            .collection("items")
            .document(item.id.uuidString)
            .setData(data)
    }
    
    
//    func addDebt(id: String, creditorId: String) {
//        self.debts.append(Debt(id: id, creditorId: creditorId))
//    }
    
//    func selectNone() {
//        for user in self.userList {
//            user.isSelected = false
//        }
//    }
//
//    func selectUser(user: User) {
//        for user in self.userList {
//            user.isSelected = false
//        }
//        user.isSelected = true
//        selectedUser = user
//    }
//
//    func addItem(user: User?, item: Item) {
//        if user != nil {
//            user!.addItem(item: item)
//            self.itemList = self.itemList.filter { $0.id != item.id }
//        }
//    }
//
//    func addItemList(itemList: [Item]) {
//        self.itemList = itemList
//    }
//
//    func removeItem(user: User?, item: Item) {
//        if user != nil {
//            user!.removeItem(item: item)
//            self.itemList.append(item)
//        }
//    }
//
//    func addUser(user: User) {
//        self.userList.append(user)
//    }
//
//    func removeUser(user: User) {
//        if (user == self.selectedUser) {
//            self.selectedUser = nil
//            user.isSelected.toggle()
//        }
//        for item in user.itemList {
//            removeItem(user: user, item: item)
//        }
//        self.userList = self.userList.filter { $0.id != user.id }
//    }
}
