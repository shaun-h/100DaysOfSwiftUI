//
//  UserView.swift
//  FriendFace
//
//  Created by Shaun Hevey on 3/7/2023.
//

import SwiftUI

struct UserView: View {
    @State var user: CachedUser
    @State var users: FetchedResults<CachedUser>
    
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
                        Text(user.wrappedName)
                            .font(.title)
                            .fontWeight(.bold)
                        Image(systemName: "circle.fill")
                            .foregroundColor(user.isActive ? .green : .red)
                    }
                    Text(user.wrappedCompany)
                        .font(.subheadline)
                        .foregroundColor(Color(uiColor: .lightGray))
                    Text(user.wrappedAbout)
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
                        Text(user.wrappedEmail)
                    }
                    HStack {
                        Text("Address")
                            .fontWeight(.bold)
                        Spacer()
                        Text(user.wrappedAddress)
                    }
                } header: {
                    Text("Contact Details")
                }
                
                Section {
                    List {
                        ForEach(user.friendsArray) { friend in
                            HStack {
                                getFriendStatusView(friend: friend)
                                Text(friend.wrappedName)
                            }
                        }
                    }
                } header: {
                    Text("Friends")
                }
                
                Section {
                    List {
                        ForEach(user.wrappedTags, id: \.self) { tag in
                            Text(tag)
                        }
                    }
                } header: {
                    Text("Interests")
                }
            }
        }
    }

    func getFriendStatusView(friend: CachedFriend) -> some View {
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

//struct UserView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserView(user: CUser(id: UUID(), isActive: true, name: "Test Name", age: 23, company: "Test Company", email: "S@.x", address: "address", about: "This is me", registered: Date.now, tags: ["Tag1", "Tag2"], friends: [Friend(id: UUID(), name: "Test Friend Name")]), users: [])
//    }
//}
