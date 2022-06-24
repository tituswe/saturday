import SwiftUI

/* Live Text - testing code
struct ContentView: View {
    @State private var showAddPerson = false
    @StateObject private var people = PersonStore()
    
    var body: some View {
        NavigationView {
            List(people.persons) { person in
                VStack(alignment: .leading) {
                    Text(person.name)
                        .font(.largeTitle)
                    HStack {
                        Text("Birthday " + person.birthday)
                        Text(person.birthdate.formatted(
                            .relative(
                                presentation: .named,
                                unitsStyle: .wide)))
                    }
                }
            }
            .sheet(isPresented: $showAddPerson) {
                AddPersonView(people: people)
            }
            .navigationTitle("Wait For It")
            .toolbar {
                ToolbarItem {
                    // swiftlint:disable:next multiple_closures_with_trailing_closure
                    Button(action: { showAddPerson.toggle() }) {
                        Image(systemName: "plus.circle")
                            .font(.title)
                    }
                }
            }
        }
    }
}
*/

struct ContentView: View {
    var body: some View {
      Text("Welcome to Saturday")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

