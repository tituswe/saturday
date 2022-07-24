//
//  SideMenuHeaderView.swift
//  Saturday
//
//  Created by Titus Lowe on 4/7/22.
//

import SwiftUI
import Kingfisher

struct SideMenuHeaderView: View {
    
    @EnvironmentObject var viewModel: UserViewModel
    
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
                    
                    Text(user.name)
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Text("@\(user.username)")
                        .font(.caption)
                        .padding(.bottom, 24)
                    
                    VStack(spacing: 12) {
                        
                        HStack(spacing: 4) {
                            
                            Text("+$" + String(format: "%.2f", viewModel.tracker?.totalReceivable ?? 999.99))
                                .font(.subheadline)
                                .fontWeight(.bold)
                            
                            Text("To Receive")
                                .font(.subheadline)
                            
                            Spacer()
                        }
                        
                        HStack(spacing: 4) {
                            
                            Text("-$" + String(format: "%.2f", viewModel.tracker?.totalPayable ?? 999.99))
                                .font(.subheadline)
                                .fontWeight(.bold)
                            
                            Text("To Pay")
                                .font(.subheadline)
                            
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

//struct SideMenuHeaderView_Previews: PreviewProvider {
//    static var previews: some View {
//        SideMenuHeaderView(isShowingSideMenu: .constant(true))
//            .environmentObject(UserViewModel())
//    }
//}
