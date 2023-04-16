//
//  ContentView.swift
//  Challenge 2
//
//  Created by Bartosz Lipiński on 13/04/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedMove = Int.random(in: 0 ... 2)
    @State private var shouldWin = Bool.random()
    @State private var score = 0
    @State private var questionCount = 0
    @State private var scoreTitle = ""
    @State private var scoreMessage = ""
    @State private var showAlert = false
    @State private var endAlert = false

    let moves = ["rock", "paper", "scissors"]

    var body: some View {
        ZStack {
            RadialGradient(colors: [.brown, .green], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            VStack(spacing: 30) {
                VStack {
                    Text("Select a move to")
                        .font(.headline.bold())
                    Text(shouldWin ? "Win" : "Lose")
                        .font(.largeTitle.weight(.semibold))
                }
                HStack {
                    ForEach(moves, id: \.self) { move in
                        Button(move.capitalized) {
                            choose(move)
                        }
                        .buttonStyle(.borderedProminent)
                    }
                }
                VStack(spacing: 15) {
                    Text("App's move: \(moves[selectedMove].capitalized)")
                    Text("Score: \(score)")
                        .font(.headline.weight(.semibold))
                }
            }
        }
        .alert(scoreTitle, isPresented: $showAlert) {
        } message: {
            Text(scoreMessage)
        }
        .alert("Finish", isPresented: $endAlert) {
            Button("Restart") {
                restart()
            }
        } message: {
            Text("""
            The game has ended, your score is \(score)
            You can restart any time!
            """)
        }
    }

    func restart() {
        score = 0
        shouldWin = Bool.random()
        selectedMove = Int.random(in: 0 ... 2)
    }

    func choose(_ move: String) {
        let moveByApp = moves[selectedMove]
        var moveToBeat: String
        switch moveByApp {
        case "rock":
            moveToBeat = shouldWin ? "paper" : "scissors"
        case "paper":
            moveToBeat = shouldWin ? "scissors" : "rock"
        default:
            moveToBeat = shouldWin ? "rock" : "paper"
        }
        if moveByApp == move {
            scoreTitle = "Draw"
            scoreMessage = """
            You made the same move as app
            Current score: \(score)
            """
        } else if move == moveToBeat {
            score += 1
            scoreTitle = "Correct"
            scoreMessage = "Current score: \(score)"
        } else {
            score -= 1
            scoreTitle = "Wrong"
            scoreMessage = "Current score: \(score)"
        }
        shouldWin.toggle()
        selectedMove = Int.random(in: 0...2)
        questionCount += 1
        if questionCount == 10 {
            endAlert = true
        } else {
            showAlert = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
