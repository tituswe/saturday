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
    
    @State var offset = CGFloat(-56)
    
    var body: some View {
        
        NavigationView {
            
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
                                
                                Button {
                                    cartManager.isMultiSplit = false
                                    cartManager.selectNone()
                                    withAnimation(.spring()) {
                                        offset = -56
                                    }
                                } label: {
                                    Text("SINGLE")
                                        .font(.system(size: 16))
                                        .foregroundColor(Color.gray)
                                        .padding(.horizontal, 24)
                                }
                               
                                Button {
                                    cartManager.isMultiSplit = true
                                    cartManager.selectNone()
                                    withAnimation(.spring()) {
                                        offset = 57
                                    }
                                } label: {
                                    Text("GROUP")
                                        .font(.system(size: 16))
                                        .foregroundColor(Color.gray)
                                        .padding(.horizontal, 24)
                                }
                            }
                            
                            RoundedRectangle(cornerRadius: 25)
                                .frame(width: 72, height: 2.4)
                                .foregroundColor(Color.systemViolet)
                                .offset(x: offset)
                            
                        }
                        .padding(.top, 16)
                        .padding(.bottom, 8)
                            
                        Divider()
                        
                        VStack {
                            
                            // MARK: User Cards
                            if cartManager.payableUsers.isEmpty {
                                
                                HStack(alignment: .center) {
                                    
                                    Button {
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
                                                        .frame(width: 48, height: 48)
                                                        .foregroundColor(Color.background)
                                                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                                                    
                                                    Image(systemName: "person.badge.plus")
                                                        .resizable()
                                                        .frame(width: 20, height: 20)
                                                        .foregroundColor(.gray)
                                                        .offset(x: -1.5, y: 1)
                                                }
                                                .overlay(Circle()
                                                    .stroke(Color(.lightGray),
                                                            style: StrokeStyle(lineWidth: 2,
                                                                               dash: [5])))
                                                
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
                                    ZStack {
                                        VStack {
                                            Spacer()
                                            
                                            TextField("Input Service Fees", text: $cartManager.serviceFees)
                                                .keyboardType(.decimalPad)
                                                .multilineTextAlignment(.center)
                                                .font(.system(size: 16))
                                                .disableAutocorrection(true)
                                                .autocapitalization(.none)
                                                .padding()
                                                .frame(width: 300, height: 40)
                                                .background(Color.black.opacity(0.05))
                                                .cornerRadius(50)
                                                .padding()
                                        }
                                        
                                        Text("No more items!")
                                            .font(.system(size: 16))
                                            .foregroundColor(.gray)
                                            .frame(width: 280, height: 320)
                                            .background(Color.background)
                                            .cornerRadius(50)
                                    }
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
                                        HStack {
                                            Spacer()
                                            
                                            TextField("Service Fees", text: $cartManager.serviceFees)
                                                .keyboardType(.decimalPad)
                                                .multilineTextAlignment(.center)
                                                .font(.system(size: 14))
                                                .disableAutocorrection(true)
                                                .autocapitalization(.none)
                                                .padding()
                                                .frame(width: 120, height: 40)
                                                .background(Color.black.opacity(0.05))
                                                .cornerRadius(50)
                                                .padding(.trailing, 10)
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
                    HStack {
                        
                        Button {
                            if splitDone() {
                                cartManager.broadcastTransactions()
                                isShowingSentView = true
                            }
                        } label: {
                            ZStack {
                                Circle()
                                    .foregroundColor(splitDone() ? Color.systemGreen.opacity(0.8) : Color.gray)
                                    .frame(width: 44, height: 44)
                                    .shadow(color: Color.black.opacity(0.6), radius: 5, x: 0, y: 3)
                                Image(systemName: "arrow.up")
                                    .font(.system(size: 24))
                                    .foregroundColor(Color.white)
                            }
                        }
                        
                        NavigationLink(isActive: $isShowingSentView) {
                            SentView()
                                .environmentObject(viewModel)
                                .navigationBarHidden(true)
                        } label: {}
                    }
                    .frame(maxWidth: .infinity, maxHeight: 88)
                    .background(Color.background)
                    
                }
                .ignoresSafeArea(.all, edges: [.bottom])
                .navigationBarHidden(true)
                
            }
            
        }
        
    }
    
    func extractItems() {
        guard let referenceReceipt = referenceReceipt else { return }
        
        let payableItems = TextExtractionModel(referenceReceipt: referenceReceipt).extractItems()
        
        cartManager.updatePayableItems(items: payableItems)
        print("DEBUG: Extracted items from receipt!")
    }
    
    func splitDone() -> Bool {
        return !cartManager.payableUsers.isEmpty && cartManager.payableItems.isEmpty && (cartManager.serviceFees != "")
    }
    
}

struct SplitView_Previews: PreviewProvider {
    static var previews: some View {
        SplitView(isShowingSplitView: .constant(true))
            .environmentObject(UserViewModel())
//            .environment(\.colorScheme, .dark)
    }
}
