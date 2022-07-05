////
////  CartView.swift
////  Saturday
////
////  Created by Joshua Tan on 30/6/22.
////
//
//import SwiftUI
//
//struct CartView: View {
//    
//    @EnvironmentObject var cartManager: CartManager
//    
//    let user: User
//    
//    @State var showNavigationBar: Bool = true
//    
//    var body: some View {
//        
//        VStack {
//            
//            if (self.showNavigationBar) {
//                
//                // MARK: Navigation Bar
//                NavbarView(
//                    topLeftButtonView: "line.horizontal.3",
//                    topRightButtonView: "circle.dashed",
//                    titleString: "\(user.name)'s Cart",
//                    topLeftButtonAction: {},
//                    topRightButtonAction: {})
//                
//            } else {
//                
//                Text(self.user.name)
//                    .font(.system(.title2, design: .rounded))
//                    .fontWeight(.bold)
//                
//            }
//            
//            // MARK: Item Rows
//            VStack {
//                
////                if (user.itemList.isEmpty) {
//                    
//                    VStack {
//                        
//                        Spacer()
//                        
//                        Text("No Items")
//                            .font(.system(.subheadline, design: .rounded))
//                            .foregroundColor(Color.gray)
//                        
//                        Spacer()
//                        
//                    }
//                    
//                } else {
//                    
//                    ScrollView {
//                        
//                        ForEach(user.itemList, id: \.id) { item in
//                            
//                            ItemRow(item: item)
//                            
//                        }
//                        
//                        HStack {
//                            
//                            Text("Total:")
//                                .font(.system(.body, design: .rounded))
//                            
//                            Spacer()
//                            
//                            Text("$" + String(format: "%.2f", user.totalPayable))
//                                .font(.system(.body, design: .rounded))
//                                .fontWeight(.bold)
//                            
//                        }
//                        .padding()
//                        
//                    }
//                    
//                }
//                
//            }
//            .padding(.top)
//            
//        }
//        .navigationBarHidden(true)
//        
//    }
//    
//}
//
//struct CartView_Previews: PreviewProvider {
//    static var previews: some View {
//        CartView(user: previewUser)
//            .environmentObject(previewCartManager)
//    }
//}
