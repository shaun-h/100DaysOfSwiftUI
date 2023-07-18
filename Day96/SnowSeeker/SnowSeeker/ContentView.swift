//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Shaun Hevey on 18/7/2023.
//

import SwiftUI

struct User: Identifiable {
    var id = "Taylor Swift"
}

struct UserView: View {
    var body: some View {
        Group {
            Text("Name: Paul")
            Text("Country: England")
            Text("Pets: Luna and Arya")
        }
        .font(.title)
    }
}

struct ContentView: View {
    @State private var searchText = ""
    let allNames = ["Subh", "Vina", "Melvin", "Stefanie"]

    var body: some View {
        NavigationView {
            List(filteredNames, id: \.self) { name in
                Text(name)
            }
            .searchable(text: $searchText, prompt: "Look for something")
            .navigationTitle("Searching")
        }
    }

    var filteredNames: [String] {
        if searchText.isEmpty {
            return allNames
        } else {
            return allNames.filter { $0.contains(searchText) }
        }
    }
//    @State private var selectedUser: User? = nil
//    @State private var isShowingUser = false
        
//        @Environment(\.horizontalSizeClass) var sizeClass
//
//        var body: some View {
//            if sizeClass == .compact {
//                VStack {
//                    UserView()
//                }
//            } else {
//                HStack {
//                    UserView()
//                }
//            }
        
        
        //        Text("Hello, World!")
//            .onTapGesture {
//                selectedUser = User()
//                isShowingUser = true
//            }
//            .alert("Welcome", isPresented: $isShowingUser, presenting: selectedUser) { user in
//                Button(user.id) { }
//            }
//            .sheet(isPresented: $isShowingUser) {
//                Text(selectedUser?.id ?? "Unknown")
//            }
//    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
