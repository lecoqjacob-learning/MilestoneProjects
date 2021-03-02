//
//  BaseMilestoneView.swift
//  MilestoneProjects
//
//  Created by Jacob LeCoq on 2/27/21.
//

import SwiftUI

protocol MilestoneView: Identifiable, View {
    var name: String { get }
    var description: String { get }
}

struct BaseMilestoneView<Destination: MilestoneView>: View {
    var milestoneView: Destination

    @State private var showingProjectDetails = false
    
    var body: some View {
        VStack {
            milestoneView
        }
        .navigationBarTitle(milestoneView.name, displayMode: .inline)
//        .navigationBarItems(trailing: Button(action: {
//            self.showingProjectDetails.toggle()
//        }){
//            Image(systemName: "info.circle")
//        })
        .alert(isPresented: self.$showingProjectDetails){
            Alert(title: Text(milestoneView.name), message: Text(milestoneView.description), dismissButton: .default(Text("Got it!")))
        }
    }
}
