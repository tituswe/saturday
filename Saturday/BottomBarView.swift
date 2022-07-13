//
//  BottomBarView.swift
//  Saturday
//
//  Created by Titus Lowe on 13/7/22.
//

import SwiftUI

struct BottomBarView: View {
    
    var body: some View {
        
        ZStack {
            
            Rectangle()
                .foregroundColor(Color.white)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: -3)
                .mask(Rectangle().padding(.top, -20))
            
            SaturdayLogo()
                .frame(width: 40, height: 40)
                .padding(.bottom, 12)
            
        }
        .frame(maxWidth: .infinity, maxHeight: 88)
        .ignoresSafeArea()
        
    }
    
}

struct BottomBarView_Previews: PreviewProvider {
    static var previews: some View {
        BottomBarView()
    }
}
