//
//  Menu.swift
//  WhatsTheMult
//
//  Created by Shaun Hevey on 18/6/2023.
//

import SwiftUI
struct Question {
    var text: String
    var answer: String
}

struct GameMenu: View {
    @State private var multTableChosen = 2
    @State private var multTable = 2...12
    @State private var numberOfQuestionsAvailable = [5,10,20]
    @State private var numberOfQuestions = 5
    @State private var isShowingGame = false
    
    var questions : [Question] {
        var questions: [Question] = []
        
        for _ in 1...numberOfQuestions {
            let num = Int.random(in: 1...12)
            let answer = num * multTableChosen
            questions.append(Question.init(text: "\(num) x \(multTableChosen)", answer: "\(answer)"))
        }
        
        return questions
    }
    var body: some View {
        VStack {
            Form {
                Text("Welcome to What the mult, a edugame to help you learn your times tables. The game will randomly generate questions for your chosen Multiplcation Table")
                Section {
                    Picker("Multplication Table", selection: $multTableChosen) {
                        ForEach(multTable, id: \.self) {
                            Text("\($0)")
                        }
                    }.pickerStyle(.automatic)
                    Picker("How many questions", selection: $numberOfQuestions) {
                        ForEach(numberOfQuestionsAvailable, id: \.self) {
                            Text("\($0)")
                        }
                    }.pickerStyle(.automatic)
                    
                }
                Section {
                    NavigationLink(destination: Game(questions: questions, multTable: multTableChosen)) {
                        Text("Play")
                    }
                }
            }
            .formStyle(.automatic)
        }
        .navigationTitle("Whats the Mult")
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        GameMenu()
    }
}
