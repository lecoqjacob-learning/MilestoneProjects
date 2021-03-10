//
//  PersonDetailView.swift
//  MilestoneProjects
//
//  Created by Jacob LeCoq on 3/3/21.
//

import MapKit
import SwiftUI

struct PersonDetailView: View {
    @State var pickerTab = 0
    var person: Person

    var body: some View {
        Picker("", selection: $pickerTab) {
            Text("Photo").tag(0)
            Text("Event location").tag(1)
        }
        .pickerStyle(SegmentedPickerStyle())
        .padding()

        if pickerTab == 0 {
            getImage(for: person)
                .resizable()
                .scaledToFit()
                // for placeholders
                .foregroundColor(Color.gray)
                .tag("Photo")
        } else {
            if (person.locationRecorded){
                MapView(annotation: getAnnotation())
            } else {
                Text("Location was not recorded")
                    .padding()
            }
        }
        
        Spacer()
    }

    private func getImage(for person: Person) -> Image {
        if let imageData = person.getImage() {
            if let uiImage = UIImage(data: imageData) {
                return Image(uiImage: uiImage)
            }
        }

        return Image(systemName: "person.crop.square")
    }
    
    private func getAnnotation() -> MKPointAnnotation {
        let annotation = MKPointAnnotation()
        
        annotation.title = "Discovered \(person.name)"
        annotation.coordinate = CLLocationCoordinate2D(latitude: person.latitude, longitude: person.longitude)
        
        return annotation
    }
}

struct PersonDetailView_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetailView(person: Person(id: UUID(), name: ""))
    }
}
