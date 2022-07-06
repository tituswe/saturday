//
//  SideMenuHeaderView.swift
//  Saturday
//
//  Created by Titus Lowe on 4/7/22.
//

import SwiftUI
import Kingfisher

struct SideMenuHeaderView: View {
    
    @EnvironmentObject var viewModel: AuthenticationViewModel
    
    @Binding var isShowingSideMenu: Bool
    
    var body: some View {
        
        if let user = viewModel.currentUser {
            
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
                    
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .frame(width: 64, height: 64)
                        .clipShape(Circle())
                        .padding(.bottom, 16)
                    
                    Text(user.name) // TODO: Link to name
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.semibold)
                    
                    Text("@\(user.username)") // TODO: Link to username
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
    
}

struct SideMenuHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuHeaderView(isShowingSideMenu: .constant(true))
            .environmentObject(AuthenticationViewModel())
    }
}
