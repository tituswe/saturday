//
//  SentView.swift
//  Saturday
//
//  Created by Titus Lowe on 7/7/22.
//

import SwiftUI

struct SentView: View {
    
    @EnvironmentObject var viewModel: UserViewModel
    
    @State var isShowingHomeView: Bool = false
    
    var body: some View {
        
        NavigationView {
            
            Button {
                viewModel.refresh()
                isShowingHomeView = true
            } label: {
                ZStack {
                    
                    LinearGradient(gradient: Gradient(colors: [Color.white, Color.systemGreen]), startPoint: .topTrailing, endPoint: .bottomLeading)
                        .ignoresSafeArea()
                    
                    VStack {
                        
                        Text("Done!")
                            .font(.system(.largeTitle, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .overlay(
                                Circle()
                                    .stroke(.white,
                                            style: StrokeStyle(lineWidth: 6, dash: [10]))
                                    .frame(width: 160, height: 160)
                            )
                        
                        Text("Tap back to dashboard")
                            .font(.system(.title2, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .offset(x: 0, y: 240)
                        
                        NavigationLink(isActive: $isShowingHomeView) {
                            ContentView()
                                .environmentObject(viewModel)
                                .navigationBarHidden(true)
                        } label: {}
                        
                    }
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarHidden(true)
            
        }
    }
}

struct SentView_Previews: PreviewProvider {
    static var previews: some View {
        SentView()
            .environmentObject(UserViewModel())
    }
}
