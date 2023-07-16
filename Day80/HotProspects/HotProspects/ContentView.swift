//
//  ContentView.swift
//  HotProspects
//
//  Created by Shaun Hevey on 16/7/2023.
//

import SwiftUI

//@MainActor class DelayedUpdater: ObservableObject {
//    var value = 0 {
//        willSet {
//            objectWillChange.send()
//        }
//    }
//
//    init() {
//        for i in 1...10 {
//            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
//                self.value += 1
//            }
//        }
//    }
//}

struct ContentView: View {
    //@StateObject var updater = DelayedUpdater()
    @State private var output = ""

        var body: some View {
//            Text(output)
//                .task {
//                    await fetchReadings()
//                }
            Image("example")
                .interpolation(.none)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: .infinity)
                .background(.black)
                .ignoresSafeArea()
        }

        func fetchReadings() async {
            let fetchTask = Task { () -> String in
                let url = URL(string: "https://hws.dev/readings.json")!
                let (data, _) = try await URLSession.shared.data(from: url)
                let readings = try JSONDecoder().decode([Double].self, from: data)
                return "Found \(readings.count) readings"
            }
            
            let result = await fetchTask.result
            
            switch result {
                case .success(let str):
                    output = str
                case .failure(let error):
                    output = "Error: \(error.localizedDescription)"
            }
        }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
