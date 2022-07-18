//
//  HistoryCardView.swift
//  Saturday
//
//  Created by Titus Lowe on 15/7/22.
//

import SwiftUI
import Kingfisher

struct HistoryCardView: View {
    
    @EnvironmentObject var viewModel: UserViewModel
    
    let archive: Archive
    
    var body: some View {
        
        HStack {
            
            KFImage(URL(string: user().profileImageUrl))
                .resizable()
                .scaledToFill()
                .clipped()
                .frame(width: 64, height: 64)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color(.lightGray), lineWidth: 3))
            
            VStack(alignment: .leading) {
                
                Text(archive.dateSettled)
                    .font(.system(size: 9))
                    .foregroundColor(Color.gray)
                
                Text(label())
                    .foregroundColor(archive.status == "cancelled" ? Color.gray : Color.black)
                
                
            }
            .padding(.horizontal, 16)
            
            VStack(alignment: .trailing) {
            
                Text("$" + String(format: "%.2f", archive.total))
                    .font(.system(size: 20))
                    .foregroundColor(archive.status == "cancelled" ? .gray :
                                        archive.type == "credit" ? .systemGreen : .systemRed )
                
                Text(archive.status.capitalizeFirstChar())
                    .font(.system(size: 10))
                    .foregroundColor(Color.gray)
                
            }
            .frame(width: 80)
            
        }
        .frame(width: 320, height: 96)
        .background(Color.background)
        .cornerRadius(25)
        .shadow(color: Color.black.opacity(0), radius: 5, x: 0, y: 3)
        
    }
    
    func user() -> User {
        if let creditorId = archive.creditorId {
            return viewModel.queryUser(withUid: creditorId)
        } else if let debtorId = archive.debtorId {
            return viewModel.queryUser(withUid: debtorId)
        } else {
            return User(name: "", username: "", profileImageUrl: "", email: "")
        }
    }
    
    func userName() -> String {
        let name = user().name.components(separatedBy: " ").first!

        if name.count > 6 {
            return name.prefix(5) + "..."
        } else {
            return name
        }
    }
    
    func label() -> String {
        if archive.type == "debt" {
            return "To: \(userName())"
        } else if archive.type == "credit" {
            return "From: \(userName())"
        } else {
            return ""
        }
    }
    
}

struct HistoryCardView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryCardView(archive: previewArchive)
            .environmentObject(UserViewModel())
    }
}
