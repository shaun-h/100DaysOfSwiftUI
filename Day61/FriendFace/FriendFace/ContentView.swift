//
//  ContentView.swift
//  FriendFace
//
//  Created by Shaun Hevey on 3/7/2023.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: []) var users: FetchedResults<CachedUser>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(users) { user in
                    NavigationLink {
                        UserView(user: user, users: users)
                    } label: {
                        HStack {
                            Text(user.wrappedName)
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
            .refreshable {
                await getUsers()
            }
        }
    }
    
    func getUsers() async {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        do {
            
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            var newUsers = try decoder.decode([User].self, from: data)
            newUsers.sort { $0.isActive && !$1.isActive }
            
            
            newUsers.forEach { newUser in
                let u = CachedUser(context: moc)
                u.name = newUser.name
                u.id = newUser.id
                u.isActive = newUser.isActive
                u.age = Int16(newUser.age)
                u.company = newUser.company
                u.email = newUser.email
                u.address = newUser.address
                u.about = newUser.about
                u.registered = newUser.registered
                u.tags = newUser.tags.joined(separator: ",")
                
                var fs: [CachedFriend] = []
                
                newUser.friends.forEach { f in
                    let nf = CachedFriend(context: moc)
                    nf.id = f.id
                    nf.name = f.name
                    
                    fs.append(nf)
                }
            
                u.friends = NSSet(array: fs)
                
                if moc.hasChanges {
                    try? moc.save()
                }
            }
        }
        
        catch {
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
