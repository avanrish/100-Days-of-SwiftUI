//
//  UserDetailsView.swift
//  Challenge 5
//
//  Created by Bartosz Lipiński on 23/04/2023.
//

import SwiftUI

struct UserDetailsView: View {
    let user: User

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                Text("Registered: \(user.registered.formatted(.dateTime.day().month().year()))")
                Text("Company: \(user.name)")
                Text("Age: \(user.age)")
                Text("Email: \(user.email)")
                Text("About: \(user.about)")
                    .padding(.vertical)
                
                Text("Friends:")
                    .font(.headline)
                ForEach(user.friends) { friend in
                    Text(friend.name)
                }
            }
            .padding()
        }
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

// struct UserDetailsView_Previews: PreviewProvider {
//    static var previews: some View {
//        UserDetailsView()
//    }
// }
