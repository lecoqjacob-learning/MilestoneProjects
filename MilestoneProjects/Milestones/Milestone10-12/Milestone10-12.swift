//
//  Milestone10-12.swift
//  MilestoneProjects
//
//  Created by Jacob LeCoq on 2/28/21.
//

import SwiftUI

struct Milestone10_12: MilestoneView {
    /**
     Required Milestone attributes
     */
    var id = UUID()
    var name: String = "Milestone 10-12"
    var description: String = "Friends App. Show list of users and their friends"
    
    @ObservedObject var userVM: UserViewModel = UserViewModel()
    
    var body: some View {
        VStack{
            List {
                ForEach(userVM.users, id: \.id){ user in
                    NavigationLink(destination: UserDetailView(vm: userVM, user: user)) {
                        HStack{
                            Text(user.name + "-\(user.age)")
                        }
                    }
                }
            }
            .navigationTitle("User List")
        }
        .onAppear(){
            self.userVM.fetchUsers()
        }
    }
}

struct Milestone10_12_Previews: PreviewProvider {
    static var previews: some View {
        Milestone10_12()
    }
}
