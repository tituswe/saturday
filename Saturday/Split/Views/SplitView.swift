//
//  CartSplitView.swift
//  Saturday
//
//  Created by Joshua Tan on 11/6/22.
//

import SwiftUI

struct SplitView: View {
    
    @StateObject var cartManager: CartManager
    
    @EnvironmentObject var user: UserLoginModel
    
    @State var selectedCart: Int = -1
    
    @State var isOpen: [Bool] = [Bool](repeating: false, count: friendList.count)
    
    @State var isSelected: [Bool] = [Bool](repeating: false, count: friendList.count)
    
    @State var isShowingConfirmView: Bool = false
    
    var body: some View {
        VStack {
            // MARK: Navigation Bar
            NavbarView(topLeftButtonView: "line.horizontal.3", topRightButtonView: "circle.dashed", titleString: "Your Bill", topLeftButtonAction: {}, topRightButtonAction: {}) // TODO: Add toolbar functionality
            Spacer()
            
            // MARK: Friend Cards
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(cartManager.friends.indices) { i in
                        VStack {
                            ZStack {
                                NavigationLink("", destination: CartView(cartNumber: i)
                                    .environmentObject(cartManager), isActive: $isOpen[i])
                                
                                FriendCard(name: cartManager.friends[i], cartNumber: i, numberOfProducts: cartManager.carts[i].items.count, isSelected: $isSelected[i])
                                    .environmentObject(cartManager)
                                    .onTapGesture {
                                        isOpen[i].toggle()
                                    }
                                    .onLongPressGesture(minimumDuration: 0.2) {
                                        withAnimation(.easeIn(duration: 0.2)) {
                                            selectedCart = i
                                            resetSelected()
                                            isSelected[i] = true
                                        }
                                    }
                            }
                        }
                    }
                }
                .padding()
            }
            .frame(height: 150, alignment: .center)
            Spacer()
            Divider()
            
            // MARK: Item Cards
            if (cartManager.items.isEmpty) {
                VStack {
                    Spacer()
                    Text("No items")
                        .font(.system(.subheadline, design: .rounded))
                        .foregroundColor(Color.gray)
                    Spacer()
                }
                .frame(height: 400)
            } else {
                ScrollView {
                    LazyVStack {
                        ForEach(cartManager.items, id: \.id) { item in
                            ItemCard(item: item, selectedCart: selectedCart)
                                .environmentObject(cartManager)
                        }
                    }
                    .padding()
                }
                .frame(height: 400)
            }
            Spacer()
            
            // MARK: Bottom Panel
            if (allAllocated()) {
                ZStack {
                    NavigationLink(isActive: $isShowingConfirmView) {
                        ConfirmationView()
                            .environmentObject(cartManager)
                            .environmentObject(user)
                    } label: {
                        Text("")
                    }

                    Button {
                        isShowingConfirmView = true
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
                    
                }
            } else if (noneSelected()) {
                Text("Select a Friend")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundColor(Color.black)
                    .frame(width: 200, height: 50)
                
            } else {
                Text("Adding to \(cartManager.friends[selectedCart])")
                    .font(.system(.title3, design: .rounded))
                    .fontWeight(.bold)
                    .frame(width: 200, height: 50)
            }
        }
        .navigationBarHidden(true)
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    func resetSelected() {
        isSelected = [Bool](repeating: false, count: friendList.count)
    }
    
    func noneSelected() -> Bool {
        for b in isSelected {
            if b == true {
                return false
            }
        }
        return true
    }
    
    func allAllocated() -> Bool {
        return cartManager.items.isEmpty
    }
}


struct SplitView_Previews: PreviewProvider {
    static var previews: some View {
        SplitView(cartManager: CartManager(model: TextExtractionModel(referenceReceipt: UIImage(named: "receipt1")!), friends: friendList))
            .environmentObject(UserLoginModel())
    }
}
