//
//  ContentView.swift
//  Challenge 2
//
//  Created by Bartosz Lipiński on 13/04/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var gameViewModel = GameViewModel()

    var body: some View {
        ZStack {
            backgroundGradient
            VStack(spacing: 30) {
                winningModeSection
                moveSelection
                gameInformation
            }
        }
        .alert(gameViewModel.postMoveAlertTitle, isPresented: $gameViewModel.isPostMoveAlertDisplayed) {
            if gameViewModel.questionCount == gameViewModel.questionLimit {
                Button("Restart") {
                    gameViewModel.resetGame()
                }
            }
        } message: {
            Text(gameViewModel.postMoveAlertMessage)
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
            Text(gameViewModel.winningMode ? PossibleOutcome.win.rawValue.capitalized : PossibleOutcome.lose.rawValue.capitalized)
                .font(.largeTitle.weight(.semibold))
        }
    }

    var moveSelection: some View {
        HStack {
            ForEach(PossibleMove.allCases, id: \.self) { move in
                Button(move.rawValue.capitalized) {
                    gameViewModel.makeMove(move)
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }

    var gameInformation: some View {
        VStack(spacing: 15) {
            Text("App's move: \(gameViewModel.selectedMoveByApp.rawValue.capitalized)")
            Text("Score: \(gameViewModel.score)")
                .font(.headline.weight(.semibold))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
