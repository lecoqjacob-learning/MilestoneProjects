//
//  Milestone1-3.swift
//  MilestoneProjects
//
//  Created by Jacob LeCoq on 2/26/21.
//

import SwiftUI

struct FilledButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(configuration.isPressed ? .gray : .accentColor)
            .padding()
            .background(
                RoundedRectangle(
                    cornerRadius: 8,
                    style: .continuous
                ).stroke(Color.accentColor)
            )
            .scaleEffect(configuration.isPressed ? 0.9 : 1.0)
            .animation(.easeInOut(duration: 0.1))
    }
}

struct Milestone1_3: MilestoneView {
    /**
     View Requirements
      */
    var id = UUID()
    var name: String = "Milestone 1-3"
    var description: String = """
    This project was to build a rock, paper, scissors game. The app chooses the base state and if the user should win or lose the game. Points are added for compliant users. :)
    """
    
    /**
     Project Building
     */
    enum GameState {
        case draw, win, lose
    }
    
    enum Choice: String, CaseIterable {
        case rock, paper, scissors
        
        var localizedName: LocalizedStringKey { LocalizedStringKey(rawValue) }
        
        func beats(otherSign: Choice) -> GameState {
            switch (self, otherSign) {
            case (.rock, .rock): return .draw
            case (.rock, .paper): return .lose
            case (.rock, .scissors): return .win
                
            case (.paper, .rock): return .win
            case (.paper, .paper): return .draw
            case (.paper, .scissors): return .lose
                
            case (.scissors, .rock): return .lose
            case (.scissors, .paper): return .win
            case (.scissors, .scissors): return .draw
            }
        }
        
        var emoji: String {
            switch self {
            case .rock: return "👊"
            case .paper: return "✋"
            case .scissors: return "✌️"
            }
        }
    }
    
    @State private var score: Int = 0
    @State private var shouldWin: Bool = false
    @State private var gameChoice = Choice.rock
    
    var body: some View {
        VStack {
            Text("Current Score: \(self.score)")
                .font(.largeTitle)
                .padding()
            Spacer()
            
            Text("App chose...")
                .font(.title)
                + Text(gameChoice.localizedName)
                .font(.title)
                .bold()
            
            Text("Selection must...")
                .font(.title)
                + Text(shouldWin ? "WIN" : "LOSE")
                .font(.title)
                .bold()
            
            Spacer()
            
            ForEach(Choice.allCases, id: \.self) { choice in
                Button(action: {
                    withAnimation {
                        let outcome = choice.beats(otherSign: gameChoice)
                    
                        switch (outcome, shouldWin) {
                        case (.win, true):
                            self.score += 1
                        case (.lose, false):
                            self.score += 1
                        default: break
                        }
                    
                        self.generateMove()
                    }
                }) {
                    HStack {
                        Text(choice.emoji)
                        Text(choice.localizedName)
                            .fontWeight(.semibold)
                            .font(.title)
                    }
                }
                .buttonStyle(FilledButton())
            }
        }
        .frame(maxWidth: .infinity, alignment: .center)
        .onAppear(perform: generateMove)
    }
    
    private func generateMove() {
        self.gameChoice = Choice.allCases.randomElement()!
        self.shouldWin = Bool.random()
    }
}

struct Milestone1_3_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Milestone1_3()
        }
    }
}
