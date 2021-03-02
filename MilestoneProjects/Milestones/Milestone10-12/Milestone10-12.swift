//
//  Milestone10-12.swift
//  MilestoneProjects
//
//  Created by Jacob LeCoq on 2/28/21.
//

import CoreData
import SwiftUI

struct Milestone10_12: MilestoneView {
    /**
     Required Milestone attributes
     */
    var id = UUID()
    var name: String = "Milestone 10-12"
    var description: String = "Friends App. Show list of users and their friends"

    @Environment(\.managedObjectContext) private var moc
    @ObservedObject var userVM = UserViewModel()

    var body: some View {
        VStack {
            List {
                ForEach(userVM.users, id: \.id) { user in
                    NavigationLink(destination: UserDetailView(vm: userVM, user: user)) {
                        HStack {
                            Text(user.name + "-\(user.age)")
                        }
                    }
                }
            }
            .navigationTitle("User List")
        }
//        UserListView (vm: userVM){ user in
//            NavigationLink(destination: UserDetailView(vm: userVM, user: user)) {
//                VStack(alignment: .leading) {
//                    Text("\(user.name)")
//                        .font(.headline)
//
//                    Text("Age: \(user.age)")
//                        .font(.subheadline)
//                        .foregroundColor(.gray)
//                }
//            }
//        }
        .navigationBarTitle("FriendFace")
        .navigationBarItems(trailing:
            HStack {
                Button("DeleteAll") {
                    self.userVM.deleteUsers()
                }
                Button("Fetch") {
//                    self.fetch()
                    self.userVM.fetchUsers()
                }
            }
        )
        .onAppear {
            self.userVM.objectContext = self.moc
            self.userVM.loadUsers()
        }
    }
}

struct Milestone10_12_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.shared.container.viewContext
        Milestone10_12().environment(\.managedObjectContext, context)
    }
}
