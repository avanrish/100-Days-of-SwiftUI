//
//  PersonViewModel.swift
//  Challenge 6
//
//  Created by Bartosz Lipiński on 29/04/2023.
//

import SwiftUI

class PersonViewModel: ObservableObject {
    @Published var personPhoto: UIImage?
    @Published var personName = ""
    @Published var isImagePickerPresented = false
    @Published var isNameInputAlertPresented = false
    @Published var people: [Person] = []

    let savePath = FileManager.documentsDirectory

    func showNameInputAlert(_ image: UIImage?) {
        if image != nil {
            isNameInputAlertPresented = true
        }
    }

    func savePerson() {
        if personName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return
        }
        guard let personPhoto = personPhoto else { return }
        if let jpegData = personPhoto.jpegData(compressionQuality: 0.8) {
            let uuid = UUID()
            let person = Person(id: uuid, name: personName)
            do {
                let fileName = savePath.appendingPathComponent("\(uuid).jpg")
                try jpegData.write(to: fileName, options: [.atomic])
                people.append(person)
            }
            catch {
                print(error.localizedDescription)
            }
        }
        personName = ""
    }
    
}
