//
//  ContentView.swift
//  Drawing
//
//  Created by Shaun Hevey on 1/7/2023.
//

import SwiftUI
import Foundation
struct Arrow: Shape {
    var thickness: Double = 1
    
    var animatableData: Double {
        get {
           thickness
        }

        set {
            thickness = newValue
        }
    }
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        let internalThickness = max(0, min(1, 2 - thickness))
        
        let heightInterval = rect.height / (3 / internalThickness)
        let widthInterval = rect.width / 4
        
        path.move(to: CGPoint(x: rect.minX, y: heightInterval))
        path.addLine(to: CGPoint(x: rect.minX + widthInterval * 2.5, y: heightInterval))
        path.addLine(to: CGPoint(x: rect.minX + widthInterval * 2.5, y: 0))
        path.addLine(to: CGPoint(x: rect.minX + widthInterval * 4, y: rect.maxY / 2))
        path.addLine(to: CGPoint(x: rect.minX + widthInterval * 2.5, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX + widthInterval * 2.5, y: rect.maxY - heightInterval))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY - heightInterval))
        path.closeSubpath()
        return path
    }
}


struct ColorCyclingRectangle: View {
    var amount = 0.0
    var startX = 0.0
    var startY = 0.0
    var endX = 1.0
    var endY = 1.0
    let steps = 100

    var body: some View {
        ZStack {
            ForEach(0..<steps) { value in
                Rectangle()
                    .inset(by: Double(value))
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [
                            color(for: Double(value), brightness: 1),
                            color(for: Double(value) + 0.5, brightness: 0.5)
                        ]),
                        startPoint: UnitPoint(x: startX, y: startY),
                        endPoint: UnitPoint(x: endX, y: endY)
                    ))
            }
        }
        .drawingGroup()
    }

    func color(for value: Double, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ContentView: View {
    @State private var thickness: Double = 1
    @State private var colorCycle = 0.0
    @State private var startX = 0.0
    @State private var startY = 0.0
    @State private var endX = 1.0
    @State private var endY = 1.0
    
    var body: some View {
        
        VStack(spacing: 0) {
            
        Spacer()
            Arrow(thickness: thickness)
                .fill(.red)
                .onTapGesture {
                    withAnimation {
                        thickness = Double.random(in: 1...2)
                    }
                }
                .frame(width: 150, height: 50)
            Spacer()
            Group{
                Text("Arrow thickness: \(thickness)")
                Slider(value: $thickness, in: 1...2, step: 0.01)
                    .padding([.horizontal, .bottom])
                
            }
            
            ColorCyclingRectangle(amount: colorCycle, startX: startX, startY: startY, endX: endX, endY: endY)
            Group{
                Text("Colour: \(colorCycle)")
                Slider(value: $colorCycle, in: 0...1, step: 0.01)
                    .padding([.horizontal, .bottom])
                Text("StartX: \(startX)")
                Slider(value: $startX, in: 0...1, step: 0.01)
                    .padding([.horizontal, .bottom])
                Text("StartY: \(startY)")
                Slider(value: $startY, in: 0...1, step: 0.01)
                    .padding([.horizontal, .bottom])
                Text("EndX: \(endX)")
                Slider(value: $endX, in: 0...1, step: 0.01)
                    .padding([.horizontal, .bottom])
                Text("EndY: \(endY)")
                Slider(value: $endY, in: 0...1, step: 0.01)
                    .padding([.horizontal, .bottom])
                
            }
                
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
