//
//  GameViewModel.swift
//  Challenge 2
//
//  Created by Bartosz Lipiński on 17/04/2023.
//

import Combine

class GameViewModel: ObservableObject {
    @Published var selectedMoveByApp = PossibleMove.allCases.randomElement() ?? .rock
    @Published var winningMode = Bool.random()
    @Published var score = 0
    @Published var questionCount = 0
    var postMoveAlertTitle = ""
    var postMoveAlertMessage = ""
    var isPostMoveAlertDisplayed = false
    let questionLimit = 5

    func resetGame() {
        score = 0
        questionCount = 0
        winningMode = Bool.random()
        selectedMoveByApp = PossibleMove.allCases.randomElement() ?? .rock
    }

    func makeMove(_ move: PossibleMove) {
        let moveOutcome = selectedMoveOutcome(move)
        switch moveOutcome {
        case .draw:
            score += 1
        case .win:
            score += 2
        case .lose:
            score -= 2
        }
        displayPostMoveAlert(outcome: moveOutcome)
        questionCount += 1
        winningMode.toggle()
        selectedMoveByApp = PossibleMove.allCases.randomElement() ?? .rock
    }

    func displayPostMoveAlert(outcome: PossibleOutcome) {
        if questionCount + 1 == questionLimit {
            postMoveAlertTitle = "Game Over"
            postMoveAlertMessage = """
            The game has ended, your score is \(score)
            You can restart any time!
            """
            isPostMoveAlertDisplayed = true
            return
        }
        switch outcome {
        case .draw:
            postMoveAlertTitle = "Draw"
            postMoveAlertMessage = """
            You made the same move as app
            Current score: \(score)
            """
        case .win:
            postMoveAlertTitle = "Correct"
            postMoveAlertMessage = "Current score: \(score)"
        case .lose:
            postMoveAlertTitle = "Wrong"
            postMoveAlertMessage = "Current score: \(score)"
        }
        isPostMoveAlertDisplayed = true
    }

    func selectedMoveOutcome(_ move: PossibleMove) -> PossibleOutcome {
        if move == selectedMoveByApp {
            return .draw
        } else if move == moveToBeat() {
            return .win
        }
        return .lose
    }

    func moveToBeat() -> PossibleMove {
        switch selectedMoveByApp {
        case .rock:
            return winningMode ? .paper : .scissors
        case .paper:
            return winningMode ? .scissors : .rock
        case .scissors:
            return winningMode ? .rock : .paper
        }
    }
}
