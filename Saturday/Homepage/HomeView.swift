//
//  HomeView.swift
//  Saturday
//
//  Created by Joshua Tan on 21/6/22.
//

import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject var user: UserLoginModel
    
    @State private var showSheet: Bool = false
    @State private var showImagePicker: Bool = false
    @State private var sourceType: UIImagePickerController.SourceType = .camera
    @State private var image: UIImage?
    @State private var isShowingSplitView: Bool = false
    
    var body: some View {
        VStack {
            // MARK: Navigation Bar
            NavbarView(topLeftButtonView: "line.horizontal.3", topRightButtonView: "circle.dashed", titleString: "Dashboard", topLeftButtonAction: {}, topRightButtonAction: {}) // TODO: Add toolbar functionality
            
            Spacer()
            
            ScrollView {
                Text("I Owe You")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .frame(width: 350, height: 150)
                    .background(Color.systemBlue)
                    .cornerRadius(50)
                    .padding(10)
                    .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
                Text("I Owe You")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .frame(width: 350, height: 150)
                    .background(Color.systemBlue)
                    .cornerRadius(50)
                    .padding(10)
                    .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
                Text("I Owe You")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .frame(width: 350, height: 150)
                    .background(Color.systemBlue)
                    .cornerRadius(50)
                    .padding(10)
                    .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
                Text("I Owe You")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .frame(width: 350, height: 150)
                    .background(Color.systemBlue)
                    .cornerRadius(50)
                    .padding(10)
                    .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
            }
            
            Spacer()
            
            NavigationLink(isActive: $isShowingSplitView) {
                if image != nil {
                    SplitView(cartManager:
                                CartManager(
                                    model: TextExtractionModel(
                                        referenceReceipt: self.image!),
                                    friends: friendList))
                }
            } label: {
                Text("")
            }
            
            Button("Add Split") {
                self.showSheet = true
            }
            .padding()
            .font(.system(.title3, design: .rounded))
            .foregroundColor(Color.white)
            .frame(width: 200, height: 50)
            .background(Color.systemGreen)
            .cornerRadius(50)
            .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
            .actionSheet(isPresented: $showSheet) {
                ActionSheet(title: Text("Select Photo"),
                            message: Text("Choose"), buttons: [
                                .default(Text("Photo Library")) {
                                    self.showImagePicker = true
                                    self.sourceType = .photoLibrary
                                },
                                .default(Text("Camera")) {
                                    self.showImagePicker = true
                                    self.sourceType = .camera
                                },
                                .cancel()
                            ])
            }
            
            Spacer()
            
            Button(action: {
                user.signOut()
            }, label: {
                Text("Log Out")
                    .foregroundColor(Color.blue)
                    .font(.footnote)
            })
            
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: self.$image, isShown: self.$showImagePicker, isShowingSplitView: self.$isShowingSplitView, sourceType: self.sourceType)
        }
        
        
    }
}

//                // MARK: Friends at a glance
//                HStack {
//                    ScrollView(.horizontal, showsIndicators: false) {
//                        LazyHStack {
//                            ForEach(friends.indices) { i in
//                                VStack {
//                                }
//                            }
//                        }
//                    }
//                }

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(UserLoginModel())
    }
}
