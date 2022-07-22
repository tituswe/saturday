//
//  PaymentView.swift
//  Saturday
//
//  Created by Titus Lowe on 8/7/22.
//

import SwiftUI
import Kingfisher

struct PaymentView: View {
    
    @EnvironmentObject var viewModel: UserViewModel
    
    @Binding var isShowingPaymentView: Bool
    
    @State var amountPaid: String = ""
    
    let debt: Debt
    
    @FocusState var isFocused: Bool
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.systemGreen, Color.background]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
                .blur(radius: 50)
            
            ZStack(alignment: .topTrailing) {
                
                RoundedRectangle(cornerRadius: 50)
                    .foregroundColor(Color.background)
                    .frame(width: 320, height: 240)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                
                Button {
                    withAnimation(.spring()) {
                        isShowingPaymentView = false
                    }
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 20))
                        .foregroundColor(Color.text)
                }
                .padding(.top, 24)
                .padding(.trailing, 24)
                
            }
            
            VStack {
                
//                KFImage(URL(string: creditor().profileImageUrl))
//                    .resizable()
//                    .scaledToFill()
//                    .clipped()
//                    .frame(width: 88, height: 88)
//                    .clipShape(Circle())
//                    .overlay(Circle().stroke(Color.background, lineWidth: 3))
//                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                
                Avatar(avatarColor: creditor().color)
                
                Text("I paid \(userName())")
                    .font(.title3)
                    .frame(width: 240, height: 48)
                
                TextField("Amount", text: $amountPaid)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 18))
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .frame(width: 200, height: 48)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(50)
                    .focused($isFocused)
                
                Spacer()
                    .frame(height: 8)
                
                Button {
                    if (Double(amountPaid) == round(debt.total * 100)/100.0) {
                        print("test2")
                        viewModel.cacheTransaction(debt: debt)
                        viewModel.refresh()
                        isShowingPaymentView = false
                    }
                } label: {
                    Text("Pay up")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: 200, height: 48)
                        .background(Color.systemBlue)
                        .cornerRadius(50)
                }
                
            }
            .padding(.bottom, 64)
            
            if isFocused {
                Color.white.opacity(0.001)
                    .onTapGesture {
                        isFocused = false
                    }
            }
            
        }
        
    }
    
    func creditor() -> User {
        let uid = debt.creditorId
        let creditor = viewModel.queryUser(withUid: uid)
        return creditor
    }
    
    func userName() -> String {
        let name = creditor().name.components(separatedBy: " ").first!

        if name.count > 6 {
            return name.prefix(5) + "..."
        } else {
            return name
        }
    }
    
}

//struct PaymentView_Previews: PreviewProvider {
//    static var previews: some View {
//        PaymentView(isShowingPaymentView: .constant(true), debt: previewDebt)
//            .environmentObject(UserViewModel())
//    }
//}
