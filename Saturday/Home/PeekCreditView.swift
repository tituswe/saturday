//
//  PeekCreditView.swift
//  Saturday
//
//  Created by Titus Lowe on 13/7/22.
//

import SwiftUI

struct PeekCreditView: View {
    
    @EnvironmentObject var viewModel: UserViewModel
    
    let credit: Credit
    
    @Binding var isShowingPeekCreditView: Bool
    
    var body: some View {
        
        VStack {
            
            // MARK: Navigation Bar
            NavBarView(
                topLeftButtonView: "",
                topRightButtonView: "",
                titleString: "To receive",
                topLeftButtonAction: {},
                topRightButtonAction: {})
            
            Spacer()
            
            ScrollView {
                
                LazyVStack {
                    
                    ForEach(viewModel.creditItems[credit.transactionId] ?? [Item](), id: \.id) { item in
                        ItemCardView(item: item, state: .VIEW)
                            .environmentObject(viewModel)
                            .environmentObject(CartManager())
                        Divider()
                    }
                    
                }
                
                HStack {
                    
                    Text("Total: $" + String(format: "%.2f", credit.total))
                        .font(.system(.body, design: .rounded))
                        .fontWeight(.semibold)
                        .padding()
                    
                    Spacer()
                    
                }
                
            }
            
            Button {
                viewModel.cacheTransaction(credit: credit)
                viewModel.refresh()
                isShowingPeekCreditView = false
            } label: {
                ZStack {
                    RoundedRectangle(cornerRadius: 50)
                        .foregroundColor(Color.systemRed)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: -3)
                    
                    Text("Cancel")
                        .font(.system(.title2, design: .rounded))
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: 80)
            
        }
        .ignoresSafeArea(.all, edges: [.top, .bottom])
        .background(Color.background)
        
    }
    
}

struct PeekCreditView_Previews: PreviewProvider {
    static var previews: some View {
        PeekCreditView(credit: previewCredit, isShowingPeekCreditView: .constant(true))
            .environmentObject(UserViewModel())
    }
}
