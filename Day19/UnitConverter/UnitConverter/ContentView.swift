//
//  ContentView.swift
//  UnitConverter
//
//  Created by Shaun Hevey on 5/6/2023.
//

import SwiftUI

enum UnitType: String, CaseIterable {
    case Temperature
    case Time
    case Volume
    case Length
}
struct ContentView: View {
    @State private var toConvert: Double = 0
    @State private var conversionType: UnitType = .Temperature

    @State private var fromUnit: Dimension = UnitTemperature.celsius
        
    @State private var toUnit: Dimension = UnitTemperature.fahrenheit
    @FocusState private var isFocused: Bool
    
    var availableTempUnits: [Dimension] = [UnitTemperature.celsius, UnitTemperature.fahrenheit, UnitTemperature.kelvin]
    
    var availableTimeUnits: [Dimension] = [        UnitDuration.seconds, UnitDuration.minutes, UnitDuration.hours]
    
    var availableVolumeUnits: [Dimension] = [UnitVolume.milliliters, UnitVolume.liters, UnitVolume.cups, UnitVolume.pints, UnitVolume.gallons]
    
    var availableLengthUnits: [Dimension] = [UnitLength.meters, UnitLength.kilometers, UnitLength.feet, UnitLength.yards, UnitLength.miles]
    
    
    var availableUnits : [Dimension] {
        if conversionType == .Temperature {
            return availableTempUnits
        }
        
        if conversionType == .Time {
            return availableTimeUnits
        }
        
        if conversionType == .Volume {
            return availableVolumeUnits
        }
        
        if conversionType == .Length {
            return availableLengthUnits
        }
        
        return []
    }
    
    func updateSelectionUnits() {
        if !availableUnits.contains(fromUnit) {
            fromUnit = availableUnits[0]
        }
        if !availableUnits.contains(toUnit) {
            toUnit = availableUnits[1]
        }
    }

    var converted: Double {
        let unit = Measurement(value: toConvert, unit: fromUnit)
        
        return unit.converted(to: toUnit).value
        
    }
    
    var body: some View {
        Form {
            Section {
                Picker("Unit Type", selection: $conversionType) {
                    ForEach(UnitType.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }.pickerStyle(.segmented)
                    .onChange(of: conversionType) { _ in updateSelectionUnits() }
            } header: {
                Text("Unit Type")
            }
            Section {
                TextField("Value", value: $toConvert, format: .number)
                    .keyboardType(.decimalPad)
                    .focused($isFocused)
                Picker("Unit", selection: $fromUnit) {
                    ForEach(availableUnits, id: \.self) {
                        Text($0.symbol)
                    }
                }.pickerStyle(.segmented)
            } header: {
                Text("Convert From")
            }
            Section {
                Text("\(converted, specifier: "%.4f")")
                Picker("Unit", selection: $toUnit) {
                    ForEach(availableUnits, id: \.self) {
                        Text($0.symbol)
                    }
                }.pickerStyle(.segmented)
            } header: {
                Text("Converted")
            }
            
            
        }
        .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    isFocused = false
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
