//
//  ActivityDetail.swift
//  MilestoneProjects
//
//  Created by Jacob LeCoq on 2/28/21.
//

import SwiftUI

struct ActivityDetail: View {
    @Binding var activity: Activity
    
    var body: some View {
        VStack {
            Text(self.activity.title)
                .font(.title)
                .foregroundColor(.black)
            
            Text(self.activity.description)
                .font(.title2)
                .foregroundColor(.secondary)
            
            Text("Completion Count: \(self.activity.completionCount)")
                .font(.title3)
            
            Spacer()
            
            Button("Add Completion"){
                self.activity.completionCount += 1
            }
            .foregroundColor(.purple)
                .font(.title)
                .padding()
                .border(Color.purple, width: 5)
        }
    }
}

struct ActivityDetail_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDetail(activity: .constant(Activity(title: "test title", description: "test desc")))
    }
}
