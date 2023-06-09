//
//  ContentView.swift
//  Drawing
//
//  Created by Shaun Hevey on 1/7/2023.
//

import SwiftUI

struct Flower: Shape {
    var petalOffset: Double = -20
    var petalWidth: Double = 100
    
    func path(in rect: CGRect) -> Path {
            var path = Path()

            for number in stride(from: 0, to: Double.pi * 2, by: Double.pi / 8) {

                let rotation = CGAffineTransform(rotationAngle: number)

                let position = rotation.concatenating(CGAffineTransform(translationX: rect.width / 2, y: rect.height / 2))

                let originalPetal = Path(ellipseIn: CGRect(x: petalOffset, y: 0, width: petalWidth, height: rect.width / 2))

                let rotatedPetal = originalPetal.applying(position)

                path.addPath(rotatedPetal)
            }

            // now send the main path back
            return path
        }
    
}

struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 100

    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Circle()
                    .inset(by: Double(value))
                    .strokeBorder(LinearGradient(
                        gradient: Gradient(colors: [
                            color(for: value, brightness: 1),
                            color(for: value, brightness: 0.5)
                        ]),
                        startPoint: .top,
                        endPoint: .bottom
                    ),  lineWidth: 2)
            }
        }
        .drawingGroup()
    }

    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ContentView: View {
//    @State private var petalOffset = -20.0
//        @State private var petalWidth = 100.0
//
    @State private var colorCycle = 0.0
    var body: some View {
//        VStack {
//            Flower(petalOffset: petalOffset, petalWidth: petalWidth)
//                //.stroke(.red, lineWidth: 1)
//                .fill(.red, style: FillStyle(eoFill: true))
//
//            Text("Offset")
//            Slider(value: $petalOffset, in: -40...40)
//                .padding([.horizontal, .bottom])
//
//            Text("Width")
//            Slider(value: $petalWidth, in: 0...100)
//                .padding(.horizontal)
//        }
        
//        Text("Hello World")
//            .frame(width: 300, height: 300)
//            .border(ImagePaint(image: Image("Example"), sourceRect: CGRect(x: 0, y: 0.25, width: 1, height: 0.5), scale: 0.1), width: 30)
//
//        Capsule()
//            .strokeBorder(ImagePaint(image: Image("Example"), scale: 0.1), lineWidth: 20)
//            .frame(width: 300, height: 200)
        
        

            
        VStack {
            ColorCyclingCircle(amount: colorCycle)
                .frame(width: 300, height: 300)

            Slider(value: $colorCycle)
        }
            

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
