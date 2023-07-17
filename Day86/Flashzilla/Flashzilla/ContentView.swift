//
//  ContentView.swift
//  Flashzilla
//
//  Created by Shaun Hevey on 17/7/2023.
//

import SwiftUI
import CoreHaptics

struct ContentView: View {
    var body: some View {
//        ZStack {
//            Rectangle()
//                .fill(.blue)
//                .frame(width: 300, height: 300)
//                .onTapGesture {
//                    print("Rectangle tapped!")
//                }
//
//            Circle()
//                .fill(.red)
//                .frame(width: 300, height: 300)
//                .contentShape(Rectangle())
//                .onTapGesture {
//                    print("Circle tapped!")
//                }
//
//        }
        VStack {
            Text("Hello")
            Spacer().frame(height: 100)
            Text("World")
        }
        .contentShape(Rectangle())
        .onTapGesture {
            print("VStack tapped!")
        }
    }
}
//    @State private var engine: CHHapticEngine?
//
//    var body: some View {
//        Text("Hello, World!")
//            .onAppear(perform: prepareHaptics)
//            .onTapGesture(perform: complexSuccess)
//    }
//
//    func prepareHaptics() {
//        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
//
//        do {
//            engine = try CHHapticEngine()
//            try engine?.start()
//        } catch {
//            print("There was an error creating the engine: \(error.localizedDescription)")
//        }
//    }
//
//    func complexSuccess() {
//        guard CHHapticEngine.capabilitiesForHardware().supportsHaptics else { return }
//        var events = [CHHapticEvent]()
//
//        for i in stride(from: 0, to: 1, by: 0.1) {
//            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(i))
//            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(i))
//            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: i)
//            events.append(event)
//        }
//
//        for i in stride(from: 0, to: 1, by: 0.1) {
//            let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: Float(1 - i))
//            let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: Float(1 - i))
//            let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 1 + i)
//            events.append(event)
//        }
//
//        let intensity = CHHapticEventParameter(parameterID: .hapticIntensity, value: 1)
//        let sharpness = CHHapticEventParameter(parameterID: .hapticSharpness, value: 1)
//        let event = CHHapticEvent(eventType: .hapticTransient, parameters: [intensity, sharpness], relativeTime: 0)
//        events.append(event)
//
//        do {
//            let pattern = try CHHapticPattern(events: events, parameters: [])
//            let player = try engine?.makePlayer(with: pattern)
//            try player?.start(atTime: 0)
//        } catch {
//            print("Failed to play pattern: \(error.localizedDescription).")
//        }
//    }
//
//
//    func simpleSuccess() {
//        let generator = UINotificationFeedbackGenerator()
//        generator.notificationOccurred(.success)
//    }
//
//}


//@State private var offset = CGSize.zero
//@State private var isDragging = false




//        let dragGesture = DragGesture()
//            .onChanged { value in offset = value.translation }
//            .onEnded { _ in
//                withAnimation {
//                    offset = .zero
//                    isDragging = false
//                }
//            }
//
//        let pressGesture = LongPressGesture()
//            .onEnded { value in
//                withAnimation {
//                    isDragging = true
//                }
//            }
//        let combined = pressGesture.sequenced(before: dragGesture)
//        Circle()
//            .fill(.red)
//            .frame(width: 64, height: 64)
//            .scaleEffect(isDragging ? 1.5 : 1)
//            .offset(offset)
//            .gesture(combined)
//    }
//    @State private var currentAmount = Angle.zero
//    @State private var finalAmount = Angle.zero
//    var body: some View {
//            VStack {
//                Text("Hello, World!")
//                    .onTapGesture {
//                        print("Text tapped")
//                    }
//            }
//            .simultaneousGesture(
//                TapGesture()
//                    .onEnded { _ in
//                        print("VStack tapped")
//                    }
//            )
        
        
//        VStack {
//           Text("Hello, World!")
//               .onTapGesture {
//                   print("Text tapped")
//               }
//       }
//        .highPriorityGesture(
//           TapGesture()
//                           .onEnded { _ in
//                               print("VStack tapped")
//                           }
//                   )
//            Text("Hello, world!")
//            .rotationEffect(currentAmount + finalAmount)
//                .gesture(
//                    RotationGesture()
//                        .onChanged { angle in
//                            currentAmount = angle
//                        }
//                        .onEnded { angle in
//                            finalAmount += currentAmount
//                            currentAmount = .zero
//                        }
//                )
//                .onTapGesture(count: 2) {
//                    print("Double tapped!")
//                }
//                .onLongPressGesture(minimumDuration: 1) {
//                    print("Long pressed!")
//                } onPressingChanged: { inProgress in
//                    print("In progress: \(inProgress)!")
//                }

//}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
