//
//  SentView.swift
//  Saturday2
//
//  Created by Titus Lowe on 29/6/22.
//

import SwiftUI

struct SentView: View {
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                Text("Split Sent!")
                    .font(.system(.title2, design: .rounded))
                    .fontWeight(.bold)
                    .padding()
                
                NavigationLink {
                    // TODO: Fix navigation back to Dashboard
                    HomeView(databaseManager: DatabaseManager())
                        .navigationBarHidden(true)
                } label: {
                    Text("Return to Dashboard")
                        .font(.system(.body, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50)
                        .background(Color.systemBlue)
                        .cornerRadius(50)
                        .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
                        .padding()
                }
                
            }
            .navigationBarHidden(true)
            
        }
        
    }
    
}

struct SentView_Previews: PreviewProvider {
    static var previews: some View {
        SentView()
    }
}
