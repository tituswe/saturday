//
//  ConfirmationView.swift
//  Saturday
//
//  Created by Titus Lowe on 27/6/22.
//

import SwiftUI

struct ConfirmationView: View {
    
    @EnvironmentObject var cartManager: CartManager
    
    @EnvironmentObject var user: UserLoginModel
    
    @State var isShowingSentView: Bool = false
    
    var body: some View {
        ScrollView {
            ForEach(cartManager.carts.indices) { i in
                CartView(cartNumber: i)
                    .environmentObject(cartManager)
                    .padding()
                Divider()
            }
            
            Button {
                isShowingSentView = true
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
            
            NavigationLink(isActive: $isShowingSentView) {
                SentView()
                    .environmentObject(user)
            } label: {
                Text("")
            }

        }
        .navigationTitle(Text("Confirm Split"))
    }
}

struct ConfirmationView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationView()
            .environmentObject(CartManager(model: TextExtractionModel(referenceReceipt: UIImage(named: "receipt1")!), friends: friendList))
            .environmentObject(UserLoginModel())
    }
}
