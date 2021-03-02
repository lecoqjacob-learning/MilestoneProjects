//
//  UserListView.swift
//  MilestoneProjects
//
//  Created by Jacob LeCoq on 3/1/21.
//

import CoreData
import SwiftUI

struct UserListView<Content: View>: View {
//    var fetchRequest: FetchRequest<CDUser>
    let content: (UserModel) -> Content
    var results: [UserModel] { userVM.users }
    
    @ObservedObject var userVM: UserViewModel

    var body: some View {
        List(results, id: \.id) {
            self.content($0)
        }
    }

    init(vm: UserViewModel, @ViewBuilder content: @escaping (UserModel) -> Content) {
        self.userVM = vm
        self.content = content
    }
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView(vm: UserViewModel()){ (user: UserModel) in
            Text("\(user.name)")
        }
    }
}
