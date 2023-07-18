//
//  ContentView.swift
//  HighRollers
//
//  Created by Shaun Hevey on 18/7/2023.
//

import SwiftUI

extension FileManager {
    static func documentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

        return paths[0]
    }
}

struct Roll: Identifiable, Equatable, Codable {
    var id: UUID
    var numberOfDice: Int
    var maxDiceValue: Int
    private(set) var values: [Int]
    
    init(id: UUID, numberOfDice: Int, maxDiceValue: Int) {
        self.id = id
        self.numberOfDice = numberOfDice
        self.maxDiceValue = maxDiceValue
        self.values = Roll.getValues(numberOfDice: numberOfDice, maxDiceValue: maxDiceValue)
    }
    
    mutating func reroll() {
        self.values = Roll.getValues(numberOfDice: numberOfDice, maxDiceValue: maxDiceValue)
    }
    
    private static func getValues(numberOfDice: Int, maxDiceValue: Int) -> [Int] {
        return (0..<numberOfDice).map { _ in .random(in: 1...maxDiceValue) }
    }
}

struct DiceView: View {
    var faceValue: String
    var size = 60.0
    var colour = Color(red: 0.7, green: 0.7, blue: 0.7)
    var body: some View {
        Text(faceValue)
            .font(.body)
            .frame(width: size, height: size)
            .padding()
            .background(colour)
            .clipShape(RoundedRectangle(cornerRadius: 10.0))
            
    }
}

struct RollView: View {
    enum RollType {
        case current, previous
    }
    
    var roll: Roll
    var rollType: RollType
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(roll.values, id: \.self) { value in
                    if rollType == .current {
                        DiceView(faceValue: "\(value)")
                    } else if rollType == .previous {
                        DiceView(faceValue: "\(value)", size: 30.0, colour: Color(red: 0.9, green: 0.9, blue: 0.9))
                    }
                }
            }
        }
        .padding()
    }
}

struct ContentView: View {
    
    @State private var rolls: [Roll] = []
    @State private var currentRoll: Roll?
    @State private var showSettings = false
    
    @State private var numberOfDice = 1
    @State private var maxDiceValue = 6
    
    @State private var beforeRollCount = 0
    @State private var isRolling = false
    
    var availableNumberOfDice = 1...100
    var availableMaxDiceValue = [4,6,8,10,12,20,100]
    
    let rollsFilePath = FileManager.documentsDirectory().appendingPathComponent("Rolls.json")
    
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        GeometryReader { geo in
                ScrollView {
                    VStack(spacing: 30) {
                        if currentRoll != nil {
                            RollView(roll: currentRoll!, rollType: .current)
                        }
                        ForEach(rolls.reversed()) { roll in
                            RollView(roll: roll, rollType: .previous)
                        }
                    }
                    .frame(minWidth: geo.size.width,minHeight: geo.size.height)
                }
                .padding(.bottom)
                .padding(.bottom)
                
                
                HStack(spacing: 40) {
                    Button() {
                        roll()
                    } label: {
                        Image(systemName: "dice")
                            .font(.title)
                            .padding()
                            .foregroundColor(.white)
                            .background(.black)
                            .clipShape(Circle())
    
                        
                    }
                    Button() {
                        showSettings = true
                    } label: {
                        Image(systemName: "gear")
                            .font(.title2)
                            .padding()
                            .foregroundColor(.white)
                            .background(.black)
                            .opacity(0.9)
                            .clipShape(Circle())
                        
                    }
                }
                .position(x: geo.frame(in: .global).midX, y: geo.frame(in: .global).maxY - 80)
        }
        .sheet(isPresented: $showSettings) {
            Form {
                Section {
                    Picker("Number of Dice", selection: $numberOfDice) {
                        ForEach(availableNumberOfDice, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.menu)
                    Picker("Max Value", selection: $maxDiceValue) {
                        ForEach(availableMaxDiceValue, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.menu)
                }
                Section {
                    Button("Done") {
                        showSettings = false
                    }
                }
            }
                
        }
        .background(.mint)
        .onAppear {
            load()
        }
        .onReceive(timer) { time in
            guard isRolling else { return }

            if beforeRollCount < 10 {
                beforeRollCount += 1
                currentRoll?.reroll()
                
            } else {
                if currentRoll != nil {
                    rolls.append(currentRoll!)
                }
                
                beforeRollCount = 0
                isRolling = false
                save()
            }
        }
    }

    
    private func roll() {
        currentRoll = Roll(id: UUID(), numberOfDice: numberOfDice, maxDiceValue: maxDiceValue)
        isRolling = true
    }
    
    private func load() {
        do {
            let data = try Data(contentsOf: rollsFilePath)
            self.rolls = try JSONDecoder().decode([Roll].self, from: data)
        } catch {
            self.rolls = []
        }
    }
    
    private func save() {
        do {
            let data = try JSONEncoder().encode(rolls)
            try data.write(to: rollsFilePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
