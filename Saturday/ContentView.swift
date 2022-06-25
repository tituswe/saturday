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
    
    @Binding var temp: Bool
    @Binding var temp2: Bool
//    var receipt: Image
    @Binding var model: TextExtractionModel
    
    var body: some View {
        Text("Currently showing ContentView. \n \nThis should instead be the Upload from Gallery page")
            .padding()
        
        Button("Select and Upload Receipt1") {
            temp.toggle()
            self.model.insertReceipt(fileName: "receipt1")
            temp2.toggle()
        }
        .padding()
        
        Button("Select and Upload Receipt2") {
            temp.toggle()
            self.model.insertReceipt(fileName: "receipt2")
            temp2.toggle()
        }
        .padding()
        
        Button("Select and Upload Receipt3") {
            temp.toggle()
            self.model.insertReceipt(fileName: "receipt3")
            temp2.toggle()
        }
        .padding()
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView(temp: true)
//    }
//}

