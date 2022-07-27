//
//  SplitRideView.swift
//  Saturday
//
//  Created by Titus Lowe on 27/7/22.
//

import SwiftUI

struct SplitRideView: View {
    
    @EnvironmentObject var cartManager: CartManager
    
    @Binding var isShowingSplitRideView: Bool
    
    @State var destination = ""
    
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
                    .frame(width: 320, height: 260)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 3)
                
                Button {
                    withAnimation(.spring()) {
                        isShowingSplitRideView = false
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
                Text("Split a Ride")
                    .font(.title3)
                
                TextField("Destination", text: $destination)
                    .multilineTextAlignment(.center)
                    .font(.system(size: 16))
                    .disableAutocorrection(true)
                    .autocapitalization(.none)
                    .frame(width: 200, height: 48)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(50)
                    .padding(4)
                    .focused($isFocused)
                
                TextField("Price", text: $price)
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
                
                Button {
                    if canConfirm() {
                        startRideSplit()
                        isShowingSplitRideView = false
                    }
                } label: {
                    Text("Confirm")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(width: 120, height: 48)
                        .background(canConfirm() ? Color.systemBlue : Color.gray)
                        .cornerRadius(50)
                        .padding(4)
                        .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
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
    
    func startRideSplit() {
        let rideItem = Item(id: UUID().uuidString, name: "RIDE: \(destination)", price: Double(price)!)
        
        var payableItems = [Item]()
        payableItems.append(rideItem)

        cartManager.updatePayableItems(items: payableItems)
    }
    
    func canConfirm() -> Bool {
        guard Double(price) != nil else { return false }
        
        return destination != "" && price != ""
    }
}

struct SplitRideView_Previews: PreviewProvider {
    static var previews: some View {
        SplitRideView(isShowingSplitRideView: .constant(true))
            .environmentObject(CartManager())
    }
}
