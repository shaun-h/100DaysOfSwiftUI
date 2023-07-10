//
//  ContentView.swift
//  BucketList
//
//  Created by Shaun Hevey on 11/7/2023.
//

import SwiftUI

extension FileManager {
    static func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        return paths[0]
    }
}

struct User: Identifiable, Comparable {
    let id = UUID()
    let firstName: String
    let lastName: String
    
    static func <(lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
}

enum LoadingState {
    case loading, success, failed
}

struct LoadingView: View {
    var body: some View {
        Text("Loading...")
    }
}

struct SuccessView: View {
    var body: some View {
        Text("Success!")
    }
}

struct FailedView: View {
    var body: some View {
        Text("Failed.")
    }
}

struct ContentView: View {
    let users = [
        User(firstName: "Arnold", lastName: "Rimmer"),
        User(firstName: "Kristine", lastName: "Kochanski"),
        User(firstName: "David", lastName: "Lister"),
    ].sorted()
    
    var loadingState = LoadingState.success

    var body: some View {
        if loadingState == .loading {
            LoadingView()
        } else if loadingState == .success {
            SuccessView()
        } else if loadingState == .failed {
            FailedView()
        }
//        VStack {
//            List(users) { user in
//                Text("\(user.lastName), \(user.firstName)")
//            }
//
//            Text("Hello World")
//                .onTapGesture {
//                    let str = "Test Message"
//                    let url = FileManager.documentsDirectory().appendingPathComponent("message.txt")
//
//                    do {
//                        try str.write(to: url, atomically: true, encoding: .utf8)
//                        let input = try String(contentsOf: url)
//                        print(input)
//                    } catch {
//                        print(error.localizedDescription)
//                    }
//                }
//        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
