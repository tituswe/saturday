//
//  Saturday Logo.swift
//  Saturday
//
//  Created by Titus Lowe on 13/6/22.
//

import SwiftUI

struct SaturdayLogo: View {
    var body: some View {
        VStack {
            HStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .aspectRatio(1.0, contentMode: .fit)
                    .foregroundColor(Color.white)
                
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .aspectRatio(1.0, contentMode: .fit)
                    .foregroundColor(Color.systemRed)
                
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .aspectRatio(1.0, contentMode: .fit)
                    .foregroundColor(Color.systemOrange)
            }
            HStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .aspectRatio(1.0, contentMode: .fit)
                    .foregroundColor(Color.systemViolet)
                
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .aspectRatio(1.0, contentMode: .fit)
                    .foregroundColor(Color.black)
                
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .aspectRatio(1.0, contentMode: .fit)
                    .foregroundColor(Color.systemYellow)
            }
            HStack {
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .aspectRatio(1.0, contentMode: .fit)
                    .foregroundColor(Color.systemIndigo)
                
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .aspectRatio(1.0, contentMode: .fit)
                    .foregroundColor(Color.systemBlue)
                
                RoundedRectangle(cornerRadius: 20, style: .continuous)
                    .aspectRatio(1.0, contentMode: .fit)
                    .foregroundColor(Color.systemGreen)
            }
        }
    }
}

struct SaturdayLogo_Previews: PreviewProvider {
    static var previews: some View {
        SaturdayLogo()
            .previewLayout(.sizeThatFits)
    }
}
