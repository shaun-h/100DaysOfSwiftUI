//
//  ContentView.swift
//  Flashzilla
//
//  Created by Shaun Hevey on 17/7/2023.
//

import SwiftUI

func withOptionalAnimation<Result>(_ animation: Animation? = .default, _ body: () throws -> Result) rethrows -> Result {
    if UIAccessibility.isReduceMotionEnabled {
        return try body()
    } else {
        return try withAnimation(animation, body)
    }
}

struct ContentView: View {
//    @Environment(\.accessibilityDifferentiateWithoutColor) var differentiateWithoutColor
//    @Environment(\.accessibilityReduceMotion) var reduceMotion
//    @State private var scale = 1.0
    @Environment(\.accessibilityReduceTransparency) var reduceTransparency

    
//    let timer = Timer.publish(every: 1, tolerance: 0.5, on: .main, in: .common).autoconnect()
//    @State private var counter = 0
    //@Environment(\.scenePhase) var scenePhase

    var body: some View {
        Text("Hello, World!")
            .padding()
            .background(reduceTransparency ? .black : .black.opacity(0.5))
            .foregroundColor(.white)
            .clipShape(Capsule())
//        Text("Hello, World!")
//            .scaleEffect(scale)
//            .onTapGesture {
//                withOptionalAnimation {
//                    scale *= 1.5
//                }
//            }
//        HStack {
//           if differentiateWithoutColor {
//               Image(systemName: "checkmark.circle")
//           }
//
//           Text("Success")
//       }
//       .padding()
//       .background(differentiateWithoutColor ? .black : .green)
//       .foregroundColor(.white)
//       .clipShape(Capsule())
//        VStack {
//            Text("Hello, world!")
//                .padding()
//                .onChange(of: scenePhase) { newPhase in
//                    if newPhase == .active {
//                        print("Active")
//                    } else if newPhase == .inactive {
//                        print("Inactive")
//                    } else if newPhase == .background {
//                        print("Background")
//                    }
//                }
//            Text("Hello, World!")
//                .onReceive(timer) { time in
//                    if counter == 5 {
//                        timer.upstream.connect().cancel()
//                    } else {
//                        print("The time is now \(time)")
//                    }
//
//                    counter += 1
//                }
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
