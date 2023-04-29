//
//  ContentView.swift
//  Challenge 6
//
//  Created by Bartosz Lipiński on 28/04/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var personViewModel = PersonViewModel()
//    @State var isImagePickerPresented = false

    var body: some View {
        NavigationView {
            List(personViewModel.people) { person in
                NavigationLink {
                    if let image = FileManager.loadImageFromDocuments(fileName: "\(person.id).jpg") {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                } label: {
                    HStack {
                        Text(person.name)
                        Spacer()
                        if let image = FileManager.loadImageFromDocuments(fileName: "\(person.id).jpg") {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFit()
                                .frame(height: 64)
                                .clipShape(Circle())
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
