//
//  DebtCard.swift
//  Saturday
//
//  Created by Titus Lowe on 5/7/22.
//

import SwiftUI

struct DebtCard: View {
    
//    let debt: Debt
    
    var body: some View {
        
        HStack {
            
            VStack {
                
                Text(Date.now, format: .dateTime.day().month().year())
                    .font(.system(.footnote, design: .rounded))
                    .foregroundColor(.gray)
                
                Spacer()
                    .frame(height: 2)
                
                Text("You Owe Josh")
                    .font(.system(.body, design: .rounded))
                    .fontWeight(.semibold)
                
            }
            .padding(.leading, 25)
            
            Spacer()
            
            VStack {
                
                Text("$12.50")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.semibold)
                
                HStack {
                    
                    Image("profilePicture")
                        .resizable()
                        .scaledToFill()
                        .clipped()
                        .frame(width: 32, height: 32)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.systemGreen, lineWidth: 3))
                    
                    Image("profilePicture")
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
    
}

struct DebtCard_Previews: PreviewProvider {
    static var previews: some View {
        DebtCard()
    }
}
