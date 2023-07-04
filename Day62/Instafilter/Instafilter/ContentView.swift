//
//  ContentView.swift
//  Instafilter
//
//  Created by Shaun Hevey on 4/7/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showingConfirmation = false
    @State private var backgroundColor = Color.white
    //@State private var blurAmount = 0.0

    var body: some View {
//        VStack {
//            Text("Hello, World!")
//                .blur(radius: blurAmount)
//
//            Slider(value: $blurAmount, in: 0...20)
//                .onChange(of: blurAmount) { newValue in
//                        print("New value is \(newValue)")
//                    }
//
//            Button("Random Blur") {
//                blurAmount = Double.random(in: 0...20)
//            }
//        }
        Text("Hello, World!")
           .frame(width: 300, height: 300)
           .background(backgroundColor)
           .onTapGesture {
               showingConfirmation = true
           }
           .confirmationDialog("Change background", isPresented: $showingConfirmation) {
               Button("Red") { backgroundColor = .red }
               Button("Green") { backgroundColor = .green }
               Button("Blue") { backgroundColor = .blue }
               Button("Cancel", role: .cancel) { }
           } message: {
               Text("Select a new color")
           }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
