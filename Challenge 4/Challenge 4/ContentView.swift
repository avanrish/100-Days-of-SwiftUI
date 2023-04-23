//
//  ContentView.swift
//  Challenge 4
//
//  Created by Bartosz Lipiński on 20/04/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var activityViewModel = ActivityViewModel(isAddActivitySheetPresented: false)

    var body: some View {
        NavigationView {
            List {
                ForEach(activityViewModel.activities) { activity in
                    NavigationLink {
                        ActivityDetailsView(activity: activity, activityViewModel: activityViewModel)
                    } label: {
                        Text(activity.name)
                    }
                }
            }
            .navigationTitle("Habit Tracker")
            .toolbar {
                Button {
                    activityViewModel.isAddActivitySheetPresented = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $activityViewModel.isAddActivitySheetPresented) {
                AddActivityView(activityViewModel: activityViewModel)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
