//
//  ExpenseItem.swift
//  IExpense
//
//  Created by Shaun Hevey on 25/6/2023.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
