//
//  EditViewModel.swift
//  BucketList
//
//  Created by Bartosz Lipiński on 25/04/2023.
//

import Alamofire
import Foundation

class EditViewModel: ObservableObject {
    enum LoadingState {
        case loading
        case loaded
        case failed
    }

    var location: Location

    @Published var name: String
    @Published var description: String

    @Published var loadingState = LoadingState.loading
    @Published var pages: [Page] = []

    init(location: Location) {
        self.location = location
        _name = Published(initialValue: location.name)
        _description = Published(initialValue: location.description)
    }

    func fetchNearbyPlaces() async {
        let urlString = "https://en.wikipedia.org/w/api.php?ggscoord=\(location.coordinate.latitude)%7C\(location.coordinate.longitude)&action=query&prop=coordinates%7Cpageimages%7Cpageterms&colimit=50&piprop=thumbnail&pithumbsize=500&pilimit=50&wbptterms=description&generator=geosearch&ggsradius=10000&ggslimit=50&format=json"

        guard let url = URL(string: urlString) else {
            print("Bad URL: \(urlString)")
            loadingState = .failed
            return
        }

        let decoder = JSONDecoder()
        AF.request(url).responseDecodable(of: Result.self, decoder: decoder) { response in
            switch response.result {
            case .success(let items):
                self.pages = items.query.pages.values.sorted()
                self.loadingState = .loaded
            case .failure(let error):
                print(error.localizedDescription)
                self.loadingState = .failed
            }
        }
    }
}
