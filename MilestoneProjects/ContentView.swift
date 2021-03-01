//
//  ContentView.swift
//  MilestoneProjects
//
//  Created by Jacob LeCoq on 2/26/21.
//

import SwiftUI

struct ContentView: View {
    struct MilestoneExample: MilestoneView {
        var id: UUID
        var name: String
        var description: String
        var body: AnyView

        init<U>(_ milestone: U) where U: MilestoneView {
            self.id = UUID()
            self.name = milestone.name
            self.description = milestone.description
            self.body = AnyView(milestone)
        }
    }
    
    let MILESTONE_VIEWS = [
        MilestoneExample(Milestone1_3()),
        MilestoneExample(Milestone4_6()),
        MilestoneExample(Milestone7_9()),
        MilestoneExample(Milestone10_12())
    ]

    var body: some View {
        NavigationView {
            List(MILESTONE_VIEWS, id: \.id) { example in
                NavigationLink(destination: BaseMilestoneView(milestoneView: example)) {
                    Text(example.name)
                }
            }
            .navigationTitle("Milestone Projects")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
