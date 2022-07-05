////
////  WelcomeView.swift
////  Saturday
////
////  Created by Joshua Tan on 13/6/22.
////
//
//import SwiftUI
//
//struct WelcomeView: View {
//
//    @EnvironmentObject var user: UserLoginModel
//
//    var body: some View {
//        
//        NavigationView {
//
//            VStack {
//
//                if user.signedIn {
//                    HomeView(databaseManager: DatabaseManager())
//                        .environmentObject(user)
//                } else {
//                    LogInView()
//                        .environmentObject(user)
//                }
//
//            }
//            .navigationBarHidden(true)
//
//        }
//        .onAppear(perform: {
//            user.signedIn = user.isSignedIn()
//        })
//
//    }
//}
//
//struct WelcomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        WelcomeView()
//            .environmentObject(UserLoginModel())
//    }
//}
