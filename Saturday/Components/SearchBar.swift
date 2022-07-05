//
//  SearchBar.swift
//  Saturday
//
//  Created by Titus Lowe on 6/7/22.
//

import SwiftUI

struct SearchBar: View {
    
    @Binding var text: String
    
    var body: some View {
        
        HStack {
            
            TextField("Search...", text: $text)
                .font(.system(.body, design: .rounded))
                .padding(8)
                .padding(.horizontal, 36)
                .background(Color(.systemGray6))
                .cornerRadius(50)
                .overlay(
                    HStack {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 16)
                    })
        }
        .padding(.horizontal, 4)
    }
    
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(text: .constant(""))
    }
}
