//
//  DebtCard.swift
//  Saturday
//
//  Created by Titus Lowe on 5/7/22.
//

import SwiftUI
import Kingfisher

struct DebtCardView: View {
    
    @EnvironmentObject var viewModel: UserViewModel
    
    let debt: Debt
    
    @State var isShowingSettleDebtView: Bool = false
    
    @State var offset: CGFloat = 0
    
    @State var isSwiped: Bool = false
    
    @State var isShowingPaymentView: Bool = false
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.systemGreen]), startPoint: .leading, endPoint: .trailing)
            
            HStack {
                
                Spacer()
                
                Button {
                    isShowingPaymentView = true
                } label: {
                    Image(systemName: "creditcard.fill")
                        .font(.title2)
                        .foregroundColor(.white)
                }
                .frame(width: 80, height: 120)
            }
            
            ZStack {
                
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(.white)
                
                HStack {
                    
                    VStack {
                        
                        Text(debt.date)
                            .font(.system(.footnote, design: .rounded))
                            .foregroundColor(.gray)
                        
                        Spacer()
                            .frame(height: 2)
                        
                        Text("You owe \(creditor().name.components(separatedBy: " ").first!)")
                            .font(.system(.body, design: .rounded))
                            .fontWeight(.semibold)
                        
                    }
                    .padding(.leading, 25)
                    
                    Spacer()
                    
                    VStack {
                        
                        Text("$" + String(format: "%.2f", debt.total))
                            .font(.system(.title3, design: .rounded))
                            .fontWeight(.semibold)
                        
                        HStack {
                            
                            if let user = viewModel.currentUser {
                                
                                KFImage(URL(string: creditor().profileImageUrl))
                                    .resizable()
                                    .scaledToFill()
                                    .clipped()
                                    .frame(width: 32, height: 32)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.systemGreen, lineWidth: 3))
                                
                                KFImage(URL(string: user.profileImageUrl))
                                    .resizable()
                                    .scaledToFill()
                                    .clipped()
                                    .frame(width: 24, height: 24)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.systemRed, lineWidth: 2.25))
                                
                            }
                            
                        }
                        
                    }
                    .padding(.trailing, 25)
                    
                }
                
            }
            .frame(width: 350, height: 150)
            .offset(x: offset)
            .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnd(value:)))
            .onTapGesture {
                viewModel.refresh()
                isShowingSettleDebtView = true
            }
            .sheet(isPresented: $isShowingSettleDebtView) {
                SettleDebtView(debt: debt,
                               isShowingSettleDebtView: $isShowingSettleDebtView,
                               isShowingPaymentView: $isShowingPaymentView)
                    .environmentObject(viewModel)
            }
            .sheet(isPresented: $isShowingPaymentView, onDismiss: resetOffset) {
                // TODO: Link to payment services
                PaymentView(debt: debt)
                    .environmentObject(viewModel)
            }
            
        }
        .frame(width: 350, height: 150)
        .background()
        .cornerRadius(25)
        .padding(.top, 16)
        .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
        
    }
    
    func creditor() -> User {
        let uid = debt.creditorId
        let creditor = viewModel.queryUser(withUid: uid)
        return creditor
    }
    
    func resetOffset() {
        withAnimation(.easeIn) {
            offset = 0
        }
    }
    
    func onChanged(value: DragGesture.Value) {
        if value.translation.width < 0 {
            offset = value.translation.width
        }
    }
    
    func onEnd(value: DragGesture.Value) {
        withAnimation(.easeOut) {
            if value.translation.width < 0 {
                // Checking if ended
                if -value.translation.width > UIScreen.main.bounds.width / 2 {
                    offset = -1000
                    isShowingPaymentView = true
                } else if -offset > 50 {
                    // Updating is swiping
                    isSwiped = true
                    offset = -90
                } else {
                    isSwiped = false
                    offset = 0
                }
            } else {
                isSwiped = false
                offset = 0
            }
        }
    }
}

struct DebtCardView_Previews: PreviewProvider {
    static var previews: some View {
        DebtCardView(debt: previewDebt)
            .environmentObject(UserViewModel())
    }
}
