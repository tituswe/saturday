//
//  SettleDebtView.swift
//  Saturday
//
//  Created by Titus Lowe on 7/7/22.
//

import SwiftUI

struct SettleDebtView: View {
    
    @EnvironmentObject var viewModel: UserViewModel
    
    let debt: Debt
    
    @Binding var isShowingSettleDebtView: Bool
    
    @Binding var isShowingPaymentView: Bool
    
    var body: some View {
        
        VStack {
            
            // MARK: Navigation Bar
            NavbarView(
                topLeftButtonView: "",
                topRightButtonView: "",
                titleString: "To pay",
                topLeftButtonAction: {},
                topRightButtonAction: {})
            
            Spacer()
            
            ScrollView {
                
                LazyVStack {
                    
                    ForEach(viewModel.debtItems[debt.transactionId] ?? [Item](), id: \.id) { item in
                        ItemCardView(item: item, state: .VIEW)
                            .environmentObject(viewModel)
                            .environmentObject(CartManager())
                        Divider()
                    }
                    
                }
                
            }
            
            Button {
                isShowingSettleDebtView = false
                isShowingPaymentView = true
//                viewModel.cacheTransaction(debt: debt)
//                viewModel.refresh()
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 50)
                        .foregroundColor(Color.systemGreen)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: -3)
                    
                    Text("Settle")
                        .font(.system(.title2, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 80)
            
        }
        .ignoresSafeArea(.all, edges: [.bottom])
        
    }
    
}

struct SettleDebtView_Previews: PreviewProvider {
    static var previews: some View {
        SettleDebtView(debt: previewDebt,
                       isShowingSettleDebtView: .constant(true),
                       isShowingPaymentView: .constant(false))
            .environmentObject(UserViewModel())
    }
}
