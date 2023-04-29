//
//  ContentView.swift
//  Challenge 6
//
//  Created by Bartosz Lipiński on 28/04/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var personViewModel = PersonViewModel()

    var body: some View {
        NavigationView {
            List(personViewModel.people) { person in
                NavigationLink {
                    AsyncImage(url: FileManager.documentsDirectory.appendingPathComponent("\(person.id).jpg")) { phase in
                        if let image = phase.image {
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                } label: {
                    HStack {
                        Text(person.name)
                        Spacer()
                        AsyncImage(url: FileManager.documentsDirectory.appendingPathComponent("\(person.id).jpg")) { phase in
                            if let image = phase.image {
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(height: 64)
                                    .clipShape(Circle())
                            }
                        }
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    plusButton
                }
            }
            .sheet(isPresented: $personViewModel.isImagePickerPresented) {
                ImagePicker(image: $personViewModel.personPhoto)
            }
            .onChange(of: personViewModel.personPhoto, perform: personViewModel.showNameInputAlert)
            .alert("Enter person's name", isPresented: $personViewModel.isNameInputAlertPresented) {
                TextField("Name", text: $personViewModel.personName)
                Button("Submit", action: personViewModel.savePerson)
            }
        }
    }

    var plusButton: some View {
        Button {
            personViewModel.isImagePickerPresented = true
        } label: {
            Image(systemName: "plus")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
