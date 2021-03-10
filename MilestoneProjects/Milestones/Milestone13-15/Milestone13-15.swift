//
//  Milestone13-15.swift
//  MilestoneProjects
//
//  Created by Jacob LeCoq on 3/2/21.
//

import SwiftUI

struct Milestone13_15: MilestoneView {
    /**
     View Requirements
      */
    var id = UUID()
    var name = "Milestone 13-15"
    var description = "Part 1: Build a Photo Library App"

    @ObservedObject var persons = Persons()
    @State var showingAddContact = false

    var body: some View {
        BaseMilestoneView(name, description) {
            if persons.all.count == 0 {
                VStack {
                    Text("No Added People").font(.system(size: 25))
                    Text("Click the + to add someone!")
                }
            } else {
                List {
                    ForEach(persons.all) { person in
                        NavigationLink(destination: PersonDetailView(person: person)) {
                            self.getImage(for: person)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 100, height: 100)
                                .clipped()
                                .cornerRadius(10)
                                // for placeholders
                                .foregroundColor(Color.gray)
                            Text(person.name)
                            if(person.locationRecorded){
                                Image(systemName: "map")
                            }
                        }
                    }
                    .onDelete { offsets in
                        var persons = [Person]()

                        for offset in offsets {
                            persons.append(self.persons.all[offset])
                        }

                        self.persons.remove(persons: persons)
                    }
                }
            }
        }
        .navigationBarTitle("Remembererer", displayMode: .inline)
        .navigationBarItems(trailing:
            Button(action: {
                self.showingAddContact.toggle()
            }) {
                Image(systemName: "plus")
            }
        )
        .sheet(isPresented: self.$showingAddContact) {
            AddContactView(persons: persons)
        }
    }

    private func getImage(for person: Person) -> Image {
        if let imageData = person.getImage() {
            if let uiImage = UIImage(data: imageData) {
                return Image(uiImage: uiImage)
            }
        }

        return Image(systemName: "person.crop.square")
    }
}

struct Milestone13_15_Previews: PreviewProvider {
    static var previews: some View {
        Milestone13_15()
    }
}
