//
//  AddActivityView.swift
//  Challenge 4
//
//  Created by Bartosz Lipiński on 20/04/2023.
//

import SwiftUI

struct AddActivityView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var activityViewModel: ActivityViewModel
    @State private var activityName = ""
    @State private var activityDescription = ""

    var body: some View {
        Form {
            Section("Activity") {
                TextField("Name", text: $activityName)
                TextField("Description", text: $activityDescription, axis: .vertical)
            }
            Button("Add activity") {
                activityViewModel.activities.append(Activity(name: activityName, description: activityDescription, noOfCompletion: 0))
                resetForm()
            }
        }
    }

    func resetForm() {
        activityName = ""
        activityDescription = ""
        dismiss()
    }
}

struct AddActivityView_Previews: PreviewProvider {
    static var previews: some View {
        AddActivityView(activityViewModel: ActivityViewModel(isAddActivitySheetPresented: false))
    }
}
