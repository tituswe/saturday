//
//  SideMenuHeaderView.swift
//  Saturday
//
//  Created by Titus Lowe on 4/7/22.
//

import SwiftUI

struct SideMenuHeaderView: View {
    
    @Binding var isShowingSideMenu: Bool
    
    var body: some View {
        
        ZStack(alignment: .topTrailing) {
            
            Button {
                withAnimation(.spring()) {
                    isShowingSideMenu = false
                }
            } label: {
                Image(systemName: "xmark")
                    .frame(width: 32, height: 32)
                    .foregroundColor(.white)
                    .padding()
            }

            
            VStack(alignment: .leading) {
                
                Image("profilePicture")
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .frame(width: 64, height: 64)
                    .clipShape(Circle())
                    .padding(.bottom, 16)
                
                Text("Full Name") // TODO: Link to name
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.semibold)
                
                Text("@username") // TODO: Link to username
                    .font(.system(.caption, design: .rounded))
                    .padding(.bottom, 24)
                
                VStack(spacing: 12) {
                    
                    HStack(spacing: 4) {
                        
                        Text("+$144.25")
                            .font(.system(.subheadline, design: .rounded))
                            .fontWeight(.bold)
                        
                        Text("To Receive")
                            .font(.system(.subheadline, design: .rounded))
                        
                        Spacer()
                    }
                    
                    HStack(spacing: 4) {
                        
                        Text("-$62.00")
                            .font(.system(.subheadline, design: .rounded))
                            .fontWeight(.bold)
                        
                        Text("To Pay")
                            .font(.system(.subheadline, design: .rounded))
                        
                        Spacer()
                        
                    }
                    
                }
                
                Spacer()
                
            }
            .foregroundColor(.white)
            .padding()
            
        }
        
    }
    
}

struct SideMenuHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuHeaderView(isShowingSideMenu: .constant(true))
    }
}
