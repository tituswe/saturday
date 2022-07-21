//
//  UserRowView.swift
//  Saturday
//
//  Created by Titus Lowe on 6/7/22.
//

import SwiftUI
import Kingfisher

enum RequestState {
    
    case SEND
    case SENT
    case RECEIVE
    case FRIEND
    case PENDING
    
}

struct UserRowView: View {
    
    @EnvironmentObject var viewModel: UserViewModel

    let user: User
    
    @State var state: RequestState = .SEND
    
    @Binding var isEditingOffset: CGFloat
    
    var body: some View {
        
        ZStack() {
            
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.systemRed]), startPoint: .leading, endPoint: .trailing)
            
            HStack {
                Spacer()
                
                Button {
                    viewModel.removeFriend(friend: user)
                    viewModel.refresh()
                } label: {
                    Image(systemName: "person.badge.minus")
                        .resizable()
                        .frame(width: 24, height: 23)
                        .padding(.trailing, 17)
                        .padding(.top, 1)
                        .foregroundColor(Color.white)
                }

            }
            
            HStack(spacing: 12) {
                
                KFImage(URL(string: user.profileImageUrl))
                    .resizable()
                    .scaledToFill()
                    .clipShape(Circle())
                    .frame(width: 40, height: 40)
                    .offset(x: state == .FRIEND ? -isEditingOffset : 0)
                
                VStack(alignment: .leading, spacing: 2) {
                    
                    Text(user.name)
                        .font(.subheadline)
                    
                    Text("@\(user.username)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .offset(x: state == .FRIEND ? -isEditingOffset : 0)
                
                Spacer()
                
                if state == .SEND {
                    Button {
                        viewModel.sendFriendRequest(user: user)
                        state = .SENT
                    } label: {
                        Text("Add Friend")
                            .font(.system(.caption2, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 100, height: 30)
                            .background(Color.systemBlue)
                            .cornerRadius(50)
                            .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
                    }
                } else if state == .SENT {
                    Button {
                        viewModel.retractFriendRequest(user: user)
                        state = .SEND
                    } label: {
                        Text("Sent")
                            .font(.system(.caption2, design: .rounded))
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 100, height: 30)
                            .background(.gray)
                            .cornerRadius(50)
                            .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
                    }
                } else if state == .RECEIVE {
                    HStack {
                        Button {
                            viewModel.acceptFriendRequest(user: user)
                            state = .FRIEND
                        } label: {
                            Image(systemName: "checkmark")
                                .resizable()
                                .frame(width: 10, height: 10)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 25, height: 25)
                                .background(Color.systemGreen)
                                .cornerRadius(50)
                                .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
                        }
                        
                        Spacer()
                            .frame(width: 16)
                        
                        Button {
                            viewModel.declineFriendRequest(user: user)
                            state = .SEND
                        } label: {
                            Image(systemName: "xmark")
                                .resizable()
                                .frame(width: 10, height: 10)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 25, height: 25)
                                .background(Color.systemRed)
                                .cornerRadius(50)
                                .shadow(color: Color.black.opacity(0.4), radius: 5, x: 0, y: 3)
                        }
                    }
                    .padding(.horizontal, 8)
                } else if (state == .FRIEND) {
                    
                }
                
                

            }
            .padding(.vertical, 8)
            .padding(.horizontal, 24)
            .background(Color.background)
            .offset(x: state == .FRIEND ? isEditingOffset : 0)
            
        }
        .frame(height: 56)

    }
    
}

struct UserRowView_Previews: PreviewProvider {
    static var previews: some View {
        UserRowView(user: previewUser, state: .FRIEND, isEditingOffset: .constant(CGFloat(-56)))
            .environmentObject(UserViewModel())
    }
}
