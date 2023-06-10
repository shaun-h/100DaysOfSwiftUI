//
//  ContentView.swift
//  WeSplit
//
//  Created by Shaun Hevey on 5/6/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 20
    @FocusState private var amountIsFocused: Bool
    var currentCurrency:  FloatingPointFormatStyle<Double>.Currency  {
        return .currency(code: Locale.current.currency?.identifier ?? "USD")
        
    }
    
    var totalWithTip: Double {
        let tipSelection = Double(tipPercentage)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        return grandTotal
    }

    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let amountPerPerson = totalWithTip / peopleCount
        return amountPerPerson
    }
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: currentCurrency)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of People", selection: $numberOfPeople) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }.pickerStyle(.automatic)
                }
                Section {
                    Picker("Tip Amount", selection: $tipPercentage) {
                        ForEach(0...100, id: \.self) {
                            Text($0, format:.percent)
                        }
                    }.pickerStyle(.automatic)
                } header: {
                    Text("How much tip would you like to leave?")
                }
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD")).foregroundColor(tipPercentage == 0 ? .red : .primary)
                } header: {
                    Text("Amount per person")
                }
                Section {
                    Text(totalWithTip, format: currentCurrency)
                } header: {
                    Text("Total Check Amount")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
