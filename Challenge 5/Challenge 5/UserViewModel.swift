//
//  UserViewModel.swift
//  Challenge 5
//
//  Created by Bartosz Lipiński on 23/04/2023.
//

import Alamofire
import Foundation

class UserViewModel: ObservableObject {
    @Published var users: [User] = []

    func fetchUsers() async {
        if !users.isEmpty {
            return
        }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        AF.request("https://www.hackingwithswift.com/samples/friendface.json").responseDecodable(of: [User].self, decoder: decoder) { response in
            switch response.result {
            case .success(let users):
                self.users = users
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
