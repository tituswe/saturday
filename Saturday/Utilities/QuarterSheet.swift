//
//  QuarterSheet.swift
//  Saturday
//
//  Created by Titus Lowe on 19/7/22.
//

import SwiftUI

struct QuarterSheet<Content: View>: View {
    
    let content: () -> Content
    var isShowing: Binding<Bool>
    
    init(isShowing: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) {
        self.isShowing = isShowing
        self.content = content
    }
    
    func calculateOffset() -> CGFloat {
        if isShowing.wrappedValue {
            return UIScreen.main.bounds.height - 200
        } else {
            return UIScreen.main.bounds.height
        }
    }
    
    var body: some View {
        content()
            .offset(y: calculateOffset())
            .animation(.spring(), value: 2)
            .ignoresSafeArea()
    }
}

struct QuarterSheet_Previews: PreviewProvider {
    static var previews: some View {
        QuarterSheet(isShowing: .constant(true)) {
            PaymentView(isShowingPaymentView: .constant(true), debt: previewDebt)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .continuous))
        }
    }
}
