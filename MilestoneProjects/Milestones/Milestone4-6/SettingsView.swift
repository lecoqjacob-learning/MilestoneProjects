//
//  SwiftUIView.swift
//  MilestoneProjects
//
//  Created by Jacob LeCoq on 2/27/21.
//

import SwiftUI

extension AnyTransition {
    static var customTransition: AnyTransition {
        let transition = AnyTransition.move(edge: .top)
            .combined(with: .scale(scale: 0.2, anchor: .top))
            .combined(with: .opacity)

        return transition
    }
}

struct AnimalImage: View {
    var name: String = "panda"

    var animalNames = ["panda", "bear", "zebra", "shark", "gorilla", "bear", "buffalo", "chick", "chicken", "cow", "crocodile", "duck", "dog", "elephant", "frog", "giraffe", "goat", "hippo", "horse", "monkey", "moose", "narwhal", "owl", "parrot", "pig", "penguin", "rabbit", "rhino", "sloth", "snake", "walrus", "whale"]

    var body: some View {
        Image(animalNames[Int.random(in: 0..<animalNames.count)])
            .resizable()
            .scaledToFit()
    }
}

struct SectionHeader: View {
    var title: String

    public init(_ content: String) {
        self.title = content
    }

    var body: some View {
        HStack {
            AnimalImage().frame(width: 30, height: 30)
            Text(title)
                .font(.headline)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
            AnimalImage().frame(width: 30, height: 30)
        }
    }
}

struct SettingsView: View {
    @ObservedObject var gameState: KidsGame
    
    // animations
    @State private var angle: Double = 0
    @State private var dragAmount = CGSize.zero

    init(_ gameState: KidsGame) {
        self.gameState = gameState
    }

    var body: some View {
        let min = Binding<Int>(get: {
            self.gameState.settings.minTimeTable

        }, set: {
            self.gameState.settings.minTimeTable = $0

            if $0 >= self.gameState.settings.maxTimeTable {
                self.gameState.settings.maxTimeTable = $0
            }
        })
        
        let max = Binding<Int>(get: {
            self.gameState.settings.maxTimeTable

        }, set: {
            self.gameState.settings.maxTimeTable = $0
        })
        
        let index = Binding<Int>(get: {
            self.gameState.settings.numOfQuestionsIndex

        }, set: {
            self.gameState.settings.numOfQuestionsIndex = $0
        })

        return VStack {
            Section(header: SectionHeader("What times tables would you like to practice?")) {
                Text("Min")
                Picker("minimum", selection: min) {
                    ForEach(1...12, id: \.self) {
                        index in
                        Text("\(index)")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())

                Text("Max")
                Picker("minimum", selection: max) {
                    ForEach(self.gameState.settings.minTimeTable...12, id: \.self) {
                        index in
                        Text("\(index)")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }

            Section(header: SectionHeader("How many questions?")) {
                Picker("Picker", selection: index) {
                    ForEach(0..<self.gameState.settings.questionAmounts.count) {
                        index in
                        Text("\(gameState.settings.questionAmounts[index])")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }.fixedSize(horizontal: false, vertical: true)
        }
        .transition(.customTransition)
//        .onAppear(perform: test)
    }

    private func setState() {
        gameState.state = KidsGame.GameState.inSettings
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(KidsGame())
    }
}
