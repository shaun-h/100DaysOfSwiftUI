//
//  ContentView.swift
//  FriendFace
//
//  Created by Shaun Hevey on 3/7/2023.
//

import SwiftUI

struct ContentView: View {
    @State var users: [User] = []
    var body: some View {
        NavigationView {
            List {
                ForEach(users) { user in
                    NavigationLink {
                        UserView(user: user, users: users)
                    } label: {
                        HStack {
                            /*@START_MENU_TOKEN@*/Text(user.name)/*@END_MENU_TOKEN@*/
                            Spacer()
                            Image(systemName: "circle.fill")
                                .foregroundColor(user.isActive ? .green : .red)
                        }
                    }
                }
            }
            .padding()
            .task {
                if users.count == 0 {
                    await getUsers()
                }
            }
            .listRowInsets(EdgeInsets())
            .background(Color(UIColor.systemGroupedBackground))
            .navigationTitle("Users")
        }
    }
    
    func getUsers() async{
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            users = try decoder.decode([User].self, from: data)
            users.sort { $0.isActive && !$1.isActive }
        } catch {
            //errorMessage = error.localizedDescription
            //showingError = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
