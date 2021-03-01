//
//  Activity.swift
//  MilestoneProjects
//
//  Created by Jacob LeCoq on 2/28/21.
//

import SwiftUI

struct Activity: Identifiable, Codable {
    let id: UUID
    let title: String
    let description: String
    var completionCount: Int
    
    init(title: String, description: String) {
        self.id = UUID()
        self.title = title
        self.description = description
        self.completionCount = 0
    }
}

class ActivityContainer: ObservableObject {
    
    @Published var activities: [Activity]{
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(activities) {
                UserDefaults.standard.set(encoded, forKey: "Activites")
            }
        }
    }

    init() {
        if let activities = UserDefaults.standard.data(forKey: "Activites") {
            let decoder = JSONDecoder()
            
            if let decoded = try? decoder.decode([Activity].self, from: activities) {
                self.activities = decoded
                return
            }
        }

        self.activities = []
    }
}
