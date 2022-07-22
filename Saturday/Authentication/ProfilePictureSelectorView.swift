////
////  ProfilePictureSelectorView.swift
////  Saturday
////
////  Created by Titus Lowe on 5/7/22.
////
//
//import SwiftUI
//
//struct ProfilePictureSelectorView: View {
//
//    @EnvironmentObject var viewModel: UserViewModel
//
//    @State var isShowingImagePicker: Bool = false
//
//    @State var selectedImage: UIImage?
//
//    @State var profileImage: Image?
//
//    var body: some View {
//
//        ZStack {
//
//            LinearGradient(gradient: Gradient(colors: [Color.systemViolet, Color.background]), startPoint: .topLeading, endPoint: .bottomTrailing)
//                .ignoresSafeArea()
//
//            Circle()
//                .scale(1.7)
//                .foregroundColor(Color.background.opacity(0.15))
//
//            Circle()
//                .scale(1.35)
//                .foregroundColor(Color.background)
//
//            // MARK: Navigation Bar
//            VStack {
//                NavBarView(
//                    topLeftButtonView: "",
//                    topRightButtonView: "",
//                    titleString: "",
//                    topLeftButtonAction: {},
//                    topRightButtonAction: {})
//
//                Spacer()
//            }
//
//            VStack {
//
//                Text("Add a profile picture")
//                    .font(.largeTitle)
//                    .fontWeight(.bold)
//
//                Spacer()
//                    .frame(height: 20)
//
//                Button {
//                    isShowingImagePicker = true
//                } label: {
//                    if let profileImage = profileImage {
//                        profileImage
//                            .resizable()
//                            .scaledToFill()
//                            .cornerRadius(50)
//                            .frame(width: 100, height: 100)
//                            .clipShape(Circle())
//                    } else {
//                        ZStack {
//
//                            Color.systemBlue.opacity(0.75)
//                                .cornerRadius(50)
//                                .frame(width: 100, height: 100)
//
//                            Image(systemName: "plus.circle")
//                                .resizable()
//                                .renderingMode(.template)
//                                .foregroundColor(Color.background)
//                                .scaledToFill()
//                                .background(Color.systemBlue)
//                                .cornerRadius(50)
//                                .frame(width: 90, height: 90)
//
//                        }
//                    }
//                }
//                .fullScreenCover(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
//                    ImagePicker(selectedImage: $selectedImage)
//                }
//
//                if let selectedImage = selectedImage {
//                    Button {
//                        withAnimation(.spring()) {
//                            viewModel.uploadProfileImage(selectedImage)
//                        }
//                    } label: {
//                        Text("Continue")
//                            .fontWeight(.semibold)
//                            .foregroundColor(.white)
//                            .frame(width: 100, height: 50)
//                            .background(Color.systemBlue)
//                            .cornerRadius(50)
//                            .padding(.top, 15)
//                    }
//                } else {
//                    Button {
//                        withAnimation(.spring()) {
//                            viewModel.uploadProfileImage(UIImage(systemName: "person.circle")!)
//                        }
//                    } label: {
//                        Text("Skip")
//                            .fontWeight(.semibold)
//                            .foregroundColor(.white)
//                            .frame(width: 100, height: 50)
//                            .background(Color.systemBlue)
//                            .cornerRadius(50)
//                            .padding(.top, 15)
//                    }
//
//                }
//
//            }
//
//        }
//
//    }
//
//    func loadImage() {
//        guard let selectedImage = selectedImage else { return }
//        profileImage = Image(uiImage: selectedImage)
//    }
//
//}
//
//
//struct ProfilePictureSelectorView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfilePictureSelectorView()
//            .environmentObject(UserViewModel())
//            .environment(\.colorScheme, .dark)
//    }
//}
