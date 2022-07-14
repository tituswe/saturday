//
//  CreditCardView.swift
//  Saturday
//
//  Created by Titus Lowe on 7/7/22.
//
//
//import SwiftUI
//import Kingfisher
//
//struct CreditCardView: View {
//
//    @EnvironmentObject var viewModel: UserViewModel
//
//    let credit: Credit
//
//    var body: some View {
//
//        HStack {
//
//            VStack {
//
//                Text(credit.date)
//                    .font(.system(.footnote, design: .rounded))
//                    .foregroundColor(.gray)
//
//                Spacer()
//                    .frame(height: 2)
//                Text("\(debtor().name.components(separatedBy: " ").first!) owes You")
//                    .font(.system(.body, design: .rounded))
//                    .fontWeight(.semibold)
//
//            }
//            .padding(.leading, 25)
//
//            Spacer()
//
//            VStack {
//
//                Text("$" + String(format: "%.2f", credit.total))
//                    .font(.system(.title3, design: .rounded))
//                    .fontWeight(.semibold)
//
//                HStack {
//
//                    KFImage(URL(string: viewModel.currentUser!.profileImageUrl))
//                        .resizable()
//                        .scaledToFill()
//                        .clipped()
//                        .frame(width: 32, height: 32)
//                        .clipShape(Circle())
//                        .overlay(Circle().stroke(Color.systemGreen, lineWidth: 3))
//
//                    KFImage(URL(string: debtor().profileImageUrl))
//                        .resizable()
//                        .scaledToFill()
//                        .clipped()
//                        .frame(width: 24, height: 24)
//                        .clipShape(Circle())
//                        .overlay(Circle().stroke(Color.systemRed, lineWidth: 2.25))
//
//                }
//
//            }
//            .padding(.trailing, 25)
//
//        }
//        .frame(width: 350, height: 150)
//        .background()
//        .cornerRadius(25)
//        .padding(10)
//        .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
//    }
//
//    func debtor() -> User {
//        let uid = credit.debtorId
//        let debtor = viewModel.queryUser(withUid: uid)
//        return debtor
//    }
//
//}
//
//struct CreditCardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CreditCardView(credit: previewCredit)
//            .environmentObject(UserViewModel())
//    }
//}

import SwiftUI
import Kingfisher

struct CreditCardView: View {
    
    @EnvironmentObject var viewModel: UserViewModel
    
    let credit: Credit
    
    @State var isShowingPeekCreditView: Bool = false
    
    @State var offset: CGFloat = 0
    
    @State var isSwiped: Bool = false
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.systemRed]), startPoint: .leading, endPoint: .trailing)
            
            HStack {
                
                Spacer()
                
                Button {
                    viewModel.cacheTransaction(credit: credit)
                    viewModel.refresh()
                } label: {
                    Image(systemName: "xmark")
                        .font(.title2)
                        .foregroundColor(.white)
                }
                .frame(width: 80, height: 120)
            }
            
            ZStack {
                
                RoundedRectangle(cornerRadius: 25)
                    .foregroundColor(Color.background)
                
                HStack {
                    
                    VStack {
                        
                        Text(credit.date)
                            .font(.system(.footnote, design: .rounded))
                            .foregroundColor(.gray)
                        
                        Spacer()
                            .frame(height: 2)
                        
                        Text("\(debtor().name.components(separatedBy: " ").first!) owes You")
                            .font(.system(.body, design: .rounded))
                            .fontWeight(.semibold)
                        
                    }
                    .padding(.leading, 25)
                    
                    Spacer()
                    
                    VStack {
                        
                        Text("$" + String(format: "%.2f", credit.total))
                            .font(.system(.title3, design: .rounded))
                            .fontWeight(.semibold)
                        
                        HStack {
                            
                            if let user = viewModel.currentUser {
                                
                                KFImage(URL(string: user.profileImageUrl))
                                    .resizable()
                                    .scaledToFill()
                                    .clipped()
                                    .frame(width: 32, height: 32)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.systemGreen, lineWidth: 3))
                                
                                KFImage(URL(string: debtor().profileImageUrl))
                                    .resizable()
                                    .scaledToFill()
                                    .clipped()
                                    .frame(width: 24, height: 24)
                                    .clipShape(Circle())
                                    .overlay(Circle().stroke(Color.systemRed, lineWidth: 2.25))
                                
                            }
                            
                        }
                        
                    }
                    .padding(.trailing, 25)
                    
                }
                
            }
            .frame(width: 350, height: 150)
            .offset(x: offset)
            .gesture(DragGesture().onChanged(onChanged(value:)).onEnded(onEnd(value:)))
            .onTapGesture {
                viewModel.refresh()
                isShowingPeekCreditView = true
            }
            .sheet(isPresented: $isShowingPeekCreditView) {
                PeekCreditView(credit: credit, isShowingPeekCreditView: $isShowingPeekCreditView)
                    .environmentObject(viewModel)
            }
            
        }
        .frame(width: 350, height: 150)
        .background()
        .cornerRadius(25)
        .padding(.top, 16)
        .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
        
    }
    
    func debtor() -> User {
        let uid = credit.debtorId
        let debtor = viewModel.queryUser(withUid: uid)
        return debtor
    }
    
    func resetOffset() {
        withAnimation(.easeIn) {
            offset = 0
        }
    }
    
    func onChanged(value: DragGesture.Value) {
        if value.translation.width < 0 {
            offset = value.translation.width
        }
    }
    
    func onEnd(value: DragGesture.Value) {
        withAnimation(.easeOut) {
            if value.translation.width < 0 {
                // Checking if ended
                if -value.translation.width > UIScreen.main.bounds.width / 2 {
                    offset = -1000
                    viewModel.cacheTransaction(credit: credit)
                    viewModel.refresh()
                } else if -offset > 50 {
                    // Updating is swiping
                    isSwiped = true
                    offset = -90
                } else {
                    isSwiped = false
                    offset = 0
                }
            } else {
                isSwiped = false
                offset = 0
            }
        }
    }
}

struct CreditCardView_Previews: PreviewProvider {
    static var previews: some View {
        CreditCardView(credit: previewCredit)
            .environmentObject(UserViewModel())
    }
}
