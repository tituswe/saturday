//
//  PaymentView.swift
//  Saturday
//
//  Created by Titus Lowe on 8/7/22.
//

import SwiftUI

struct PaymentView: View {
    
    @EnvironmentObject var viewModel: UserViewModel
    
    @Binding var isShowingPaymentView: Bool
   
    @State var amountPaid: String = ""
    
    let debt: Debt
    
    var body: some View {
        // TODO: Link to payment services
       
        VStack {
            TextField("Input Amount Transferred", text: $amountPaid)
                .keyboardType(.decimalPad)
                .multilineTextAlignment(.center)
                .font(.system(size: 18))
                .disableAutocorrection(true)
                .autocapitalization(.none)
                .padding()
                .frame(width: 300, height: 50)
                .background(Color.black.opacity(0.05))
                .cornerRadius(50)
                .padding()
            
            Button {
                if (Double(amountPaid) == debt.total) {
                    viewModel.cacheTransaction(debt: debt)
                }
            } label: {
                Text("Pay up")
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .frame(width: 300, height: 50)
                    .background(Color.systemBlue)
                    .cornerRadius(50)
                    .padding()
            }
        }
    }
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView(isShowingPaymentView: .constant(true), debt: previewDebt)
            .environmentObject(UserViewModel())
    }
}
