//
//  ChangePictureView.swift
//  Saturday
//
//  Created by Titus Lowe on 27/7/22.
//

import SwiftUI
import Kingfisher

struct ChangePictureView: View {
    
    @EnvironmentObject var viewModel: UserViewModel
    
    @Binding var isShowingChangePictureView: Bool
    
    @State var isShowingImagePicker: Bool = false
    
    @State var selectedImage: UIImage?
    
    @State var profileImage: Image?
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [Color.systemIndigo, Color.background]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
                .blur(radius: 50)
            
            ZStack(alignment: .topTrailing) {
                
                RoundedRectangle(cornerRadius: 50)
                    .foregroundColor(Color.background)
                    .frame(width: 320, height: 140)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                
                Button {
                    withAnimation(.spring()) {
                        guard let selectedImage = selectedImage else { return }

                        viewModel.updateProfileImage(selectedImage)
                        viewModel.refresh()
                        isShowingChangePictureView = false
                    }
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 20))
                        .foregroundColor(Color.text)
                }
                .padding(.top, 24)
                .padding(.trailing, 24)
                
            }
            
            ZStack {
                
                if let user = viewModel.currentUser {
                    if let selectedImage = selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFill()
                            .clipped()
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.background, lineWidth: 2))
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                            .offset(y: -70)
                    } else {
                        KFImage(URL(string: user.profileImageUrl))
                            .resizable()
                            .scaledToFill()
                            .clipped()
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.background, lineWidth: 2))
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                            .offset(y: -70)
                    }
                        
                }
                
                Button {
                   isShowingImagePicker = true
                } label: {
                    Text("Change Picture")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 8)
                        .background(Color.systemBlue)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
                }
                .padding(.top, 50)
                .fullScreenCover(isPresented: $isShowingImagePicker) {
                    ImagePicker(selectedImage: $selectedImage)
                }
                
            }
            
        }
        
    }
    
    func updateImage() {
        print("Checking selectedImage...")
        guard let selectedImage = selectedImage else { return }
        
        print("uploading Profile image...")
        withAnimation(.spring()) {
            viewModel.updateProfileImage(selectedImage)
            viewModel.refresh()
        }
    }
    
}

struct ChangePictureView_Previews: PreviewProvider {
    static var previews: some View {
        ChangePictureView(isShowingChangePictureView: .constant(true))
            .environmentObject(UserViewModel())
    }
}
