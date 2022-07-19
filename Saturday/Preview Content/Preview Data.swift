//
//  Datasets.swift
//  Saturday
//
//  Created by Joshua Tan on 11/6/22.
//

import Foundation

let previewUser = User(id: "DspU8DyzZYOuUh6OKAvegJjJfQq1",
                       name: "Titus Lowe",
                       username: "tituswe",
                       profileImageUrl: "https://firebasestorage.googleapis.com:443/v0/b/saturday-orbital2022.appspot.com/o/profile_image%2FB6E63BDB-AEC3-467C-A56E-C91CC571C6BA?alt=media&token=586e703d-d9f5-4a9a-990a-1cacee8c982d",
                       email: "tituswe@saturday.com",
                       deviceToken: "fBSwloiEl0b3rXOgQZNo2k:APA91bEKaR1tCJRoVl4Ug7aC9uStBY1aUaWtgE_gAEZ2cSIcuH1nrbV1mBKp29yORFMgy4bbWM4FzJOmohKvGvmMJ6BBBaoXbHB5F6_6WsVj3xinWFwkYkLZD1VUPbOLVdkf0HJBt67k")

let previewItem = Item(name: "Chicken Fried Rice", price: 6.50)

let previewDebt = Debt(id: "5F9A5EB7-5484-4EA3-9EA7-6C116A9F9221",
                       transactionId: "380DA8B1-CCE3-4FBB-B1F6-743D35B09931",
                       date: "8 Jul 2022",
                       creditorId: "DspU8DyzZYOuUh6OKAvegJjJfQq1",
                       total: 38.7)

let previewCredit = Credit(id: "5F9A5EB7-5484-4EA3-9EA7-6C116A9F9221",
                           transactionId: "380DA8B1-CCE3-4FBB-B1F6-743D35B09931",
                           date: "8 Jul 2022",
                           debtorId: "DspU8DyzZYOuUh6OKAvegJjJfQq1",
                           total: 38.7)

let previewUsers = [previewUser, previewUser, previewUser, previewUser]

let previewItems = [previewItem, previewItem, previewItem, previewItem]

let previewArchive = Archive(id: "15950F8A-8C64-450B-8641-5E64D9B2D575",
                             transactionId: "15950F8A-8C64-450B-8641-5E64D9B2D575",
                             debtorId: "TDz4gwY81IZgqRme5tBP9R6BxAF3",
                             creditorId: nil,
                             dateIssued: "15:44 Sat, 9 Jul 2022",
                             dateSettled: "15:44 Sat, 9 Jul 2022",
                             total: 8,
                             status: "cancelled",
                             type: "credit")
