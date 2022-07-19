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
    
    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        
        UNUserNotificationCenter.current().requestAuthorization(options: options) { success, error in
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
            } else {
                print("SUCCESS")
            }
        }
    }
    
    func scheduleNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Notifcation"
        content.body = "Blablabla"
        content.sound = .default
        content.badge = 1
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5.0, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
    func dailyNotification(debts: [Debt], credits: [Credit]) {
        let content = UNMutableNotificationContent()
        content.title = "Daily breakdown"
        content.body = "\(debts.count) debt\(debts.count == 1 ? "s" : "") outstanding\n\(credits.count) credit\(credits.count == 1 ? "s" : "") to collect"
        content.sound = .default
        content.badge = 1
        
        var dateComponents = DateComponents()
        dateComponents.hour = 10
        dateComponents.minute = 00
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
   
    func sendDebtNotificationTo(user: User, transaction: Transaction) {
        
        guard let url = URL(string: "//fcm.googleapis.com/fcm/send") else { return }
        
        let json: [String: Any] = [
        
            "to": user.deviceToken,
            "notification": [
            
                "title": "You owe \(user.name)",
                "body": "Please pay \(transaction.total) to \(user.name)"
            ]
        ]
        
        let serverKey = "AAAAvA1rjwA:APA91bHZ3Da7JMWVlV_pyf8TYGvCpOvpdxm5PDe_hsuRdb4yjV1kfx1WO2CQSC3jA5YCsTeRveG03tetJRaQcgfpE0sfKPjHUOaALdqqdGl3I4RKmH8j14V9xhReltSx2ui4Nieym6jK"
        
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
            
            print("Debt Notification sent to \(user.name)")
        }
    }
}
