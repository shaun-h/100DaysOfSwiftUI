//
//  ContentView.swift
//  HabitTrack
//
//  Created by Shaun Hevey on 2/7/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var habits = Habits()
    @State private var showingAddHabit: Bool = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(habits.habits) { habit in
                        HabitItemView(habit: habit)
                            .onTapGesture {
                                let i = habits.habits.firstIndex(of: habit)
                                var h = habit
                                h.compelted += 1
                                guard let i = i else {
                                    return
                                }
                                habits.habits[i] = h
                            }
                            .onLongPressGesture {
                                let i = habits.habits.firstIndex(of: habit)
                                var h = habit
                                h.compelted -= 1
                                guard let i = i else {
                                    return
                                }
                                habits.habits[i] = h
                            }
                    }
                    .onDelete {
                        removeItems(at: $0)
                    }
                }
            }
            .navigationTitle("Habits")
            .toolbar {
                Button {
                    showingAddHabit = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddHabit) {
                AddHabitView(habits: habits)
            }
        }
    }
    func removeItems(at offsets: IndexSet) {
        for o in offsets {
            let item = habits.habits[o]
            habits.habits.removeAll { $0.id == item.id }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
