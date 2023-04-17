//
//  ContentView.swift
//  Challenge 2
//
//  Created by Bartosz Lipiński on 13/04/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var gameManager = GameManager()

    var body: some View {
        ZStack {
            backgroundGradient
            VStack(spacing: 30) {
                winningModeSection
                moveSelection
                gameInformation
            }
        }
        .alert(gameManager.postMoveAlertTitle, isPresented: $gameManager.showPostMoveAlert) {
            if gameManager.questionCount == gameManager.questionLimit {
                Button("Restart") {
                    gameManager.resetGame()
                }
            }
        } message: {
            Text(gameManager.postMoveAlertMessage)
        }
    }

    var backgroundGradient: some View {
        RadialGradient(colors: [.brown, .green], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
    }

    var winningModeSection: some View {
        VStack {
            Text("Select a move to")
                .font(.headline.bold())
            Text(gameManager.winningMode ? "Win" : "Lose")
                .font(.largeTitle.weight(.semibold))
        }
    }

    var moveSelection: some View {
        HStack {
            ForEach(PossibleMove.allCases, id: \.self) { move in
                Button(move.rawValue.capitalized) {
                    gameManager.makeMove(move)
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }

    var gameInformation: some View {
        VStack(spacing: 15) {
            Text("App's move: \(gameManager.selectedMoveByApp.rawValue.capitalized)")
            Text("Score: \(gameManager.score)")
                .font(.headline.weight(.semibold))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
