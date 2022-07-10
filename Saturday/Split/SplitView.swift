//
//  SplitView.swift
//  Saturday
//
//  Created by Titus Lowe on 6/7/22.
//

import SwiftUI

struct SplitView: View {
    
    @EnvironmentObject var viewModel: UserViewModel
    
    @StateObject var cartManager = CartManager()
    
    @Binding var isShowingSplitView: Bool
    
    @State var isShowingAddUserView: Bool = false
    
    @State var isShowingImagePicker: Bool = false
    
    @State var referenceReceipt: UIImage?
    
    @State var isShowingSentView: Bool = false
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                // MARK: Navigation Bar
                NavbarView(
                    topLeftButtonView: "arrow.backward",
                    topRightButtonView: "",
                    titleString: "Your Split",
                    topLeftButtonAction: {
                       isShowingSplitView = false
                    },
                    topRightButtonAction: {})

                Spacer()
                
                // MARK: User Cards
                if cartManager.payableUsers.isEmpty {
                    
                    HStack(alignment: .center) {

                        Button {
                            viewModel.refresh()
                            cartManager.updateAllUsers(allUsers: viewModel.friends, currentUser: viewModel.currentUser!)
                            self.isShowingAddUserView = true
                        } label: {
                            Text("Add friends")
                                .font(.system(.title3, design: .rounded))
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                                .frame(width: 160, height: 50)
                                .background(.white)
                                .cornerRadius(50)
                                
                        }
                        .overlay(Capsule()
                            .stroke(.gray,
                                    style: StrokeStyle(lineWidth: 5,
                                                       dash: [10])))
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                        
                    }
                    .frame(height: 120)
                    
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
                                            .foregroundColor(.white)
                                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)

                                        Image(systemName: "person.badge.plus")
                                            .resizable()
                                            .frame(width: 32, height: 32)
                                            .foregroundColor(.gray)
                                            .offset(x: -2, y: 1)
                                    }
                                    .overlay(Circle()
                                        .stroke(.gray,
                                                style: StrokeStyle(lineWidth: 5,
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
                    .frame(height: 120)
                
                }
                
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
                                    .font(.system(.title3, design: .rounded))
                                    .fontWeight(.bold)
                                    .foregroundColor(.gray)
                                    .frame(width: 280, height: 380)
                                    .background(.white)
                                    .cornerRadius(50)
                            }
                            .overlay(RoundedRectangle(cornerRadius: 50)
                                .stroke(.gray,
                                        style: StrokeStyle(lineWidth: 5,
                                                           dash: [10])))
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                            
                        } else {
                            
                            Text("No more items!")
                                .font(.system(.title3, design: .rounded))
                                .fontWeight(.bold)
                                .foregroundColor(.gray)
                                .frame(width: 280, height: 380)
                                .background(.white)
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
                .frame(height: 460)
                
                Spacer()
                
                // MARK: Bottom Bar
                ZStack {
                    
                    if cartManager.payableItems.isEmpty {
                        
                        if referenceReceipt != nil {
                            
                            Button {
                                cartManager.broadcastTransactions()
                                isShowingSentView = true
                            } label: {
                                ZStack {
                                    RoundedRectangle(cornerRadius: 50)
                                        .foregroundColor(Color.systemGreen)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        .shadow(color: Color.black.opacity(0.5), radius: 5, x: 0, y: -3)
                                    
                                    Text("Send split!")
                                        .font(.system(.title2, design: .rounded))
                                        .fontWeight(.bold)
                                        .foregroundColor(.white)
                                }
                            }
                            
                            NavigationLink(isActive: $isShowingSentView) {
                                SentView()
                                    .environmentObject(viewModel)
                                    .navigationBarHidden(true)
                            } label: {}
                            
                        }
                        
                    }
                    
                }
                .frame(maxWidth: .infinity, maxHeight: 80)
                .ignoresSafeArea()
                
            }
            .navigationBarHidden(true)
            .sheet(isPresented: $isShowingAddUserView) {
                AddUserView()
                    .environmentObject(viewModel)
                    .environmentObject(cartManager)
            }
            .sheet(isPresented: $isShowingImagePicker, onDismiss: extractItems) {
                ImagePicker(selectedImage: $referenceReceipt)
            }
            
        }
        
    }
    
    func extractItems() {
        guard let referenceReceipt = referenceReceipt else { return }
        
        let payableItems = TextExtractionModel(referenceReceipt: referenceReceipt).extractItems()
        
        cartManager.updatePayableItems(items: payableItems)
        print("DEBUG: Extracted items from receipt!")
    }
    
}

struct SplitView_Previews: PreviewProvider {
    static var previews: some View {
        SplitView(isShowingSplitView: .constant(true))
            .environmentObject(UserViewModel())
    }
}
