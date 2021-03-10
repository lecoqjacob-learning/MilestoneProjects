//
//  Milestone16-18.swift
//  MilestoneProjects
//
//  Created by Jacob LeCoq on 3/5/21.
//

import SwiftUI
import GameplayKit

struct Milestone16_18: MilestoneView {
    /**
     View Requirements
      */
    var id = UUID()
    var name = "Milestone 16-18"
    var description = "Main Work: Build an app that rolls dice"
    
    var body: some View {
        let d6 = GKRandomDistribution.d6()
        print(d6.nextInt())
        return Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct Milestone16_18_Previews: PreviewProvider {
    static var previews: some View {
        Milestone16_18()
    }
}
