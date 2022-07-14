//
//  DebtCardView.swift
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
                    .frame(width: 256)
                
                Button {
                    isShowingPaymentView = true
                } label: {
                    Image(systemName: "creditcard.fill")
                        .font(.title3)
                        .foregroundColor(.white)
                }
                .frame(width: 40, height: 80)
                
            }
            
            ZStack {
                
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(Color.background)
                
                HStack {
                    
                    KFImage(URL(string: creditor().profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .frame(width: 64, height: 64)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.background, lineWidth: 3))
                    
                    VStack(alignment: .leading) {
                        
                        Text(debt.date)
                            .font(.system(size: 9))
                            .foregroundColor(Color.gray)
                            .padding(.leading, 4)
                        
                        Button {
                           print("TODO: Send notification reminder")
                        } label: {
                            Text("Send a reminder")
                                .font(.system(size: 10))
                                .foregroundColor(Color.white)
                                .frame(width: 112, height: 24)
                                .background(Color.systemViolet)
                                .cornerRadius(10)
                        }
                        
                        Button {
                            viewModel.refresh()
                            isShowingSettleDebtView = true
                        } label: {
                            Text("Settle up")
                                .font(.system(size:10))
                                .foregroundColor(Color.white)
                                .frame(width: 112, height: 24)
                                .background(Color.systemIndigo)
                                .cornerRadius(10)
                        }
                        
                    }
                    .padding(.horizontal, 8)
                    
                    VStack(alignment: .trailing) {
                        
                        Text(userName())
                            .font(.system(size: 16))
                            .foregroundColor(Color.gray)
                        
                        Text("$" + String(format: "%.2f", debt.total))
                            .font(.system(size: 20))
                        
                    }
                    .frame(width: 80)
                    
                }
                
            }
            .frame(width: 350, height: 150)
            .offset(x: offset)
            .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnd(value:)))
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
        .frame(width: 320, height: 96)
        .background(Color.background)
        .cornerRadius(25)
        .padding(.top, 16)
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
        
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
                } else if -offset > 48 {
                    // Updating is swiping
                    isSwiped = true
                    offset = -88
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
//            .environment(\.colorScheme, .dark)
    }
}
