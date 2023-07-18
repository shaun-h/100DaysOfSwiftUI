//
//  ContentView.swift
//  LayoutAndGeometry
//
//  Created by Shaun Hevey on 17/7/2023.
//

import SwiftUI

struct ContentView: View {
    let colors: [Color] = [.red, .green, .blue, .orange, .pink, .purple, .yellow]

    var body: some View {
        GeometryReader { fullView in
            ScrollView(.vertical) {
                ForEach(0..<50) { index in
                    GeometryReader { geo in
                        HStack {
                            Spacer()
                            Text("Row #\(index)")
                                .font(.title)
                                .frame(maxWidth: .infinity)
                                .background(Color(hue: min(geo.frame(in: .global).maxY / fullView.size.height, 1.0), saturation: 1, brightness: 1))
                                .rotation3DEffect(.degrees(geo.frame(in: .global).minY - fullView.size.height / 2) / 5, axis: (x: 0, y: 1, z: 0))
                                .opacity(min(geo.frame(in: .global).minY, 200) / Double(200))
                                .scaleEffect(max(geo.frame(in: .global).maxY / fullView.size.height, 0.5))
                            Spacer()
                        }
                    }
                    .frame(height: 40)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

