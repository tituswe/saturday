//
//  SaturdayApp.swift
//  Saturday
//
//  Created by Titus Lowe on 19/5/22.
//

import SwiftUI
import FirebaseCore

@main
struct SaturdayApp: App {
    
    @StateObject var viewModel = UserViewModel()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        
        WindowGroup {
            
                ContentView()
                    .environmentObject(viewModel)
                    .navigationBarHidden(true)
            
        }
        
    }
}
