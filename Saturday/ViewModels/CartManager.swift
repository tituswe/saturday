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
    @Published var transactions = [String: Transaction]()
    @Published var selectedMap = [String: Bool]()
    
    @Published var isMultiSplit: Bool = false
    @Published var serviceFees: String = ""
    
    init() {
        self.userSession = Auth.auth().currentUser
        self.fetchCreditor()
    }
    
    private let service = UserService()
    
    func fetchCreditor() {
        guard let uid = self.userSession?.uid else { return }

        service.fetchUser(withUid: uid) { creditor in
            self.creditor = creditor
        }
    }
    
    func fetchDebtor(debtorId: String) -> User {
        for user in self.payableUsers {
            if user.id == debtorId {
                return user
            }
        }
        return User(id: "NULL",
                    name: "NULL",
                    username: "NULL",
//                    profileImageUrl: "NULL",
                    color: 0,
                    email: "NULL",
                    deviceToken: "NULL")
    }
    
    func updateAllUsers(allUsers: [User], currentUser: User) {
        self.allUsers = allUsers
        self.allUsers.sort { $0.name.lowercased() < $1.name.lowercased() }
        self.allUsers.insert(currentUser, at: 0)
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
        
        guard let items = self.transactions[uid]?.getItems() else { return }
        
        self.addItemsToPayableItems(items: items)
        self.transactions.removeValue(forKey: uid)
    }
    
    func selectUser(user: User) {
        guard let uid = user.id else { return }
        
        if self.isMultiSplit {
            self.selectedMap[uid]?.toggle()
        } else {
            self.selectedMap.keys.forEach { selectedMap[$0] = false }
            self.selectedMap[uid]?.toggle()
        }
    }
    
    func selectNone() {
        self.selectedMap.keys.forEach { selectedMap[$0] = false }
    }
    
    func getTransaction(key: String) -> Transaction {
        guard let transaction = self.transactions[key] else { return Transaction(id: "NIL") }
        
        return transaction
    }
    
    func getTransactionItems(key: String) -> [Item] {
        return self.getTransaction(key: key).items
    }
    
    func getTransactionItemsCount(key: String) -> Int {
        return self.getTransactionItems(key: key).count
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
    
    func addItemToTransaction(item: Item) {
        let noOfSelected = self.selectedMap.filter({$0.value == true}).count
        if noOfSelected == 0 { return }
        
        let splitItem = Item(
            id: item.id,
            name: item.name,
            price: item.price/Double(noOfSelected),
            noOfDuplicates: noOfSelected)
        
        self.selectedMap.keys.forEach {
            if selectedMap[$0] == true {
                self.transactions[$0]?.addItem(item: splitItem)
            }
        }
        self.payableItems = self.payableItems.filter { $0.id != item.id }
    }
    
    func removeItemFromTransaction(item: Item, user: User) {
        let amountToAdd = item.noOfDuplicates == 1 ? 0 : item.price/Double(item.noOfDuplicates - 1)
        
        let replacementItem = Item(
            id: item.id,
            name: item.name,
            price: item.price + amountToAdd,
            noOfDuplicates: item.noOfDuplicates == 1 ? item.noOfDuplicates : item.noOfDuplicates - 1)
        
        var usersWithDuplicates: [String] = []
        
        for (userId, userTransaction) in self.transactions {
            for targetItem in userTransaction.items {
                if targetItem.id == item.id {
                    usersWithDuplicates.append(userId)
                }
            }
        }
        
        for userId in usersWithDuplicates {
            self.transactions[userId]?.removeItem(item: item)
            if userId != user.id {
                self.transactions[userId]?.addItem(item: replacementItem)
            }
        }
        
        if item.noOfDuplicates == 1 {
            self.payableItems.append(replacementItem)
        }
    }
    
    func addServiceFees() {
        guard let fees = Double(serviceFees) else { return }
        
        let serviceItem = Item(id: UUID().uuidString, name: "Service Fees", price: fees/Double(payableUsers.count), noOfDuplicates: payableUsers.count)
        
        self.transactions.keys.forEach {
            transactions[$0]?.addItem(item: serviceItem)
        }
    }
    
    // MARK: Firestore
    
    func broadcastTransactions() {
        guard let creditor = creditor else { return }
        guard let creditorId = creditor.id else { return }
        
        addServiceFees()
        self.transactions.keys.forEach { debtorId in
            guard let transaction = transactions[debtorId] else { return }
            
            if !transaction.items.isEmpty && transaction.id != creditorId {
                self.broadcastTransaction(debtorId: debtorId, creditorId: creditorId, transaction: transaction)
                
                //Send notification to debtor
                let debtor = self.fetchDebtor(debtorId: debtorId)
                NotificationManager.instance.sendDebtNotificationTo(creditor: creditor, debtor: debtor, amount: transaction.total)
            }
        }
        
    }
    
    func broadcastTransaction(debtorId: String, creditorId: String, transaction: Transaction) {
        let transactionId = transaction.transactionId
        let debtData = ["transactionId": transactionId,
                        "date": transaction.date,
                        "total": transaction.total,
                        "creditorId": creditorId] as [String : Any]
        let creditData = ["transactionId": transactionId,
                          "date": transaction.date,
                          "total": transaction.total,
                          "debtorId": debtorId] as [String : Any]
        
        // Writing to debts
        let debtStore = Firestore.firestore().collection("debts").document(debtorId).collection("transactions").document(transactionId)
        debtStore.setData(debtData)
        
        // Writing to credits
        let creditStore = Firestore.firestore().collection("credits").document(creditorId).collection("transactions").document(transactionId)
        creditStore.setData(creditData)
        
        for item in transaction.items {
            self.storeTransactionItem(debtorId: debtorId, creditorId: creditorId, transactionId: transactionId, item: item)
        }
        
        // Update monthly trackers
        Firestore.firestore().collection("trackers")
            .document(debtorId)
            .updateData(["netMonthly": FieldValue.increment(-transaction.total),
                         "totalPayable": FieldValue.increment(transaction.total)])
        
        Firestore.firestore().collection("trackers")
            .document(creditorId)
            .updateData(["netMonthly": FieldValue.increment(transaction.total),
                         "totalReceivable": FieldValue.increment(transaction.total)])
    }
    
    func storeTransactionItem(debtorId: String, creditorId: String, transactionId: String, item: Item) {
        guard let itemId = item.id else { return }
        
        let data = ["name": item.name,
                    "price": item.price,
                    "noOfDuplicates": item.noOfDuplicates] as [String : Any]
        
        Firestore.firestore().collection("debts")
            .document(debtorId)
            .collection("transactions")
            .document(transactionId)
            .collection("items")
            .document(itemId)
            .setData(data)
        
        Firestore.firestore().collection("credits")
            .document(creditorId)
            .collection("transactions")
            .document(transactionId)
            .collection("items")
            .document(itemId)
            .setData(data)
    }
    
}
