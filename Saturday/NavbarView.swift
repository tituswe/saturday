//
//  NavbarView.swift
//  Saturday
//
//  Created by Team Saturday on 28/6/22.
//

import SwiftUI

/// Home Navigation view.
struct NavbarView: View {
    /// View of top left button.
    let topLeftButtonView: String
    /// View of top right button.
    let topRightButtonView: String
    /// Title.
    let titleString: String
    /// Top left button action function.
    var topLeftButtonAction: () -> ()
    /// Top right button action function.
    var topRightButtonAction: () -> ()
    
    /// Home Nav bar view.
    var body: some View {
        
        VStack (spacing: 20) {
            
            HStack {
                if topLeftButtonView != "" {
                    Button(action: topLeftButtonAction) {
                        Image(systemName: topLeftButtonView)
                            .font(.title2)
                    }
                } else {
                    Text("")
                        .font(.title2)
                }
                Spacer()
                if topRightButtonView != "" {
                    Button(action: topRightButtonAction) {
                        Image(systemName: topRightButtonView)
                            .font(.title2)
                    }
                } else {
                    Text("")
                        .font(.title2)
                }
            }
            .foregroundColor(Color.primary)
            .padding(.top)
            
            HStack {
                Text(titleString)
                    .font(.system(.title, design: .rounded))
                    .fontWeight(.bold)
                    .padding(.bottom)
                Spacer()
            }
            
        }
        .padding(.horizontal, 25)
        .frame(height: 100)
        
        Divider()
        
    }
    
}

struct TitleComponent_Previews: PreviewProvider {
    static var previews: some View {
        NavbarView(topLeftButtonView: "line.horizontal.3", topRightButtonView: "circle.dashed", titleString: "Your Bill", topLeftButtonAction: {}, topRightButtonAction: {})
    }
}
