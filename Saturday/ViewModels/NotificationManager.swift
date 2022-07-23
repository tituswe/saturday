//
//  NotificationManager.swift
//  Saturday
//
//  Created by Titus Lowe on 19/7/22.
//

import SwiftUI
import FirebaseMessaging

class NotificationManager {
    
    static let instance = NotificationManager() // Singleton
    
    let serverKey = "AAAAPoK8GAA:APA91bFmUsQ__jIshC8-X0XWi_-N_TZACOWgLDCv44AEXqbjQYEJxA7zWmiriaovbq9eM7rTeIWUgRNqxLL9v7RJByBSycd5RmMIYMpJS8NcPAKazx4XdGiuRy_MiJQk1ovHw7KvWGC6"
   
    func sendDebtNotificationTo(creditor: User, debtor: User, amount: Double) {
        guard let url = URL(string: "https://fcm.googleapis.com/fcm/send") else { return }
        
        let json: [String: Any] = [
            
            "to": debtor.deviceToken,
            "notification": [
                "title": "You owe \(creditor.name)",
                "body": "Please pay $" + String(format: "%.2f", amount) + " to \(creditor.name)",
            ]
            
        ]
        
        //URL Requst...
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        //Converting json Dict to JSON...
        request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted])
        
        //Setting Content Type and Authorization...
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //Authorization ket will be in our server...
        request.setValue("key=\(serverKey)", forHTTPHeaderField: "Authorization")
        
        //Passing request using URL session...
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: request) { _, _, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
        }.resume()
    }
    
    func sendPaidNotification(creditor: User, debtor: User, amount: Double) {
        guard let url = URL(string: "https://fcm.googleapis.com/fcm/send") else { return }
        
        let json: [String: Any] = [
            
            "to": creditor.deviceToken,
            "notification": [
                "title": "Received payment from \(debtor.name)",
                "body": "\(debtor.name) has paid you $" + String(format: "%.2f", amount),
            ]
            
        ]
        
        //URL Requst...
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        //Converting json Dict to JSON...
        request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted])
        
        //Setting Content Type and Authorization...
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //Authorization ket will be in our server...
        request.setValue("key=\(serverKey)", forHTTPHeaderField: "Authorization")
        
        //Passing request using URL session...
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: request) { _, _, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
        }.resume()
    }
    
    func sendCancelRequest(creditor: User, debtor: User, amount: Double) {
        guard let url = URL(string: "https://fcm.googleapis.com/fcm/send") else { return }
        
        let json: [String: Any] = [
            
            "to": creditor.deviceToken,
            "notification": [
                "title": "Cancel Request",
                "body": "\(debtor.name) has requested to cancel a split of $" + String(format: "%.2f", amount),
            ]
            
        ]
        
        //URL Requst...
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        //Converting json Dict to JSON...
        request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted])
        
        //Setting Content Type and Authorization...
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //Authorization ket will be in our server...
        request.setValue("key=\(serverKey)", forHTTPHeaderField: "Authorization")
        
        //Passing request using URL session...
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: request) { _, _, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
        }.resume()
    }
    
    func sendSplitCancelled(creditor: User, debtor: User, amount: Double) {
        guard let url = URL(string: "https://fcm.googleapis.com/fcm/send") else { return }
        
        let json: [String: Any] = [
            
            "to": debtor.deviceToken,
            "notification": [
                "title": "Split Cancelled",
                "body": "\(creditor.name) has cancelled your split of $" + String(format: "%.2f", amount),
            ]
            
        ]
        
        //URL Requst...
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        //Converting json Dict to JSON...
        request.httpBody = try? JSONSerialization.data(withJSONObject: json, options: [.prettyPrinted])
        
        //Setting Content Type and Authorization...
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //Authorization ket will be in our server...
        request.setValue("key=\(serverKey)", forHTTPHeaderField: "Authorization")
        
        //Passing request using URL session...
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: request) { _, _, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
        }.resume()
    }
    
}
