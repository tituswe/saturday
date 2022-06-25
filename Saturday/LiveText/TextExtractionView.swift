//
//  TextExtractionTest.swift
//  Saturday
//
//  Created by Joshua Tan on 23/6/22.
//

import SwiftUI

struct TextExtractionView: View {
    @State var showingResultsWindow = false
    @State var showingUploadWindow = false
    
    var body: some View {
        Button("Upload Receipt") {
            showingResultsWindow = true
        }
        .sheet(isPresented: $showingResultsWindow, content: {
            SplitView()
        })
    }
}

struct TextExtractionTest_Previews: PreviewProvider {
    static var previews: some View {
        TextExtractionView()
    }
}
