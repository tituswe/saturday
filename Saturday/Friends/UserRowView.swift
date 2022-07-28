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
    case BLOCKED
    case BLOCKEDBY
    
}

struct UserRowView: View {
    
    @EnvironmentObject var viewModel: UserViewModel

    let user: User
    
    @State var state: RequestState = .SEND
    
    @Binding var isEditingOffset: CGFloat
    
    @State var isShowingBlockAlert: Bool = false
    
    @State private var mailData = ComposeMailData(subject: "User Report",
                                                  recipients: ["teamsaturdaydevs@gmail.com"],
                                                  message: "Reason For Report: ",
                                                  attachments: nil)
    
    @State private var isShowingMailView = false
            
    var body: some View {
        
        ZStack() {
            
            LinearGradient(gradient: Gradient(colors: [Color.white, Color.systemRed]), startPoint: .leading, endPoint: .trailing)
            
            HStack {
                Spacer()
                
                if state == .BLOCKED {
                    Button {
                        withAnimation(.spring()) {
                            viewModel.unblockUser(user: user)
                            viewModel.refresh()
                        }
                    } label: {
                        Image(systemName: "circle")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding(.top, 1)
                            .foregroundColor(Color.white)
                    }
                    .frame(width: 56, height: 56)
                } else {
                    Button {
                        withAnimation(.spring()) {
                            isShowingBlockAlert = true
                            viewModel.refresh()
                        }
                    } label: {
                        Image(systemName: "circle.slash")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .padding(.top, 1)
                            .foregroundColor(Color.white)
                    }
                    .frame(width: 56, height: 56)
                    .alert("Are you sure you want to block \(user.name)?", isPresented: $isShowingBlockAlert) {
                        Button("Yes") {
                            viewModel.blockUser(user: user)
                            viewModel.refresh()
                        }
                        Button("No", role: .cancel) {}
                    }
                }
                
                Divider()
                
                Button {
                    // TODO: Flag User
                    mailData = ComposeMailData(subject: "Report on User: \(user.name)",
                                               recipients: ["teamsaturdaydevs@gmail.com"],
                                               message: "UserID: \(user.id!) \n Reason for report: ",
                                               attachments: nil)
                    isShowingMailView.toggle()
                } label: {
                    Image(systemName: "flag")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(.top, 1)
                        .foregroundColor(Color.white)
                }
                .frame(width: 48, height: 56)
                .disabled(!MailView.canSendMail)
                .sheet(isPresented: $isShowingMailView) {
                    MailView(data: $mailData) { result in
                        print(result)
                    }
                }
                
                Divider()
                
                Button {
                    withAnimation(.spring()) {
                        viewModel.removeFriend(friend: user)
                        viewModel.refresh()
                    }
                } label: {
                    Image(systemName: "person.badge.minus")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .padding(.trailing, 8)
                        .padding(.top, 1)
                        .foregroundColor(Color.white)
                }
                .frame(width: 56, height: 56)

            }
            
            HStack(spacing: 12) {
                
                if state == .BLOCKED {
                    Circle()
                        .frame(width: 40, height: 40)
                        .foregroundColor(Color.gray)
                        .offset(x: state == .FRIEND ? -isEditingOffset : 0)
                } else {
                    KFImage(URL(string: user.profileImageUrl))
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 40, height: 40)
                        .offset(x: state == .FRIEND ? -isEditingOffset : 0)
                }
                
                VStack(alignment: .leading, spacing: 2) {
                    
                    Text(user.name)
                        .font(.subheadline)
                        .foregroundColor(state == .BLOCKED ? Color.gray : Color.text)
                    
                    Text("@\(user.username)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .offset(x: state == .FRIEND ? -isEditingOffset : 0)
                
                Spacer()
                
                switch state {
                case .SEND:
                    Button {
                        withAnimation(.spring()) {
                            viewModel.sendFriendRequest(user: user)
                            state = .SENT
                        }
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
                case .SENT:
                        Button {
                            withAnimation(.spring()) {
                                viewModel.retractFriendRequest(user: user)
                                state = .SEND
                            }
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
                case .RECEIVE:
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
                case .FRIEND:
                    Text("")
                case .PENDING:
                    Text("")
                case .BLOCKED:
                    Text("")
                case .BLOCKEDBY:
                    Text("")
                }

            }
            .padding(.vertical, 8)
            .padding(.horizontal, 24)
            .background(Color.background)
            .offset(x: isEditingOffset)
            
        }
        .frame(height: 56)

    }
    
}

struct UserRowView_Previews: PreviewProvider {
    static var previews: some View {
        UserRowView(user: previewUser, state: .FRIEND, isEditingOffset: .constant(CGFloat(-196)))
            .environmentObject(UserViewModel())
    }
}
