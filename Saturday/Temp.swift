//
//  Temp.swift
//  Saturday
//
//  Created by Titus Lowe on 15/7/22.
//

import SwiftUI

struct Temp: View {
    
    @EnvironmentObject var viewModel: UserViewModel
    
    @StateObject var cartManager = CartManager()
    
    @Binding var isShowingSplitView: Bool
    
    @State var isShowingAddUserView: Bool = false
    
    @State var isShowingImagePicker: Bool = false
    
    @State var referenceReceipt: UIImage?
    
    @State var isShowingSentView: Bool = false
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [Color.systemGreen, Color.background]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack {
                
                // MARK: Navigation Bar
                NavBarView(
                    topLeftButtonView: "arrow.backward",
                    topRightButtonView: "",
                    titleString: "Split",
                    topLeftButtonAction: {
                        isShowingSplitView = false
                    },
                    topRightButtonAction: {})
                
                // MARK: Split
                VStack {
                    
                    VStack(spacing: 4) {
                        
                        HStack {
                            
                            Text("YOUR SPLIT")
                                .font(.system(size: 16))
                                .foregroundColor(Color.gray)
                                .padding(.horizontal, 24)
                            
                        }
                        
                        RoundedRectangle(cornerRadius: 25)
                            .frame(width: 72, height: 2.4)
                            .foregroundColor(Color.systemViolet)
                        
                    }
                    .padding(.vertical, 16)
                        
                    Divider()
                    
                    VStack {
                        
                        // MARK: User Cards
                        if cartManager.payableUsers.isEmpty {
                            
                            HStack(alignment: .center) {
                                
                                Button {
                                    viewModel.refresh()
                                    cartManager.updateAllUsers(allUsers: viewModel.friends, currentUser: viewModel.currentUser!)
                                    self.isShowingAddUserView = true
                                } label: {
                                    Text("Add friends")
                                        .font(.system(size: 16))
                                        .foregroundColor(.gray)
                                        .frame(width: 120, height: 40)
                                        .background(Color.background)
                                        .cornerRadius(50)
                                    
                                }
                                .overlay(Capsule()
                                    .stroke(Color(.lightGray),
                                            style: StrokeStyle(lineWidth: 3,
                                                               dash: [10])))
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                                
                            }
                            
                        } else {
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                
                                LazyHStack {
                                    
                                    Button {
                                        self.isShowingAddUserView = true
                                    } label: {
                                        VStack {
                                            ZStack {
                                                Circle()
                                                    .frame(width: 64, height: 64)
                                                    .foregroundColor(Color.background)
                                                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                                                
                                                Image(systemName: "person.badge.plus")
                                                    .resizable()
                                                    .frame(width: 32, height: 32)
                                                    .foregroundColor(.gray)
                                                    .offset(x: -2, y: 1)
                                            }
                                            .overlay(Circle()
                                                .stroke(Color(.lightGray),
                                                        style: StrokeStyle(lineWidth: 4,
                                                                           dash: [10])))
                                            
                                            Text(" ")
                                        }
                                    }
                                    .padding(.top)
                                    .padding(.horizontal)
                                    
                                    ForEach(cartManager.payableUsers, id: \.id) { user in
                                        UserCardView(user: user)
                                            .environmentObject(viewModel)
                                            .environmentObject(cartManager)
                                    }
                                    
                                }
                                
                            }
                            .padding(.horizontal)
                            
                        }
                        
                    }
                    .frame(height: 120)
                    
                    Divider()
                    
                    Spacer()
                    
                    // MARK: Item Cards
                    ZStack {
                        
                        if cartManager.payableItems.isEmpty {
                            
                            if referenceReceipt == nil {
                                
                                Button {
                                    isShowingImagePicker = true
                                } label: {
                                    Text("Upload a receipt")
                                        .font(.system(size: 16))
                                        .foregroundColor(.gray)
                                        .frame(width: 280, height: 320)
                                        .background(Color.background)
                                        .cornerRadius(50)
                                }
                                .overlay(RoundedRectangle(cornerRadius: 50)
                                    .stroke(Color(.lightGray),
                                            style: StrokeStyle(lineWidth: 3,
                                                               dash: [10])))
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                                
                            } else {
                                
                                Text("No more items!")
                                    .font(.system(size: 16))
                                    .foregroundColor(.gray)
                                    .frame(width: 280, height: 320)
                                    .background(Color.background)
                                    .cornerRadius(50)
                                
                            }
                            
                            
                        } else {
                            
                            ScrollView {
                                LazyVStack {
                                    ForEach(cartManager.payableItems, id: \.id) { item in
                                        // TODO: Make Item Cards
                                        ItemCardView(item: item)
                                            .environmentObject(viewModel)
                                            .environmentObject(cartManager)
                                        Divider()
                                    }
                                }
                            }
                            
                        }
                        
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.background)
                .cornerRadius(50, corners:[.topLeft, .topRight])
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: -3)
                .padding(.top, 8)
                .sheet(isPresented: $isShowingAddUserView) {
                    AddUserView()
                        .environmentObject(viewModel)
                        .environmentObject(cartManager)
                }
                .sheet(isPresented: $isShowingImagePicker, onDismiss: extractItems) {
                    ImagePicker(selectedImage: $referenceReceipt)
                }
                
                Spacer()
                    .frame(height: 2)
                
                // MARK: Bottom bar
                BottomBarView(viewState: .SPLIT)
                    .environmentObject(viewModel)
                
            }
            .ignoresSafeArea(.all, edges: [.bottom])
            
        }
        
    }
    
    func extractItems() {
        guard let referenceReceipt = referenceReceipt else { return }
        
        let payableItems = TextExtractionModel(referenceReceipt: referenceReceipt).extractItems()
        
        cartManager.updatePayableItems(items: payableItems)
        print("DEBUG: Extracted items from receipt!")
    }
    
}

struct Temp_Previews: PreviewProvider {
    static var previews: some View {
        Temp(isShowingSplitView: .constant(true))
            .environmentObject(UserViewModel())
    }
}
