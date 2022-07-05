////
////  UserCard.swift
////  Saturday2
////
////  Created by Titus Lowe on 28/6/22.
////
//
//import SwiftUI
//
//struct UserCard: View {
//
//    @EnvironmentObject var databaseManager: DatabaseManager
//
//    @EnvironmentObject var cartManager: CartManager
//
//    let user: User
//
//    @State var isShowingOptions: Bool = false
//    
//    @State var isShowingCartView: Bool = false
//
//    var body: some View {
//
//        ZStack(alignment: .topTrailing) {
//
//            ZStack(alignment: .topLeading) {
//
//                VStack(alignment: .leading) {
//
//                    HStack {
//
//                        Spacer()
//
//                        Text(user.name)
//                            .font(.system(.body, design: .rounded))
//                            .fontWeight(.bold)
//                            .padding()
//
//                    }
//
//                    Spacer()
//
//                    Text("Total")
//                        .foregroundColor(user.isSelected ? .white : .black)
//                        .font(.system(.footnote, design: .rounded))
//                        .padding(.leading)
//
//                    HStack(alignment: .center) {
//
//                        Text("SGD")
//                            .foregroundColor(user.isSelected ? .white : .black)
//                            .font(.system(.footnote, design: .rounded))
//
//                        Text("$" + String(format: "%.2f", user.totalPayable))
//                            .foregroundColor(user.isSelected ? .white : .black)
//                            .font(.system(.footnote, design: .rounded))
//                            .fontWeight(.bold)
//
//                    }
//                    .padding(.horizontal)
//                    .padding(.bottom)
//
//                }
//                .frame(width: 125, height: 125)
//                .background(user.isSelected ? Color.systemBlue : Color.white)
//                .cornerRadius(20)
//                .padding(10)
//                .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
//
//                if (self.isShowingOptions) {
//                    Button {
//                        self.isShowingOptions = false
//                        cartManager.removeUser(user: user)
//                        databaseManager.addUser(user: user)
//                    } label: {
//                        Text("_") // MARK: LOL
//                            .font(.system(.title, design: .rounded))
//                            .bold()
//                            .padding(.bottom, 25)
//                            .foregroundColor(.white)
//                            .frame(width: 30, height: 30)
//                            .background(Color.systemRed)
//                            .cornerRadius(50)
//                    }
//                }
//
//            }
//
//            if (self.isShowingOptions) {
//                Button {
//                    self.isShowingCartView.toggle()
//                } label: {
//                    ZStack {
//                        Circle()
//                            .frame(width: 30, height: 30)
//                            .foregroundColor(Color.systemIndigo)
//                        Image(systemName: "eyeglasses")
//                            .resizable()
//                            .frame(width: 21, height: 9)
//                            .foregroundColor(.white)
//                    }
//                }
//            } else if (user.itemList.count > 0) {
//                Text("\(user.itemList.count)")
//                    .font(.caption).bold()
//                    .foregroundColor(.white)
//                    .frame(width: 30, height: 30)
//                    .background(Color.systemRed)
//                    .cornerRadius(50)
//            }
//
//        }
//        .onTapGesture {
//            cartManager.selectUser(user: user)
//            // TODO: Cancel showing options when tapping somewhere else
//        }
//        .onLongPressGesture {
//            self.isShowingOptions.toggle()
//        }
//        .sheet(isPresented: $isShowingCartView) {
//            CartView(user: user)
//                .environmentObject(cartManager)
//        }
//
//    }
//
//}
//
//struct UserCard_Previews: PreviewProvider {
//    static var previews: some View {
//        UserCard(user: previewUser)
//            .environmentObject(previewDatabaseManager)
//            .environmentObject(previewCartManager)
//    }
//}
