//
//  UserDetailView.swift
//  MilestoneProjects
//
//  Created by Jacob LeCoq on 2/28/21.
//

import MapKit
import SwiftUI

extension Color {
    static let offWhite = Color(red: 225 / 255, green: 225 / 255, blue: 235 / 255)
}

struct UserDetailView: View {
    @ObservedObject var vm: UserViewModel
    let user: UserModel

    let gradient = Gradient(colors: [.blue, .purple])

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var threeColumnGrid = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        VStack {
            HStack {
                Spacer()

                ScrollView(showsIndicators: false) {
                    VStack {
                        Text("\(user.age)")
                            .font(.system(size: 50))
                            .foregroundColor(.white)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .clipped()
                            .overlay(Circle().stroke(Color.white, lineWidth: 4))
                            .padding(.top, 44)
                            .shadow(color: Color.black.opacity(0.1), radius: 5, x: 8, y: 8)
                            .shadow(color: Color.white.opacity(0.5), radius: 5, x: -8, y: -8)

                        Text(user.name)
                            .font(.system(size: 20)).bold()
                            .foregroundColor(.white)
                            .padding(.top, 12)

                        Text(user.email)
                            .font(.system(size: 18))
                            .foregroundColor(.white)
                            .padding(.top, 4)

                        HStack {
                            Image(systemName: "map")
                            Text(user.getAddress())
                        }
                        .padding(.top, 4)
                        .foregroundColor(.white)

                        VStack {
                            Text("Tags")
                                .font(.system(size: 30))
                                .foregroundColor(.white)
                                .bold()

                            Rectangle()
                                .frame(height: 1)
                                .foregroundColor(.white)
                        }
                        .padding()

                        Section {
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(user.tags, id: \.self) { tag in
                                        Text(tag)
                                            .foregroundColor(Color.white)
                                            .padding(.horizontal, 15)
                                            .padding(.vertical, 5)
                                            .background(
                                                Capsule()
                                                    .fill(Color.red)
                                            )
                                            .padding(.vertical, 10)
                                    }
                                }
                            }
                        }

                        ZStack {
                            RoundedRectangle(cornerRadius: 25, style: .continuous)
                                .fill(Color.white)
                                .shadow(radius: 10)

                            VStack {
                                HStack {
                                    Text("About Me").font(.system(size: 20)).bold()
                                }
                                Text(user.about)
                                    .padding()
                                    .minimumScaleFactor(0.75)
                            }
                            .padding(10)
                            .multilineTextAlignment(.center)
                        }
                        .frame(height: 300)
                        .padding()

                        Text("Friends")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .bold()
                            .padding()

                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.white)
                            .padding(.leading, 16)
                            .padding(.trailing, 16)

                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(user.friends) { friend in
                                NavigationLink(destination: UserDetailView(vm: vm, user: vm.findUser(friend.id)!)) {
                                    Text(friend.name)
                                        .font(.system(size: 20))
                                        .foregroundColor(.white)
                                        .frame(width: 150, height: 150)
                                        .clipShape(Circle())
                                        .clipped()
                                        .multilineTextAlignment(.center)
                                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                                }
                            }
                        }
                        .padding()
                    }
                }
                Spacer()
            }
            Spacer()
        }
        .background(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
        .onAppear {
            print(user.friends)
        }
    }
}

struct UserDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            UserDetailView(vm: UserViewModel(), user: UserModel.example)
        }
    }
}
