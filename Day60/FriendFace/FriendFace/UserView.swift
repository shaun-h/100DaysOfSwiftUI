//
//  UserView.swift
//  FriendFace
//
//  Created by Shaun Hevey on 3/7/2023.
//

import SwiftUI

struct UserView: View {
    @State var user: User
    @State var users: [User]
    
    var body: some View {
        VStack(spacing: 10) {
            Form {
                VStack {
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(height: 150)
                        .fontWeight(.light)
                        .foregroundColor(.gray)
                    HStack {
                        Text(user.name)
                            .font(.title)
                            .fontWeight(.bold)
                        Image(systemName: "circle.fill")
                            .foregroundColor(user.isActive ? .green : .red)
                    }
                    Text(user.company)
                        .font(.subheadline)
                        .foregroundColor(Color(uiColor: .lightGray))
                    Text(user.about)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                    
                }
                .listRowInsets(EdgeInsets())
                .background(Color(UIColor.systemGroupedBackground))
                
                Section {
                    HStack {
                        Text("Age")
                            .fontWeight(.bold)
                        Spacer()
                        Text("\(user.age)")
                    }
                } header: {
                    Text("Personal Details")
                }
                
                Section {
                    HStack {
                        Text("Email")
                            .fontWeight(.bold)
                        Spacer()
                        Text(user.email)
                    }
                    HStack {
                        Text("Address")
                            .fontWeight(.bold)
                        Spacer()
                        Text(user.address)
                    }
                } header: {
                    Text("Contact Details")
                }
                
                Section {
                    List {
                        ForEach(user.friends) { friend in
                            HStack {
                                getFriendStatusView(friend: friend)
                                Text(friend.name)
                            }
                        }
                    }
                } header: {
                    Text("Friends")
                }
                
                Section {
                    List {
                        ForEach(user.tags, id: \.self) { tag in
                            Text(tag)
                        }
                    }
                } header: {
                    Text("Interests")
                }
            }
        }
    }
    
    func getFriendStatusView(friend: Friend) -> some View {
        let optionalUser = users.first {
            $0.id == friend.id
        }
        
        guard let u = optionalUser else {
            return Image(systemName: "circle.fill")
                .foregroundColor(.gray)
        }
        
        return Image(systemName: "circle.fill")
            .foregroundColor(u.isActive ? .green : .red)
    }
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        UserView(user: User(id: UUID(), isActive: true, name: "Test Name", age: 23, company: "Test Company", email: "S@.x", address: "address", about: "This is me", registered: Date.now, tags: ["Tag1", "Tag2"], friends: [Friend(id: UUID(), name: "Test Friend Name")]), users: [])
    }
}
