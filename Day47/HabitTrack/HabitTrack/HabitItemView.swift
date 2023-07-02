//
//  HabitItemView.swift
//  HabitTrack
//
//  Created by Shaun Hevey on 2/7/2023.
//

import SwiftUI

struct HabitItemView: View {
    var habit: Habit
    
    var body: some View {
        HStack {
            Image(systemName: habit.symbol)
                .font(.system(size: 40))
                .fontWeight(.heavy)
            VStack(alignment: .leading) {
                Text(habit.name)
                    .font(.title)
                    .fontWeight(.bold)
                if habit.description != "" { Text(habit.description) }
                Text("Completed: \(habit.compelted) times")
                
            }
        }
    }
}

struct HabitItemView_Previews: PreviewProvider {
    static var habits = Habits().habits
    static var previews: some View {
        HabitItemView(habit: (habits.count > 0 ? habits[0] : Habit(name: "Test", description: "Test Description \n asdf \n asdfasdf", symbol: "circle")))
    }
}
