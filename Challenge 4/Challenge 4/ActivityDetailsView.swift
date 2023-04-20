//
//  ActivityDetailsView.swift
//  Challenge 4
//
//  Created by Bartosz Lipiński on 20/04/2023.
//

import SwiftUI

struct ActivityDetailsView: View {
    var activity: Activity
    @ObservedObject var activityViewModel: ActivityViewModel

    var body: some View {
        LazyVStack(alignment: .leading) {
            Text(activity.name)
                .font(.largeTitle)
            Text(activity.description)
            Text("You have completed it \(activity.noOfCompletion) \(activity.noOfCompletion == 1 ? "time" : "times").")
                .padding(.vertical)
            Button("Increase count") {
                activityViewModel.addActivityCompletion(activity: activity)
            }
        }
        .padding(.horizontal, 25)
        .frame(maxHeight: .infinity, alignment: .topLeading)
    }
}

struct ActivityDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDetailsView(activity: Activity(name: "test", description: "test", noOfCompletion: 0), activityViewModel: ActivityViewModel(isAddActivitySheetPresented: false))
    }
}
