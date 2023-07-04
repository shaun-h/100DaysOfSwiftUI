//
//  User.swift
//  FriendFace
//
//  Created by Shaun Hevey on 3/7/2023.
//

import Foundation
struct Friend: Codable, Identifiable {
    var id: UUID
    var name: String
}

struct User: Codable, Identifiable {
    var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [Friend]
}
