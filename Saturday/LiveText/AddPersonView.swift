//
//  AddPersonView.swift
//  Saturday
//
//  Created by Titus Lowe on 13/6/22.
//

import SwiftUI

struct AddPersonView: View {
    @Environment(\.dismiss) var dismiss
    @State private var name = ""
    @State private var birthday = ""
    @ObservedObject var people: PersonStore
    
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Name", text: $name)
                        .toolbar {
                            ToolbarItemGroup(placement: .keyboard) {
                                Spacer()
                                ScanButton(text: $birthday)
                            }
                        }
                    ScanButton(text: $name)
                        .frame(width: 100, height: 56, alignment: .leading)
                }
                TextField("Birthday: Mmm dd", text: $birthday)
                Button("Done") {
                    if !name.isEmpty {
                        let newPerson = Person(name: name, birthday: birthday)
                        people.persons.append(newPerson)
                    }
                    dismiss()
                }
                Spacer()
            }
            .navigationTitle("Add a Person")
            .disableAutocorrection(true)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .padding()
            .environment(\.textCase, nil)
        }
    }
}

struct AddPersonView_Previews: PreviewProvider {
    static var previews: some View {
        AddPersonView(people: PersonStore())
    }
}
