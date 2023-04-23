//
//  ContentView.swift
//  Challenge 5
//
//  Created by Bartosz Lipiński on 23/04/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var userViewModel = UserViewModel()

    var body: some View {
        NavigationView {
            List(userViewModel.users) { user in
                NavigationLink {
                    UserDetailsView(user: user)
                } label: {
                    HStack {
                        Text(user.name)
                        Spacer()
                        Text(user.isActive ? "Online" : "Offline")
                            .foregroundColor(user.isActive ? .green : .gray)
                    }
                }
            }
            .navigationTitle("Users")
            .task {
                await userViewModel.fetchUsers()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
