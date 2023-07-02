//
//  AddHabitView.swift
//  HabitTrack
//
//  Created by Shaun Hevey on 2/7/2023.
//

import SwiftUI

struct AddHabitView: View {
    @Environment(\.dismiss) var dismiss

    @ObservedObject var habits: Habits
    
    @State private var name = ""
    @State private var description = ""
    @State private var symbol = "circle"

    var body: some View {
            NavigationView {
                VStack {
                    HabitItemView(habit: Habit(name: name, description: description, symbol: symbol))
                    Form {
                        TextField("Name", text: $name)
                        TextField("Description", text: $description)
                        
                        Picker("Symbol", selection: $symbol) {
                            Image(systemName: "heart").tag("heart")
                            Image(systemName: "clock").tag("clock")
                            Image(systemName: "leaf").tag("leaf")
                            Image(systemName: "gamecontroller").tag("gamecontroller")
                            Image(systemName: "sun.min").tag("sun.min")
                            Image(systemName: "paperplane").tag("paperplane")
                        }
                        .pickerStyle(.segmented)
                    }
                    .navigationTitle("Add new habit")
                    .toolbar {
                        Button("Save") {
                            let item = Habit(name: name, description: description, symbol: symbol)
                            habits.habits.append(item)
                            dismiss()
                        }
                    }
            }
        }
    }
}

struct AddHabitView_Previews: PreviewProvider {
    static var previews: some View {
        AddHabitView(habits: Habits())
    }
}
