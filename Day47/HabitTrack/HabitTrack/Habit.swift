//
//  Habit.swift
//  HabitTrack
//
//  Created by Shaun Hevey on 2/7/2023.
//

import Foundation
import SwiftUI

struct Habit : Identifiable, Codable, Equatable {
    
    var id = UUID()
    let name: String
    let description: String
    let symbol: String
    var compelted: Int = 0
}
