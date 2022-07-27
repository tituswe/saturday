//
//  AddItemView.swift
//  Saturday
//
//  Created by Titus Lowe on 28/7/22.
//

import SwiftUI

struct AddItemView: View {
    
    @EnvironmentObject var cartManager: CartManager
    
    @Binding var isShowingAddItemView: Bool
    
    @State var quantity = ""
    
    @State var name = ""
    
    @State var price = ""
    
    @FocusState var isFocused: Bool
    
    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.systemGreen, Color.background]), startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
                .blur(radius: 50)
            
            ZStack(alignment: .topTrailing) {
                
                RoundedRectangle(cornerRadius: 50)
                    .foregroundColor(Color.background)
                    .frame(width: 320, height: 320)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                
                Button {
                    withAnimation(.spring()) {
                        isShowingAddItemView = false
                    }
                } label: {
                    Image(systemName: "xmark")
                        .font(.system(size: 20))
                        .foregroundColor(Color.text)
                }
                .padding(.top, 24)
                .padding(.trailing, 24)
             
            }
            
            VStack {
                Text("Add an Item")
                    .font(.title3)
                
                TextField("Quantity", text: $quantity)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 16))
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .frame(width: 200, height: 48)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(50)
                    .padding(4)
                    .focused($isFocused)
                
                TextField("Item name", text: $name)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 16))
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .frame(width: 200, height: 48)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(50)
                    .padding(4)
                    .focused($isFocused)
                
                TextField("Item price", text: $price)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 16))
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .frame(width: 200, height: 48)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(50)
                    .padding(4)
                    .focused($isFocused)
                
                ZStack (alignment: .topTrailing) {
                    Button {
                        if canConfirm() {
                            addItemToSplit()
                        }
                    } label: {
                        Text("Add")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(width: 120, height: 48)
                            .background(canConfirm() ? Color.systemBlue : Color.gray)
                            .cornerRadius(50)
                            .padding(4)
                            .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
                    }
                    
                    if cartManager.payableItems.count > 0 {
                        ZStack {
                            Circle()
                                .frame(width: 20, height: 20)
                                .foregroundColor(Color.background)
                            
                            Text("\(cartManager.payableItems.count)")
                                .font(.caption).bold()
                                .foregroundColor(Color.systemBlue)
                        }
                        .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
                    }
                }
            }
            
            if isFocused {
                Color.white.opacity(0.001)
                    .onTapGesture {
                        isFocused = false
                    }
            }
        }
        
    }
    
    func addItemToSplit() {
        guard let qty = Int(quantity) else { return }
        
        for _ in 0..<qty {
            let item = Item(id: UUID().uuidString, name: name, price: Double(price)!/Double(qty))
            cartManager.addItemToPayableItems(item: item)
        }
        
        quantity = ""
        name = ""
        price = ""
    }
    
    func canConfirm() -> Bool {
        guard Int(quantity) != nil else { return false }
        guard Double(price) != nil else { return false }
        return quantity != "" && name != "" && price != ""
    }
}

struct AddItemView_Previews: PreviewProvider {
    static var previews: some View {
        AddItemView(isShowingAddItemView: .constant(true))
            .environmentObject(CartManager())
    }
}
