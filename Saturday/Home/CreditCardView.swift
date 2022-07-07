//
//  CreditCardView.swift
//  Saturday
//
//  Created by Titus Lowe on 7/7/22.
//

import SwiftUI
import Kingfisher

struct CreditCardView: View {
    
    @EnvironmentObject var viewModel: UserViewModel
    
    let credit: Credit
    
    var body: some View {
        
        HStack {
            
            VStack {
                
                Text(credit.date)
                    .font(.system(.footnote, design: .rounded))
                    .foregroundColor(.gray)
                
                Spacer()
                    .frame(height: 2)
                Text("\(debtor().name.components(separatedBy: " ").first!) owes You")
                    .font(.system(.body, design: .rounded))
                    .fontWeight(.semibold)
                
            }
            .padding(.leading, 25)
            
            Spacer()
            
            VStack {
                
                Text("$" + String(format: "%.2f", credit.total))
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.semibold)
                
                HStack {
                    
                    KFImage(URL(string: viewModel.currentUser!.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .frame(width: 32, height: 32)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.systemGreen, lineWidth: 3))
                    
                    KFImage(URL(string: debtor().profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .frame(width: 24, height: 24)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.systemRed, lineWidth: 2.25))
                    
                }
                
            }
            .padding(.trailing, 25)
            
        }
        .frame(width: 350, height: 150)
        .background()
        .cornerRadius(25)
        .padding(10)
        .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
    }
    
    func debtor() -> User {
        let uid = credit.debtorId
        let debtor = viewModel.queryUser(withUid: uid)
        return debtor
    }
    
}

struct CreditCardView_Previews: PreviewProvider {
    static var previews: some View {
        CreditCardView(credit: previewCredit)
            .environmentObject(UserViewModel())
    }
}
