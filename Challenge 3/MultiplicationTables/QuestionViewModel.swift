//
//  QuestionViewModel.swift
//  MultiplicationTables
//
//  Created by Bartosz Lipiński on 15/04/2023.
//

import Combine

class QuestionViewModel: ObservableObject {
    @Published var questions: [Question] = []
    @Published var currentQuestion = 0
    @Published var score = 0

    @Published var wrongAnswerAlertIsPresented = false
    @Published var wrongAnswerAlertMessage = ""
    
    @Published var gameHasEndedAlertIsPresented = false
    @Published var gameHasEndedAlertMessage = ""

    init(amount: Int, upTo: Int) {
        setupQuestions(with: amount, upTo: upTo)
    }

    deinit {
        print("lets hope it deinited")
    }

    func setupQuestions(with amount: Int, upTo: Int) {
        questions = generateQuestions(amount: amount, upTo: upTo)
    }

    func generateQuestions(amount: Int, upTo: Int) -> [Question] {
        var questions: [Question] = []
        while questions.count < amount {
            let a = Int.random(in: 1...upTo)
            let b = Int.random(in: 1...upTo)
            let correctAnswer = a * b
            var possibleAnswers: [Int] = [correctAnswer]
            while possibleAnswers.count < 3 {
                let possibleAnswer = Int.random(in: 1...144)
                if !possibleAnswers.contains(possibleAnswer) {
                    possibleAnswers.append(possibleAnswer)
                }
            }
            let question = Question(question: "\(a) * \(b)", correctAnswer: correctAnswer, possibleAnswers: possibleAnswers.shuffled())
            if !questions.contains(where: { $0.question == question.question }) {
                questions.append(question)
            }
        }
        return questions
    }

    func getCurrentQuestion() -> Question {
        return questions[currentQuestion]
    }

    func checkAnswer(_ answer: Int) {
        let correctAnswer = getCurrentQuestion().correctAnswer
        if answer == correctAnswer {
            score += 1
        } else {
            wrongAnswerAlertIsPresented = true
            wrongAnswerAlertMessage = "Your answer is incorrect. The correct answer was \(correctAnswer)!"
        }
        nextQuestion()
    }

    func nextQuestion() {
        if (currentQuestion + 1) == questions.count {
            gameHasEndedAlertIsPresented = true
            gameHasEndedAlertMessage = "Game has ended. Your score is \(score)/\(questions.count)"
        }
        else {
            currentQuestion += 1
        }
    }
    
    func restoreToDefault() {
        questions = []
        currentQuestion = 0
        score = 0
    }
}
