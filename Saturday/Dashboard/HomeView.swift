//
//  HomeView.swift
//  Saturday2
//
//  Created by Titus Lowe on 28/6/22.
//

import SwiftUI

struct HomeView: View {
   
    @EnvironmentObject var user: UserLoginModel
    
    @StateObject var databaseManager: DatabaseManager
    
    @State var isShowingSplitView: Bool = false
    
    var body: some View {
        
        NavigationView {
            
            VStack {
                
                // MARK: Navigation Bar
                NavbarView(
                    topLeftButtonView: "line.horizontal.3",
                    topRightButtonView: "circle.dashed",
                    titleString: "Dashboard",
                    topLeftButtonAction: {
                        let debt = Debt(
                            creditor: kyteorite,
                            debtor: Joshua_TYH,
                            name: "Testing",
                            itemList: previewItemList,
                            totalPayable: 3.00)
                        
                        FirestoreManager().addDebt(debt: debt)
                        
                    },
                    topRightButtonAction: {
                        user.signOut()
                    })
                
                Spacer()
                
                ScrollView {
                    
                    Spacer()
                    
                    // MARK: Credits
                    // TODO: Credits Functionality
                    Text("Pending Credits")
                        .padding()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        LazyHStack {
                            
                            Text("Josh Owes You \n$13.76")
                                .font(.system(.title3, design: .rounded))
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .frame(width: 350, height: 150)
                                .background(Color.systemViolet)
                                .cornerRadius(50)
                                .padding(10)
                                .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
                            
                        }
                        .padding()
                        
                    }
                    
                    Spacer()
                    
                    // MARK: Debits
                    // TODO: Debits Functionality
                    Text("Pending Debts")
                        .padding()
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        
                        LazyHStack {
                            
                            Text("You Owe Yuze \n$10.42")
                                .font(.system(.title3, design: .rounded))
                                .fontWeight(.bold)
                                .foregroundColor(Color.white)
                                .frame(width: 350, height: 150)
                                .background(Color.systemIndigo)
                                .cornerRadius(50)
                                .padding(10)
                                .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
                            
                        }
                        .padding()
                        
                    }
                    
                }
                
                Spacer()
                
                // MARK: Bottom Bar
                Button("Add Split") {
                    self.isShowingSplitView.toggle()
                }
                .padding()
                .font(.system(.title3, design: .rounded))
                .foregroundColor(Color.white)
                .frame(width: 200, height: 50)
                .background(Color.systemBlue)
                .cornerRadius(50)
                .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
                
                NavigationLink(isActive: $isShowingSplitView) {
                    SplitView(cartManager: CartManager())
                        .environmentObject(previewDatabaseManager)
                        .navigationBarHidden(true)
                } label: {
                    Text("")
                }
                
            }
            .navigationBarHidden(true)
            
        }
        
    }
    
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(databaseManager: previewDatabaseManager)
            .environmentObject(UserLoginModel())
    }
}
