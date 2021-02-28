//
//  GameView.swift
//  MilestoneProjects
//
//  Created by Jacob LeCoq on 2/27/21.
//

import SwiftUI

struct RoundButton: View {
    var name = ""
    var primaryColor = Color.blue
    var secondaryColor = Color.white

    var body: some View {
        Text("\(name)")
            .padding(20)
            .font(.headline)
            .frame(minWidth: 100, idealWidth: 200, maxWidth: 300, minHeight: 50, idealHeight: 50, maxHeight: 50, alignment: .center)

            .foregroundColor(primaryColor)
            .background(secondaryColor)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(primaryColor, lineWidth: 4)
            )
    }
}

struct QuestionView: View {
    var question: Question

    @Binding var answer: String

    var body: some View {
        HStack {
            RoundButton(name: "\(question.num1)", primaryColor: Color.blue, secondaryColor: Color.white)
            Text(" x ")
            RoundButton(name: "\(question.num2)", primaryColor: Color.blue, secondaryColor: Color.white)
        }

        TextField("Answer", text: $answer)
            .padding(10)
            .multilineTextAlignment(.center)
            .font(Font.system(size: 15, weight: .medium, design: .serif))
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue, lineWidth: 1))
            .keyboardType(.decimalPad)
            .padding()
    }
}

struct GameView: View {
    @ObservedObject var gameState: KidsGame
    
    @State var questions: [Question] = []
    @State var curQuestion: Question? = nil

    @State var correctQuestions: Int = 0
    @State var questionCounter: Int = 0
    @State var totalQuestions: Int = 0

    @State var showResults = false
    @State var isCorrect = false

    @State var answer: String = ""
    
    init(_ gameState: KidsGame){
        self.gameState = gameState
    }

    var body: some View {
        VStack {
            QuestionView(question: curQuestion ?? Question(num1: 0, num2: 0), answer: $answer)

            Button(action: {
                // check answer
                self.checkAnswer()

                // clear out the answer
                self.answer = ""

                // load question
                self.loadQuestion()
            }) {
                RoundButton(name: "Check", primaryColor: Color.white, secondaryColor: Color.blue)
            }

            Spacer()

            RoundButton(name: "Score: \(correctQuestions)/\(questionCounter): Total Questions: \(gameState.settings.questionAmounts[gameState.settings.numOfQuestionsIndex])", primaryColor: isCorrect ? Color.green : Color.red, secondaryColor: Color.white)
        }
        .onAppear(perform: setState)
        .alert(isPresented: $showResults) {
            Alert(title: Text("Times Table Game Complete"), message: Text("Score: \(correctQuestions)/\(totalQuestions)"), dismissButton: .default(Text("Continue")) {
                withAnimation {
                    self.gameState.state = KidsGame.GameState.inSettings
                }
            })
        }
    }

    private func setState() {
        loadQuestions()
        curQuestion = questions[0]
        gameState.state = KidsGame.GameState.inPlay
    }

    private func loadQuestions() {
        for num1 in gameState.settings.minTimeTable ... gameState.settings.maxTimeTable {
            for num2 in gameState.settings.minTimeTable ... gameState.settings.maxTimeTable {
                let newQuest = Question(num1: num1, num2: num2)
                questions.append(newQuest)
            }
        }

        questions.shuffle()
        totalQuestions = Int(gameState.settings.questionAmounts[gameState.settings.numOfQuestionsIndex]) ?? questions.count
    }

    private func checkAnswer() {
        let typedAnswer = Int(answer) ?? 0
        let rightAnswer = Int(curQuestion!.num1) * Int(curQuestion!.num2)

        guard typedAnswer == rightAnswer else {
            // INCORRECT
            isCorrect = false
            return
        }

        // CORRECT!!!
        isCorrect = true
        correctQuestions += 1
    }

    private func loadQuestion() {
        guard (questionCounter + 1) < totalQuestions else {
            // Game Over
            gameState.state = KidsGame.GameState.complete
            showResults.toggle()
            return
        }

        let index = questions.firstIndex(of: curQuestion!)
        curQuestion = questions[((index ?? 0) + 1) % questions.count]
        questionCounter += 1
    }
}

struct GameView_Previews: PreviewProvider {
    static var previews: some View {
        GameView(KidsGame())
    }
}
