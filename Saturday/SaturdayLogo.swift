//
//  Saturday Logo.swift
//  Saturday
//
//  Created by Titus Lowe on 13/6/22.
//

import SwiftUI

struct SaturdayLogo: View {
    var body: some View {
        Image("SaturdayLogo")
            .resizable()
            .scaledToFit()
            .cornerRadius(50)
    }
}

struct SaturdayLogo_Previews: PreviewProvider {
    static var previews: some View {
        SaturdayLogo()
            .previewLayout(.sizeThatFits)
    }
}
