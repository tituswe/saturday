//
//  ColorPickerView.swift
//  Saturday
//
//  Created by Titus Lowe on 22/7/22.
//

import SwiftUI

struct ColorPickerView: View {
    
    @EnvironmentObject var viewModel: UserViewModel
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    viewModel.selectColor(color: 0)
                } label: {
                    Avatar(avatarColor: 0)
                }
                .padding()
                
                Button {
                    viewModel.selectColor(color: 1)
                } label: {
                    Avatar(avatarColor: 1)
                }
                .padding()

                Button {
                    viewModel.selectColor(color: 2)
                } label: {
                    Avatar(avatarColor: 2)
                }
                .padding()

            }
            
            HStack {
                Button {
                    viewModel.selectColor(color: 3)
                } label: {
                    Avatar(avatarColor: 3)
                }
                .padding()

                Button {
                    viewModel.selectColor(color: 4)
                } label: {
                    Avatar(avatarColor: 4)
                }
                .padding()

                Button {
                    viewModel.selectColor(color: 5)
                } label: {
                    Avatar(avatarColor: 5)
                }
                .padding()

            }
        }
        .background(Color.background)
        .padding()

    }
}

struct ColorPickerView_Previews: PreviewProvider {
    static var previews: some View {
        ColorPickerView()
            .environmentObject(UserViewModel())
    }
}
