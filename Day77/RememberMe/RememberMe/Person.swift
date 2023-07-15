//
//  Person.swift
//  RememberMe
//
//  Created by Shaun Hevey on 15/7/2023.
//

import Foundation
import UIKit

struct Person: Identifiable, Codable, Comparable {
    var id: UUID
    var name: String
    
    static func < (lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }
}
