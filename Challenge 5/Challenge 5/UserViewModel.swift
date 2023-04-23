//
//  UserViewModel.swift
//  Challenge 5
//
//  Created by Bartosz Lipiński on 23/04/2023.
//

import Alamofire
import Foundation

@MainActor
class UserViewModel: ObservableObject {
    @Published var users: [User] = []

    func fetchUsers() async {
        if !users.isEmpty {
            return
        }
        AF.request("https://www.hackingwithswift.com/samples/friendface.json").response { response in
            if let data = response.data {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .iso8601
                do {
                    let decodedData = try decoder.decode([User].self, from: data)
                    self.users = decodedData
                }
                catch {
                    print("There has been an error while decoding data")
                }
            }
        }
    }
}
