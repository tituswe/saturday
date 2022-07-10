//
//  PaymentView.swift
//  Saturday
//
//  Created by Titus Lowe on 8/7/22.
//

import SwiftUI

struct PaymentView: View {
    
    @EnvironmentObject var viewModel: UserViewModel
    
    let debt: Debt
    
    var body: some View {
        // TODO: Link to payment services
        Button {
            viewModel.cacheTransaction(debt: debt)
            viewModel.refresh()
        } label: {
            Text("Pay up")
        }

    }
}

struct PaymentView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentView(debt: previewDebt)
            .environmentObject(UserViewModel())
    }
}
