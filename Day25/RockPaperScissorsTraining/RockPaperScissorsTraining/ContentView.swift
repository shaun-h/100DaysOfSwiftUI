//
//  ContentView.swift
//  RockPaperScissorsTraining
//
//  Created by Shaun Hevey on 11/6/2023.
//

import SwiftUI

struct ContentView: View {
    private var symbols = ["🪨", "📄", "✂️"]
    @State private var chosenSymbol = Int.random(in: 0..<3)
    @State private var chosenOutcome = Bool.random()
    @State private var showCorrect = false
    @State private var showIncorrect = false
    @State private var gameOver = false
    @State private var score = 0
    @State private var questionNumber = 1
    
    private var availableAnswers: [String] {
        symbols.filter() { $0 != symbols[self.chosenSymbol] }
    }
    
    private var correctAnswer: Int {
        var answer = chosenOutcome ? chosenSymbol + 1 : chosenSymbol - 1
        
        if answer < 0 {
            answer = symbols.count - 1
        } else if answer > 2 {
            answer = 0
        }
        return answer
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text("Rock, Paper, Scissors")
                .font(.title)
                .fontWeight(.bold)
            Text(symbols[chosenSymbol])
                    .font(.system(size:75))
            Spacer()
            Text("Choose the \(chosenOutcome ? "winning" : "loosing") option")
                .font(.body)
            HStack {
                ForEach(availableAnswers, id: \.self) { a in
                    Button {
                        checkAnswer(answer: a)
                    } label: {
                        Text(a)
                            .font(.system(size: 100))
                    }
                        
                }
            }
            .alert("You are correct", isPresented: $showCorrect) {
                Button("Continue", action: newTurn)
            } message: {
                Text("Your score is \(score)")
            }
            .alert("You are incorrect", isPresented: $showIncorrect) {
                Button("Continue", action: newTurn)
            } message: {
                Text("Your score is \(score)")
            }
            .alert("Game Over", isPresented: $gameOver) {
                Button("Try Again", action: resetGame)
            } message: {
                Text("Your score is \(score)")
            }
            Text("Question \(questionNumber)/10")
                .font(.title2)
            Spacer()
            Spacer()
        }
    }
    
    func checkAnswer(answer: String) {
        if answer == symbols[correctAnswer] {
            showCorrect = true
            score += 1
        } else {
            showIncorrect = true
            score -= 1
        }
    }
    
    func newTurn() -> Void {
        if questionNumber >= 10 {
            gameOver = true
        } else {
            chosenSymbol = Int.random(in: 0..<3)
            chosenOutcome.toggle()
            questionNumber += 1
        }
    }
    
    func resetGame() -> Void {
        score = 0
        questionNumber = 0
        newTurn()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
