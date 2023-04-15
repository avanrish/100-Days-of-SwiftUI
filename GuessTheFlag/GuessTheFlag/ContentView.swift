//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Bartosz Lipiński on 12/04/2023.
//

import SwiftUI

struct FlagImage: View {
    var country: String

    var body: some View {
        Image(country)
            .renderingMode(.original)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0 ... 2)
    @State private var score = 0
    @State private var scoreMessage = ""
    @State private var questionCount = 0
    @State private var showingEnd = false

    @State private var flagSelected: Int = -1

    var body: some View {
        ZStack {
            // LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()

            VStack {
                Spacer()
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                VStack(spacing: 30) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))

                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }

                    ForEach(0 ..< 3) { number in
                        Button {
                            withAnimation {
                                flagSelected = number
                            }
                            flagTapped(number)
                        } label: {
                            FlagImage(country: countries[number])
                                .rotation3DEffect(.degrees(flagSelected == number ? 360 : 0), axis: (x: 0, y: 1, z: 0))
                                .opacity(flagSelected == -1 || flagSelected == number ? 1 : 0.25)
                                .rotation3DEffect(.degrees(flagSelected == -1 || flagSelected == number ? 0 : 180), axis: (x: 1, y: 0, z:0))
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))

                Spacer()
                Spacer()

                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text(scoreMessage)
        }
        .alert("Game finished", isPresented: $showingEnd) {
            Button("Restart", action: restartGame)
        } message: {
            Text("""
            The game has ended, your score is \(score)/8, congrats!
            You can restart the game any time!
            """)
        }
    }

    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            scoreTitle = "Correct"
            score += 1
            scoreMessage = "Your score is \(score)"
        } else {
            scoreTitle = "Wrong"
            scoreMessage = "Wrong! That's the flag of \(countries[number])"
        }

        questionCount += 1
        if questionCount == 8 {
            showingEnd = true
        } else {
            showingScore = true
        }
    }

    func restartGame() {
        score = 0
        questionCount = 0
        askQuestion()
    }

    func askQuestion() {
        flagSelected = -1
        countries.shuffle()
        correctAnswer = Int.random(in: 0 ... 2)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
