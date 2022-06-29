//
//  ConfirmView.swift
//  Saturday2
//
//  Created by Titus Lowe on 29/6/22.
//

import SwiftUI

struct ConfirmView: View {
    
    @EnvironmentObject var cartManager: CartManager
    
    @Binding var isShowingConfirmView: Bool
    
    @Binding var isShowingSentView: Bool
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                // MARK: Navigation Bar
                NavbarView(
                    topLeftButtonView: "line.horizontal.3",
                    topRightButtonView: "circle.dashed",
                    titleString: "Your Split",
                    topLeftButtonAction: {},
                    topRightButtonAction: {})
                
                ScrollView {
                    
                    ForEach(cartManager.userList, id: \.id) { user in
                        
                        CartView(user: user, showNavigationBar: false)
                            .environmentObject(cartManager)
                            .padding()
                        
                        Divider()
                        
                    }
                    
                }
                .frame(height: 550)
                
                Button {
                    self.isShowingConfirmView = false
                    self.isShowingSentView = true
                } label: {
                    Text("Send Split")
                        .font(.system(.title3, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50)
                        .background(Color.systemBlue)
                        .cornerRadius(50)
                        .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
                }
                .padding()
                
            }
            .navigationBarHidden(true)
            
        }
        
    }
    
}

struct ConfirmView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmView(isShowingConfirmView: .constant(true), isShowingSentView: .constant(false))
            .environmentObject(previewCartManager)
    }
}
