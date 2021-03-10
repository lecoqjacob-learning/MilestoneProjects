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

struct DescriptionView: View {
    var name: String
    var description: String

    init(_ name: String, _ description: String) {
        self.name = name
        self.description = description
    }

    var body: some View {
        VStack {
            Text(name).font(.system(size: 30)).bold().padding()
            Text(description).font(.system(size: 20)).padding()
        }
    }
}

struct BaseMilestoneView<Content: View>: View {
    let content: Content
    let name: String
    let description: String
    
    init(_ name: String, _ description: String, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.name = name
        self.description = description
    }
    
    var body: some View {
        TabView {
            self.content
            .tabItem {
                Label(name, systemImage: "apps.iphone")
            }

            DescriptionView(name, description)
                .tabItem {
                    Label("Project Description", systemImage: "apps.iphone")
                }
        }
    }
}
