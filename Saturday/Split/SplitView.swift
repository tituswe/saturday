//
//  SplitView.swift
//  Saturday
//
//  Created by Joshua Tan on 30/6/22.
//

import SwiftUI

struct SplitView: View {
    
    @EnvironmentObject var databaseManager: DatabaseManager
    
    @StateObject var cartManager: CartManager
    
    @State var isShowingAddUserView: Bool = false
    
    @State var isShowingActionSheet: Bool = false
    
    @State var isShowingImagePicker: Bool = false
    
    @State var sourceType: UIImagePickerController.SourceType = .camera
    
    @State var image: UIImage?
    
    @State var isShowingConfirmView: Bool = false
    
    @State var isShowingSentView: Bool = false
    
    @State var hasAddedReceipt: Bool = false
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                // MARK: Navigation Bar
                NavbarView(
                    topLeftButtonView: "line.horizontal.3",
                    topRightButtonView: "circle.dashed",
                    titleString: "Your Split",
                    topLeftButtonAction: {},
                    topRightButtonAction: {})
                
                Spacer()
                
                // MARK: User Cards
                VStack {
                    
                    if (cartManager.userList.isEmpty) {
                        
                        HStack(alignment: .center) {
                            
                            Button {
                                self.isShowingAddUserView.toggle()
                            } label: {
                                Text("Add Users")
                                    .font(.system(.title3, design: .rounded))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.white)
                                    .frame(width: 200, height: 50)
                                    .background(Color.systemBlue)
                                    .cornerRadius(50)
                                    .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
                            }
                            
                        }
                        
                    } else {
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            
                            LazyHStack {
                                
                                Button {
                                    self.isShowingAddUserView.toggle()
                                } label: {
                                    Image(systemName: "plus")
                                        .padding(10)
                                        .foregroundColor(.white)
                                        .frame(width: 60, height: 125)
                                        .background(Color.gray)
                                        .cornerRadius(20)
                                        .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
                                }
                                
                                
                                ForEach(cartManager.userList, id: \.id) { user in
                                    
                                    UserCard(user: user)
                                        .environmentObject(databaseManager)
                                        .environmentObject(cartManager)
                                    
                                }
                                
                            }
                            .padding()
                            
                        }
                        
                    }
                    
                }
                .frame(height: 150, alignment: .center)
                
                Spacer()
                
                Divider()
                
                // MARK: Item Cards
                VStack {
                    
                    if (cartManager.itemList.isEmpty) { // TODO: Maybe if self.image != nil
                        
                        Spacer()
                        
                        Button("Add Receipt") {
                            self.isShowingActionSheet = true
                        }
                        .padding()
                        .font(.system(.title3, design: .rounded))
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50)
                        .background(Color.systemBlue)
                        .cornerRadius(50)
                        .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
                        .actionSheet(isPresented: $isShowingActionSheet) {
                            ActionSheet(title: Text("Select Photo"),
                                        message: Text("Choose"), buttons: [
                                            .default(Text("Photo Library")) {
                                                self.isShowingImagePicker = true
                                                self.sourceType = .photoLibrary
                                            },
                                            .default(Text("Camera")) {
                                                self.isShowingImagePicker = true
                                                self.sourceType = .camera
                                            },
                                            .cancel()
                                        ])
                        }
                        
                        Spacer()
                        
                    } else {
                        
                        ScrollView {
                            
                            LazyVStack {
                                
                                ForEach(cartManager.itemList, id: \.id) { item in
                                    
                                    ItemCard(item: item)
                                        .environmentObject(cartManager)
                                    
                                }
                                
                            }
                            .padding()
                            
                        }
                        
                    }
                    
                }
                .frame(height: 400)
                .sheet(isPresented: $isShowingImagePicker) {
                    ImagePicker(image: self.$image, isShown: self.$isShowingImagePicker, hasAddedReceipt: self.$hasAddedReceipt, sourceType: self.sourceType)
                        .environmentObject(cartManager)
                }
                
                Spacer()
                
                // MARK: Bottom Bar
                VStack {
                    
                    if (cartManager.itemList.isEmpty) {
                        
                        if (hasAddedReceipt && !cartManager.userList.isEmpty) {
                            
                            Button {
                                self.isShowingConfirmView = true
                            } label: {
                                Text("View Split")
                                    .font(.system(.title3, design: .rounded))
                                    .fontWeight(.bold)
                                    .foregroundColor(Color.white)
                                    .frame(width: 200, height: 50)
                                    .background(Color.systemBlue)
                                    .cornerRadius(50)
                                    .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
                            }
                            
                            NavigationLink(isActive: $isShowingSentView) {
                                SentView()
                                    .navigationBarHidden(true)
                            } label: {
                                Text("")
                            }
                            
                        }
                        
                    } else {
                        
                        let selectedUser = cartManager.selectedUser
                        
                        if selectedUser == nil {
                            Text("Select a Friend")
                                .font(.system(.title3, design: .rounded))
                                .fontWeight(.bold)
                                .foregroundColor(Color.black)
                                .frame(width: 200, height: 50)
                        } else {
                            Text("Adding to \(cartManager.selectedUser!.name)")
                                .font(.system(.title3, design: .rounded))
                                .fontWeight(.bold)
                                .frame(width: 200, height: 50)
                        }
                    }
                    
                }
                
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $isShowingAddUserView) {
                AddUserView()
                    .environmentObject(databaseManager)
                    .environmentObject(cartManager)
            }
            .sheet(isPresented: $isShowingConfirmView) {
                ConfirmView(isShowingConfirmView: $isShowingConfirmView, isShowingSentView: $isShowingSentView)
                    .environmentObject(cartManager)
            }
            
        }
        
    }
    
}

struct SplitView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SplitView(cartManager: CartManager())
                .environmentObject(previewDatabaseManager)
            SplitView(cartManager: previewCartManager)
                .environmentObject(previewDatabaseManager)
        }
    }
}
