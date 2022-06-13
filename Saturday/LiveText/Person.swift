//
//  Person.swift
//  Saturday
//
//  Created by Titus Lowe on 13/6/22.
//

import SwiftUI

final class PersonStore: ObservableObject {
    @Published var persons: [Person] = [Person(name: "Audrey", birthday: "Nov 26")]
}

struct Person: Identifiable {
    let id = UUID()
    let name: String
    let birthday: String
    var birthdate: Date {
        Person.dateFrom(birthday)
    }
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd yyyy"
        return dateFormatter
    }()
    
    static func dateFrom(_ dayString: String) -> Date {
        let dateString = dayString + " " + Date.now.formatted(.dateTime.year())
        if let date = Person.dateFormatter.date(from: dateString) {
            if date < .now {
                var dateComponent = DateComponents()
                dateComponent.year = 1
                return Calendar.current.date(byAdding: dateComponent, to: date) ?? .now
            }
            return date
        }
        return .now
    }
}
