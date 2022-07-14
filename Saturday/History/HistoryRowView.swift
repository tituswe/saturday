//
//  HistoryRowView.swift
//  Saturday
//
//  Created by Titus Lowe on 10/7/22.
//

import SwiftUI

struct HistoryRowView: View {
    
    @EnvironmentObject var viewModel: UserViewModel
    
    let archive: Archive
    
    var body: some View {
        
        HStack {
            
            VStack(alignment: .leading) {
                
                Text(label())
                    .font(.system(.body, design: .rounded))
                    .fontWeight(.semibold)
                    .foregroundColor(archive.status == "cancelled" ? .gray : .black)
                
                Spacer()
                    .frame(height: 1.6)
                
                Text(archive.dateSettled)
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.gray)
            }
            .padding(.leading, 8)
            
            Spacer()
            
            VStack(alignment: .trailing) {
                
                Text("$" + String(format: "%.2f", archive.total))
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(archive.status == "cancelled" ? .gray :
                                        archive.type == "credit" ? .systemGreen : .systemRed )
                
                Spacer()
                    .frame(height: 1.6)
                
                Text(archive.status.capitalizeFirstChar())
                    .font(.system(.subheadline, design: .rounded))
                    .foregroundColor(.gray)
            }
            
        }
        .padding(.horizontal, 24)
        .frame(height: 56)
        .background(Color.background)

    }
    
    func label() -> String {
        if archive.type == "debt" {
            let name = viewModel.queryUser(withUid: archive.creditorId!).name
            
            return "To: \(name)"
        } else if archive.type == "credit" {
            let name = viewModel.queryUser(withUid: archive.debtorId!).name
            
            return "From: \(name)"
        } else {
            return ""
        }
    }
    
}

struct HistoryRowView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryRowView(archive: previewArchive)
            .environmentObject(UserViewModel())
    }
}
