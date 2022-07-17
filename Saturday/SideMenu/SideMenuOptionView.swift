//
//  SideMenuOptionView.swift
//  Saturday
//
//  Created by Titus Lowe on 4/7/22.
//

import SwiftUI

struct SideMenuOptionView: View {
    
    let title: String
    
    let imageName: String
    
    var body: some View {
        
        HStack(spacing: 16) {
            
            Image(systemName: imageName)
                .frame(width: 24, height: 24)
            
            
            Text(title)
                .fontWeight(.semibold)
            
            Spacer()
            
        }
        .foregroundColor(.white)
        .padding()
        
    }
    
}

struct SideMenuOptionView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuOptionView(title: "Profile", imageName: "person")
    }
}
