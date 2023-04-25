//
//  EditView.swift
//  BucketList
//
//  Created by Bartosz Lipiński on 25/04/2023.
//

import SwiftUI

struct EditView: View {
    @StateObject var editViewModel: EditViewModel
    @Environment(\.dismiss) var dismiss

    var onSave: (Location) -> Void

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $editViewModel.name)
                    TextField("Description", text: $editViewModel.description)
                }

                Section("Nearby...") {
                    switch editViewModel.loadingState {
                    case .loading:
                        Text("Loading...")
                    case .loaded:
                        ForEach(editViewModel.pages, id: \.pageid) { page in
                            Text(page.title)
                                .font(.headline)
                                + Text(": ")
                                + Text(page.description)
                                .italic()
                        }
                    case .failed:
                        Text("Please try again later.")
                    }
                }
            }
            .navigationTitle("Place details")
            .toolbar {
                Button("Save") {
                    var newLocation = editViewModel.location
                    newLocation.id = UUID()
                    newLocation.name = editViewModel.name
                    newLocation.description = editViewModel.description

                    onSave(newLocation)
                    dismiss()
                }
            }
            .task {
                await editViewModel.fetchNearbyPlaces()
            }
        }
    }

    init(location: Location, onSave: @escaping (Location) -> Void) {
        _editViewModel = StateObject(wrappedValue: EditViewModel(location: location))
        self.onSave = onSave
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(location: Location.example) { _ in }
    }
}
