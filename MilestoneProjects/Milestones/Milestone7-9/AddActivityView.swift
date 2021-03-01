//
//  AddActivityView.swift
//  MilestoneProjects
//
//  Created by Jacob LeCoq on 2/28/21.
//

import SwiftUI

struct NavigationConfigurator: UIViewControllerRepresentable {
    var configure: (UINavigationController) -> Void = { _ in }

    func makeUIViewController(context: UIViewControllerRepresentableContext<NavigationConfigurator>) -> UIViewController {
        UIViewController()
    }

    func updateUIViewController(_ uiViewController: UIViewController, context: UIViewControllerRepresentableContext<NavigationConfigurator>) {
        if let nc = uiViewController.navigationController {
            configure(nc)
        }
    }
}

struct AddActivityView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var container: ActivityContainer

    @State private var title: String = ""
    @State private var description: String = ""

    init(_ container: ActivityContainer) {
        self.container = container

        // Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.blue]
    }

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $title)
                TextField("Description", text: $description)
                    .keyboardType(.numberPad)
            }
            .navigationBarTitle("Add new Activity", displayMode: .inline)
            .navigationBarHidden(false)
            .navigationBarItems(trailing: Button("Save") {
                guard !isFormEmpty() else { return }

                let item = Activity(title: title, description: description)
                self.container.activities.append(item)
                self.presentationMode.wrappedValue.dismiss()
            }.disabled(isFormEmpty()))
        }
    }

    private func isFormEmpty() -> Bool {
        return title.isEmpty || description.isEmpty
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityView(ActivityContainer())
    }
}
