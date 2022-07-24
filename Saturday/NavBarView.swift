//
//  NavBarView.swift
//  Saturday
//
//  Created by Titus Lowe on 15/7/22.
//
import SwiftUI

struct NavBarView: View {
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
            
            VStack(spacing: 20) {
                
                HStack {
                    
                    if topLeftButtonView != "" {
                        Button(action: topLeftButtonAction) {
                            Image(systemName: topLeftButtonView)
                                .font(.title3)
                                .foregroundColor(Color.white)
                        }
                    } else {
                        Image(systemName: "circle")
                            .font(.title3)
                            .foregroundColor(Color.clear)
                    }
                    
                    Spacer()
                    
                    Text(titleString)
                        .font(.title3)
                        .foregroundColor(Color.white)
                    
                    Spacer()
                    
                    if topRightButtonView != "" {
                        Button(action: topRightButtonAction) {
                            Image(systemName: topRightButtonView)
                                .font(.title3)
                                .foregroundColor(Color.white)
                        }
                    } else {
                        Image(systemName: "circle")
                            .font(.title3)
                            .foregroundColor(Color.clear)
                    }
                    
                }
                .foregroundColor(Color.primary)
                .padding(.top)
                
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 8)
            
    }
    
}

//struct NavBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        NavBarView(topLeftButtonView: "line.horizontal.3", topRightButtonView: "circle.dashed", titleString: "Saturday", topLeftButtonAction: {}, topRightButtonAction: {})
//    }
//}
