import SwiftUI

// LOGIN - DONE
struct ContentView: View {

    @EnvironmentObject var user: UserLoginModel

    var body: some View {
        NavigationView {

            //Login View
            if user.signedIn {

                Button(action: {
                    user.signOut()
                }, label: {
                    Text("Log Out")
                        .foregroundColor(Color.blue)
                })
            } else {
                LogInView()
                    .environmentObject(user)
            }
        }
        .onAppear(perform: {
            user.signedIn = user.isSignedIn()
        })
    }
}

//struct ContentView: View {
//    var body: some View {
//        Text("Hello World")
//            .padding()
//    }
//}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

