//
//  TextExtractionTest.swift
//  Saturday
//
//  Created by Joshua Tan on 23/6/22.
//

import SwiftUI

struct TextExtractionView: View {
    @State var showingSplitView = false
    @State var showingUploadWindow = false
    @State var model: TextExtractionModel = TextExtractionModel()
    
    var body: some View {
        VStack {
            Button("Upload Receipt") {
                showingUploadWindow.toggle()
            }
            .sheet(isPresented: $showingUploadWindow, content: {
                
                // TODO: Show upload window
                // ContentView(temp: $showingUploadWindow, temp2: $showingSplitView, receipt: UPLOADED IMAGE)
                
                ContentView(temp: $showingUploadWindow, temp2: $showingSplitView, model: $model)
            })
            
            NavigationLink(destination: SplitView(cartManager: CartManager(items: model.extractItems(), friends: friendList))) {
                Text("Split it!")
            }
            .padding()
        }
        .navigationTitle("Upload Receipt")
    }
}

struct TextExtractionTest_Previews: PreviewProvider {
    static var previews: some View {
        TextExtractionView()
    }
}
