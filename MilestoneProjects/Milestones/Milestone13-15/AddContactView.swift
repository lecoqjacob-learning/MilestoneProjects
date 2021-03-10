//
//  AddContactView.swift
//  MilestoneProjects
//
//  Created by Jacob LeCoq on 3/3/21.
//

import Foundation
import SwiftUI

struct AddContactView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var persons: Persons

    @State private var name: String = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""

    @State private var showingImagePicker = false
    @State private var uiImage: UIImage?
    @State private var image: Image?

    @State private var imageSourceType: ImageSourceType = .library

    // monitor keyboard events to allow scrolling when it appears
    @ObservedObject private var keyboard = KeyboardResponder()
    
    let locationFetcher = LocationFetcher()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Photo")) {
                    if image != nil {
                        image?
                            .resizable()
                            .scaledToFit()
                    }
                    else {
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.gray, style: StrokeStyle(lineWidth: 1,
                                                                   lineCap: CGLineCap.round,
                                                                   dash: [5, 5]))
                            .scaledToFit()
                    }

                    HStack {
                        // two buttons in the same row would result in both being
                        // considered tapped when the row is tapped: use text instead
                        Text("Take new...")
                            .onTapGesture(perform: takePicture)

                        Spacer()

                        Text("Select existing...")
                            .onTapGesture(perform: selectPhoto)
                    }
                    .foregroundColor(Color.accentColor)
                }

                Section(header: Text("Name")) {
                    TextField("Name", text: $name)
                }
            }
            // add space for the keyboard
            .padding(.bottom, keyboard.currentHeight)
            .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
                ImagePicker(image: self.$uiImage, sourceType: self.imageSourceType)
            }
            .alert(isPresented: $showingAlert, content: {
                Alert(title: Text(alertMessage))
            })
            .navigationBarTitle(Text("Add contact"), displayMode: .inline)
            .navigationBarItems(trailing:
                Button(action: { self.addContact() },
                       label: { Text("Add").padding(15) })
            )
            .onAppear() {
                self.locationFetcher.start()
            }
        }
    }

    func loadImage() {
        guard let uiImage = self.uiImage else { return }
        self.image = Image(uiImage: uiImage)
    }

    func takePicture() {
        if ImagePicker.isCameraAvailable() {
            self.imageSourceType = .camera
            self.showingImagePicker = true
        }
        else {
            self.alertMessage = "Camera is not available"
            self.showingAlert = true
        }
    }

    func selectPhoto() {
        self.imageSourceType = .library
        self.showingImagePicker = true
    }

    func addContact() {
        guard !self.name.isEmpty, self.image != nil else {
            self.alertMessage = "Please provide name and photo"
            self.showingAlert = true
            return
        }

        var person = Person(name: self.name)

        if let uiImage = uiImage {
            if let jpegData = uiImage.jpegData(compressionQuality: 0.8) {
                person.setImage(image: jpegData)
            }
        }
        
        if let location = self.locationFetcher.lastKnownLocation {
            person.latitude = location.latitude
            person.longitude = location.longitude
            person.locationRecorded = true
        } else {
            person.locationRecorded = false
        }

        self.persons.add(person: person)
        self.presentationMode.wrappedValue.dismiss()
    }
}

struct AddContactView_Previews: PreviewProvider {
    static var previews: some View {
        AddContactView(persons: Persons())
    }
}
