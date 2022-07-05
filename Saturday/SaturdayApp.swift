//
//  SaturdayApp.swift
//  Saturday
//
//  Created by Titus Lowe on 19/5/22.
//

import SwiftUI
import FirebaseCore

/* Adding Firebase Initialisation Code */
//class AppDelegate: NSObject, UIApplicationDelegate {
//    func application(_ application: UIApplication,
//                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
//        FirebaseApp.configure()
//
//        return true
//    }
//}

@main
struct SaturdayApp: App {
    //    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject var viewModel = AuthenticationViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        
        WindowGroup {
            //            let user = UserLoginModel()
            //
            //            if user.signedIn == false {
            //                WelcomeView()
            //                    .environmentObject(user)
            //                HomeView(databaseManager: previewDatabaseManager)
            //            }
            NavigationView {
                ContentView()
                    .navigationBarHidden(true)
            }
            .environmentObject(viewModel)
        }
    }
}
