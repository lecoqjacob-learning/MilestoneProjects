//
//  Milestone7-9.swift
//  MilestoneProjects
//
//  Created by Jacob LeCoq on 2/28/21.
//

import SwiftUI

struct IndexedCollection<Base: RandomAccessCollection>: RandomAccessCollection {
    typealias Index = Base.Index
    typealias Element = (index: Index, element: Base.Element)

    let base: Base

    var startIndex: Index { base.startIndex }
    var endIndex: Index { base.endIndex }

    func index(after i: Index) -> Index {
        base.index(after: i)
    }

    func index(before i: Index) -> Index {
        base.index(before: i)
    }

    func index(_ i: Index, offsetBy distance: Int) -> Index {
        base.index(i, offsetBy: distance)
    }

    subscript(position: Index) -> Element {
        (index: position, element: base[position])
    }
}

extension RandomAccessCollection {
    func indexed() -> IndexedCollection<Self> {
        IndexedCollection(base: self)
    }
}

struct Milestone7_9: MilestoneView {
    /**
     Required Milestone attributes
     */
    var id = UUID()
    var name: String = "Milestone 7-9"
    var description: String = "Build a activity tracker"

    /**
        Activity Tracker Start Code
     */
    @State private var showingAddActivity = false
    @ObservedObject var container = ActivityContainer()

    var body: some View {
        BaseMilestoneView(name, description) {
            List {
                ForEach(container.activities.indexed(), id: \.1.id) { index, activity in
                    NavigationLink(destination: ActivityDetail(activity: $container.activities[index])){
                        HStack {
                            Text(activity.title)

                            Spacer()
                            Text("Completions: \(activity.completionCount)")
                        }
                    }
                }
                .onDelete(perform: removeItems)
            }
        }
        .navigationBarTitle("Activity Tracker")
        .navigationBarItems(trailing:
            Button(action: {
                self.showingAddActivity.toggle()
            }) {
                Image(systemName: "plus")
            }
        )
        .sheet(isPresented: $showingAddActivity) {
            AddActivityView(self.container)
        }
    }
    
    private func removeItems(at offsets: IndexSet) {
        container.activities.remove(atOffsets: offsets)
    }
}

struct Milestone7_9_Previews: PreviewProvider {
    static var previews: some View {
        Milestone7_9()
    }
}
