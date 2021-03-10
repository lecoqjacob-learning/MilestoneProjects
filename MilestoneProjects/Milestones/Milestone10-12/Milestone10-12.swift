//
//  Milestone10-12.swift
//  MilestoneProjects
//
//  Created by Jacob LeCoq on 2/28/21.
//

import CoreData
import SwiftUI

struct TestView: View {
    var name: String
    var description: String
    
    @Environment(\.managedObjectContext) private var moc
    @ObservedObject var userVM = UserViewModel()
    
    init(_ name: String, _ description: String) {
        self.name = name
        self.description = description
    }
    
    var body: some View {
        BaseMilestoneView (name, description){
            List {
                ForEach(userVM.users, id: \.id) { user in
                    NavigationLink(destination: UserDetailView(vm: userVM, user: user)) {
                        HStack {
                            Text(user.name + "-\(user.age)")
                        }
                    }
                }
            }
        }
        .navigationBarTitle("FriendFace", displayMode: .inline)
        .navigationBarItems(trailing:
            HStack {
                Button("DeleteAll") {
                    self.userVM.deleteUsers()
                }
                Button("Fetch") {
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
struct Milestone10_12: MilestoneView {
    /**
     Required Milestone attributes
     */
    var id = UUID()
    var name: String = "Milestone 10-12"
    var description: String = "Friends App. Show list of users and their friends"
    
    let persistenceController = PersistenceController.milestone10_12

    var body: some View {
        TestView(name, description)
            .environment(\.managedObjectContext, persistenceController.container.viewContext)
    }
}

struct Milestone10_12_Previews: PreviewProvider {
    static var previews: some View {
        let context = PersistenceController.milestone10_12.container.viewContext
        Milestone10_12().environment(\.managedObjectContext, context)
    }
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
