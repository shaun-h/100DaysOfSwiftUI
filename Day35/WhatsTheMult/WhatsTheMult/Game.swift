//
//  Game.swift
//  WhatsTheMult
//
//  Created by Shaun Hevey on 18/6/2023.
//

import SwiftUI
struct AnswerButton: View {
    var text: String
    var function: () -> Void
    var body: some View {
        Button() {
            function()
        } label: {
            ZStack {
                Color.blue
                    .frame(width: 75, height: 75)
                Text("\(text)")
                    .foregroundColor(.white)
            }
        }
    }
}
struct Game: View {
    @State var questions : [Question]
    @State var multTable : Int
    
    @State private var questionNumber = 0
    @State private var guess = ""
    @State private var score = 0
    
    @State private var messageText = ""
    @State private var messageTitle = ""
    @State private var messageShown = false
    
    @State private var background = Color(red: 0, green: 0, blue: 0.5)
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            background
            VStack {
                Text("\(multTable) times tables")
                    .font(.title)
                    .foregroundColor(.white)
                    .padding()
                HStack() {
                    Text("Score: \(score)")
                        .foregroundColor(.white)
                        .font(.title2)
                    Spacer()
                    Text("Question: \(questionNumber + 1)/\(questions.count)")
                        .foregroundColor(.white)
                        .font(.title2)
                }.padding()
                Spacer()
                Text(questions[questionNumber].text)
                    .font(.title)
                    .foregroundColor(.white)
                HStack {
                    Text("=")
                        .foregroundColor(.white)
                    Text(guess)
                        .font(.title)
                        .foregroundColor(.white)
                }
                Grid {
                    GridRow {
                        ForEach(1..<4) { num in
                            AnswerButton(text: "\(num)", function: { guess += "\(num)" })
                        }
                    }
                    GridRow {
                        ForEach(4..<7) { num in
                            AnswerButton(text: "\(num)", function: { guess += "\(num)" })
                        }
                    }
                    GridRow {
                        ForEach(7..<10) { num in
                            AnswerButton(text: "\(num)", function: { guess += "\(num)" })
                        }
                    }
                    GridRow {
                        AnswerButton(text: "<" , function: { guess = String(guess.dropLast()) })
                        AnswerButton(text: "0", function: { guess += "0" })
                        AnswerButton(text: "Check", function: checkAnswer)
                    }
                    
                }
                Spacer()
            }
            .alert(messageTitle, isPresented: $messageShown, actions: {
                Button("New Game", action: { dismiss() })
                
            }) {
                Text(messageText)
            }
        }
    }
    
    func checkAnswer() {
        let correct = questions[questionNumber].answer == guess
        
        if correct {
            score += 1
            withAnimation(Animation.easeIn(duration: 1)) {
                background = Color.green
            }
        }
        else {
            withAnimation(Animation.easeIn(duration: 1)) {
                background = Color.red
            }
        }
        
        if questionNumber == questions.count - 1 {
            messageText = "Your final score is \(score)"
            messageTitle = "Game Over"
            messageShown = true
        }
        else {
            guess = ""
            questionNumber += 1
        }
        withAnimation(Animation.easeIn(duration: 1).delay(1)) {
            background = Color(red: 0, green: 0, blue: 0.5)
        }
    }
}

struct Game_Previews: PreviewProvider {
    static var previews: some View {
        Game(questions:[Question.init(text: "1 x 3", answer: "3"), Question.init(text: "10 x 3", answer: "30")], multTable: 3)
    }
}
