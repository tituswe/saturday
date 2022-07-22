//
//  ColorSelectorView.swift
//  Saturday
//
//  Created by Titus Lowe on 5/7/22.
//

import SwiftUI

struct ColorSelectorView: View {
    
    @EnvironmentObject var viewModel: UserViewModel
    
    @State var isShowingColorPicker: Bool = false
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [Color.systemViolet, Color.background]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            Circle()
                .scale(1.7)
                .foregroundColor(Color.background.opacity(0.15))
            
            Circle()
                .scale(1.35)
                .foregroundColor(Color.background)
            
            // MARK: Navigation Bar
            VStack {
                NavBarView(
                    topLeftButtonView: "",
                    topRightButtonView: "",
                    titleString: "",
                    topLeftButtonAction: {},
                    topRightButtonAction: {})
                
                Spacer()
            }
            
            VStack {
                
                Text("Add a profile picture")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
                    .frame(height: 20)
                
                
                Button {
                    isShowingColorPicker = true
                } label: {
                    ZStack {
                        Color.systemBlue.opacity(0.75)
                            .cornerRadius(50)
                            .frame(width: 100, height: 100)
                        
                        Image(systemName: "plus.circle")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(Color.background)
                            .scaledToFill()
                            .background(Color.systemBlue)
                            .cornerRadius(50)
                            .frame(width: 90, height: 90)
                    }
                }
                
            }
            .sheet(isPresented: $isShowingColorPicker) {
                ColorPickerView()
                    .environmentObject(viewModel)
            }
            
        }
        
    }
    
}


struct ColorSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ColorSelectorView()
            .environmentObject(UserViewModel())
            .environment(\.colorScheme, .dark)
    }
}
