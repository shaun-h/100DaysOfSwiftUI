//
//  ContentView.swift
//  iExpense
//
//  Created by Shaun Hevey on 24/6/2023.
//

import SwiftUI

//class User : ObservableObject {
//    @Published var firstName = "Bilbo"
//    @Published var lastName = "Baggins"
//}
//
//struct SecondView: View {
//    @Environment(\.dismiss) var dismiss
//
//    let name: String
//
//    var body: some View {
//        Text("Hello, \(name)!")
//        Button("Dismiss") {
//            dismiss()
//        }
//    }
//}

struct User : Codable {
    let firstName: String
    let lastName: String
}

struct ContentView: View {
    //@StateObject var user = User()
    //@State private var showingSheet = false
//    @State private var numbers = [Int]()
//    @State private var currentNumber = 1
//    @State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")
//    @AppStorage("tapCount") private var tapCount = 0
    @State private var user = User(firstName: "Taylor", lastName: "Swift")

    var body: some View {
        Button("Save User") {
            let encoder = JSONEncoder()

            if let data = try? encoder.encode(user) {
                UserDefaults.standard.set(data, forKey: "UserData")
            }
        }
//        Button("Tap count: \(tapCount)") {
//            tapCount += 1
//            UserDefaults.standard.set(self.tapCount, forKey: "Tap")

//        }
//        Button("Show Sheet") {
//            showingSheet.toggle()
//        }
//        .sheet(isPresented: $showingSheet) {
//            SecondView(name: "Shaun")
//        }
//        NavigationView {
//            VStack {
//                List {
//                    ForEach(numbers, id: \.self) {
//                        Text("Row \($0)")
//                    }
//                    .onDelete(perform: removeRows)
//                }
//
//                Button("Add Number") {
//                    numbers.append(currentNumber)
//                    currentNumber += 1
//                }
//            }
//            .navigationTitle("OnDelete()")
//            .toolbar {
//                EditButton()
//            }
//        }
    
    }
//
//    func removeRows(at offsets: IndexSet) {
//        numbers.remove(atOffsets: offsets)
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
