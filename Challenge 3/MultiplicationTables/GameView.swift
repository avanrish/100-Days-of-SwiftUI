//
//  GameView.swift
//  MultiplicationTables
//
//  Created by Bartosz Lipiński on 15/04/2023.
//

import SwiftUI

struct GameView: View {
    @StateObject private var questionViewModel: QuestionViewModel
    @Binding var isGameViewActive: Bool

    init(amountOfQuestions: Int, upTo: Int, isGameViewActive: Binding<Bool>) {
        _questionViewModel = StateObject(wrappedValue: QuestionViewModel(amount: amountOfQuestions, upTo: upTo))
        _isGameViewActive = isGameViewActive
    }

    var body: some View {
        VStack {
            Section("Question") {
                Text(questionViewModel.getCurrentQuestion().question)
                    .font(.headline)
            }
            Section("Answers") {
                HStack {
                    ForEach(questionViewModel.getCurrentQuestion().possibleAnswers, id: \.self) { answer in
                        Button("\(answer)") {
                            questionViewModel.checkAnswer(answer)
                        }
                    }
                }
            }
        }
        .alert("Wrong", isPresented: $questionViewModel.wrongAnswerAlertIsPresented) {} message: {
            Text(questionViewModel.wrongAnswerAlertMessage)
        }
        .alert("End", isPresented: $questionViewModel.gameHasEndedAlertIsPresented) {
            Button("Restart") {
                isGameViewActive = false
            }
        } message: {
            Text(questionViewModel.gameHasEndedAlertMessage)
        }
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(amountOfQuestions: 1, upTo: 1, isGameViewActive: .constant(true))
    }
}
