//
//  Milestone4-6.swift
//  MilestoneProjects
//
//  Created by Jacob LeCoq on 2/27/21.
//

import SwiftUI

struct Milestone4_6: MilestoneView {
    /**
     Required Milestone attributes
     */
    var id = UUID()
    var name: String = "Milestone 4-6"
    var description: String = "Build a kids game"

    /**
     Actual Game Code
     */
    @ObservedObject private var gameState = KidsGame()

    var body: some View {
        NavigationView {
            Group {
                if isGameView() {
                    GameView(gameState)
                } else {
                    SettingsView(gameState)
                }
            }
            .navigationBarItems(trailing:
                HStack {
                    Button(isGameView() ? "Settings" : "Play") {
                        withAnimation {
                            self.switchView()
                        }
                    }
                }
            )
        }
    }
    
    private func switchView(){
        if (isGameView()){
            self.gameState.state = KidsGame.GameState.inSettings
        } else {
            self.gameState.state = KidsGame.GameState.inPlay
        }
    }
    
    private func isGameView () -> Bool {
        return gameState.state == KidsGame.GameState.inPlay || gameState.state == KidsGame.GameState.complete
    }
}

struct Milestone4_6_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Milestone4_6()
        }
    }
}
