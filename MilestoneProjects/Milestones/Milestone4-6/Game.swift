//
//  Game.swift
//  MilestoneProjects
//
//  Created by Jacob LeCoq on 2/28/21.
//

import SwiftUI

class KidsGame: ObservableObject {
    struct Settings {
        var minTimeTable: Int = 1
        var maxTimeTable: Int = 1
        var numOfQuestionsIndex: Int = 0
        var questionAmounts: [String] = ["5", "10", "20", "All"]
    }
    
    enum GameState {
        case complete, inPlay, inSettings
    }
    
    @Published var settings: Settings
    @Published var state: GameState

    init() {
        self.settings = Settings()
        self.state = GameState.inSettings
    }
}
