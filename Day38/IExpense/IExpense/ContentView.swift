//
//  ContentView.swift
//  IExpense
//
//  Created by Shaun Hevey on 25/6/2023.
//

import SwiftUI

struct ExpenseListItem: View {
    @State var item: ExpenseItem
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text(item.type)
            }
            
            Spacer()
            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .fontWeight(getFontWeight(item.amount))
                .foregroundColor(getFontColour(item.amount))
        }
    }
    
    func getFontWeight(_ amount: Double) -> Font.Weight {
        if amount <= 10 {
            return .regular
        }
        
        if amount <= 100 {
            return .semibold
        }
        
        return .bold
    }
    
    func getFontColour(_ amount: Double) -> Color {
        if amount < 0 {
            return .black
        }
        
        return .red
    }
}

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    private var personalItems: [ExpenseItem] {
        expenses.items.filter({ $0.type == "Personal"})
    }
    
    private var businessItems: [ExpenseItem] {
        expenses.items.filter({ $0.type == "Business"})
    }
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    ForEach(personalItems) { item in
                        ExpenseListItem(item: item)
                    }
                    .onDelete {
                        removeItems(at: $0, in: 0)
                    }
                } header: {
                    Text("Personal")
                }
                Section {
                    ForEach(businessItems) { item in
                        ExpenseListItem(item: item)
                    }
                    .onDelete {
                        removeItems(at: $0, in: 1)
                    }
                } header: {
                    Text("Business")
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses)
            }
        }
    }

    
    func removeItems(at offsets: IndexSet, in sec: Int) {
        for o in offsets {
            let item = sec == 0 ? personalItems[o] : businessItems[o]
            expenses.items.removeAll { $0.id == item.id }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
