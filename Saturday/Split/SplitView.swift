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
    
    @State var isShowingAddItemView: Bool = false
    
    @State var isShowingImagePicker: Bool = false
    
    @State var referenceReceipt: UIImage?
    
    @State var isShowingSplitRideView: Bool = false
    
    @State var isShowingSentView: Bool = false
    
    @State var offset = CGFloat(-(UIScreen.main.bounds.width-64)/4)
    
    @FocusState var feesIsFocused: Bool
    
    let screenQuarter = (UIScreen.main.bounds.width-64)/4
    
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
                            
                            ZStack {
                                
                                Button {
                                    cartManager.isMultiSplit = false
                                    cartManager.selectNone()
                                    withAnimation(.spring()) {
                                        offset = -screenQuarter
                                    }
                                } label: {
                                    Text("SINGLE")
                                        .font(.system(size: 16))
                                        .foregroundColor(Color.gray)
                                }
                                .offset(x: -screenQuarter)
                                
                                Button {
                                    cartManager.isMultiSplit = true
                                    cartManager.selectNone()
                                    withAnimation(.spring()) {
                                        offset = screenQuarter
                                    }
                                } label: {
                                    Text("GROUP")
                                        .font(.system(size: 16))
                                        .foregroundColor(Color.gray)
                                }
                                .offset(x: screenQuarter)
                            }
                            
                            RoundedRectangle(cornerRadius: 25)
                                .frame(width: 80, height: 2.4)
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
                                        HStack {
                                            Image(systemName: "person.3")
                                                .font(.system(size: 16))
                                                .foregroundColor(.gray)
                                            
                                            Text("Add friends")
                                                .font(.system(size: 16))
                                                .foregroundColor(.gray)
                                        }
                                        .frame(width: 280, height: 80)
                                        .background(Color.background)
                                        .cornerRadius(20)
                                    }
                                    .overlay(RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color(.lightGray),
                                                style: StrokeStyle(lineWidth: 2,
                                                                   dash: [5])))
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
                                    
                                    VStack {
                                        
                                        // MARK: Split a meal
                                        Button {
                                            isShowingImagePicker = true
                                        } label: {
                                            HStack {
                                                Image(systemName: "fork.knife")
                                                    .font(.system(size: 16))
                                                    .foregroundColor(.gray)
                                                
                                                Text("Split a meal")
                                                    .font(.system(size: 16))
                                                    .foregroundColor(.gray)
                                            }
                                            .frame(width: 280, height: 80)
                                            .background(Color.background)
                                            .cornerRadius(20)
                                        }
                                        .overlay(RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color(.lightGray),
                                                    style: StrokeStyle(lineWidth: 2,
                                                                       dash: [5])))
                                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                                        .padding(8)
                                        
                                        // MARK: Split a ride
                                        Button {
                                            isShowingSplitRideView = true
                                        } label: {
                                            HStack {
                                                Image(systemName: "car.fill")
                                                    .font(.system(size: 16))
                                                    .foregroundColor(.gray)
                                                
                                                Text("Split a ride")
                                                    .font(.system(size: 16))
                                                    .foregroundColor(.gray)
                                            }
                                            .frame(width: 280, height: 80)
                                            .background(Color.background)
                                            .cornerRadius(20)
                                        }
                                        .overlay(RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color(.lightGray),
                                                    style: StrokeStyle(lineWidth: 2,
                                                                       dash: [5])))
                                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                                        .padding(8)
                                        
                                        // MARK: Manual Add
                                        Button {
                                            isShowingAddItemView = true
                                        } label: {
                                            HStack {
                                                Image(systemName: "pencil")
                                                    .font(.system(size: 16))
                                                    .foregroundColor(.gray)
                                                
                                                Text("Split manually")
                                                    .font(.system(size: 16))
                                                    .foregroundColor(.gray)
                                            }
                                            .frame(width: 280, height: 80)
                                            .background(Color.background)
                                            .cornerRadius(20)
                                        }
                                        .overlay(RoundedRectangle(cornerRadius: 20)
                                            .stroke(Color(.lightGray),
                                                    style: StrokeStyle(lineWidth: 2,
                                                                       dash: [5])))
                                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                                        .padding(8)
                                        
                                        Text("Select your type of split")
                                            .font(.system(size: 14))
                                            .foregroundColor(Color.systemGreen)
                                            .frame(width: 280, height: 60)
                                            .background(Color.background)
                                            .cornerRadius(20)
                                            .padding(8)
                                        
                                    }
                                    
                                } else {
                                    ZStack(alignment: .bottomTrailing) {
                                        
                                        ZStack {
                                            
                                            VStack {
                                                
                                                TextField("Service fees", text: $cartManager.serviceFees)
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
                                                    .focused($feesIsFocused)
                                                
                                                Spacer()
                                            }
                                            
                                            Text("No items!")
                                                .font(.system(size: 16))
                                                .foregroundColor(.gray)
                                                .frame(maxWidth: .infinity, maxHeight: 200)
                                                .background(Color.background)
                                                .cornerRadius(50)
                                        }
                                        
                                        Button {
                                            isShowingAddItemView = true
                                        } label: {
                                            VStack {
                                                ZStack {
                                                    Circle()
                                                        .frame(width: 64, height: 64)
                                                        .foregroundColor(Color.background)
                                                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                                                    
                                                    Image(systemName: "pencil")
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
                                    }
                                }
                                
                            } else {
                                
                                ZStack(alignment: .bottomTrailing) {
                                    ScrollView {
                                        
                                        TextField("Service fees", text: $cartManager.serviceFees)
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
                                            .focused($feesIsFocused)
                                        
                                        LazyVStack {
                                            ForEach(cartManager.payableItems, id: \.id) { item in
                                                ItemCardView(item: item)
                                                    .environmentObject(viewModel)
                                                    .environmentObject(cartManager)
                                                Divider()
                                            }
                                        }
                                        
                                    }
                                    
                                    Button {
                                        isShowingAddItemView = true
                                    } label: {
                                        VStack {
                                            ZStack {
                                                Circle()
                                                    .frame(width: 64, height: 64)
                                                    .foregroundColor(Color.background)
                                                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                                                
                                                Image(systemName: "pencil")
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
                    .fullScreenCover(isPresented: $isShowingImagePicker, onDismiss: extractItems) {
                        ImagePicker(selectedImage: $referenceReceipt)
                    }
                    .fullScreenCover(isPresented: $isShowingSplitRideView, onDismiss: configureSplitRide) {
                        SplitRideView(isShowingSplitRideView: $isShowingSplitRideView)
                            .environmentObject(viewModel)
                            .environmentObject(cartManager)
                    }
                    .fullScreenCover(isPresented: $isShowingAddItemView, onDismiss: configureManualSplit) {
                        AddItemView(isShowingAddItemView: $isShowingAddItemView)
                            .environmentObject(cartManager)
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
                        .padding(.bottom, 16)
                        
                        NavigationLink(isActive: $isShowingSentView) {
                            SentView()
                                .environmentObject(viewModel)
                                .navigationBarHidden(true)
                        } label: {}
                    }
                    .frame(maxWidth: .infinity, maxHeight: 96)
                    .background(Color.background)
                    
                }
                .ignoresSafeArea(.all, edges: [.bottom])
                .navigationBarHidden(true)
                
                if feesIsFocused {
                    Color.white.opacity(0.001)
                        .onTapGesture {
                            feesIsFocused = false
                        }
                }
            }
            
        }
        
    }
    
    func extractItems() {
        guard let referenceReceipt = referenceReceipt else { return }
        
        let payableItems = TextExtractionModel(referenceReceipt: referenceReceipt).extractItems()
        
        cartManager.updatePayableItems(items: payableItems)
    }
    
    func splitDone() -> Bool {
        return !cartManager.payableUsers.isEmpty && cartManager.payableItems.isEmpty && (cartManager.serviceFees != "")
    }
    
    func configureSplitRide() {
        if !cartManager.payableItems.isEmpty {
            referenceReceipt = UIImage(systemName: "circle")
            cartManager.isMultiSplit = true
            cartManager.selectNone()
            cartManager.selectAll()
            cartManager.serviceFees = "0.00"
            withAnimation(.spring()) {
                offset = screenQuarter
            }
        }
    }
    
    func configureManualSplit() {
        if !cartManager.payableItems.isEmpty {
            referenceReceipt = UIImage(systemName: "circle")
        }
    }
}

struct SplitView_Previews: PreviewProvider {
    static var previews: some View {
        SplitView(isShowingSplitView: .constant(true))
            .environmentObject(UserViewModel())
        //            .environment(\.colorScheme, .dark)
    }
}
