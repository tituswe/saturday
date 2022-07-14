//
//  PaymentView.swift
//  Saturday
//
//  Created by Titus Lowe on 8/7/22.
//

import SwiftUI

struct PaymentView: View {
    
    @EnvironmentObject var viewModel: UserViewModel
    
    @Environment(\.openURL) var openURL
    
    let debt: Debt
    
    var body: some View {
        // TODO: Link to payment services
        Button {
            if let url = URL(string: "applestore://") {
                openURL(url)
            }
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
