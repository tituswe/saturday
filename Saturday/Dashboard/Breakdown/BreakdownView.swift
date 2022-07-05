////
////  BreakdownView.swift
////  Saturday2
////
////  Created by Titus Lowe on 30/6/22.
////
//
//import SwiftUI
//
//struct BreakdownView: View {
//    
//    @EnvironmentObject var databaseManager: DatabaseManager
//    
//    var isDebt: Bool
//    
//    var body: some View {
//        
//        VStack {
//            
//            // MARK: Navigation Bar
//            NavbarView(
//                topLeftButtonView: "line.horizontal.3",
//                topRightButtonView: "circle.dashed",
//                titleString: isDebt ? "You owe Josh" : "Josh owes You",
//                topLeftButtonAction: {},
//                topRightButtonAction: {})
//            
//            Spacer()
//            
//            
//        }
//        
//    }
//    
//}
//
//struct BreakdownView_Previews: PreviewProvider {
//    static var previews: some View {
//        BreakdownView(isDebt: true)
//            .environmentObject(previewDatabaseManager)
//    }
//}
