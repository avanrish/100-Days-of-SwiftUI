//
//  ContentView.swift
//  Moonshot
//
//  Created by Bartosz Lipiński on 18/04/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var showingGrid = true
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")

    var body: some View {
        NavigationView {
            ScrollView {
                Group {
                    if showingGrid {
                        GridView(astronauts: astronauts, missions: missions)
                    } else {
                        ListView(astronauts: astronauts, missions: missions)
                    }
                }
                .padding([.horizontal, .bottom])
            }
            .navigationTitle("Moonshot")
            .background(.darkBackground)
            .preferredColorScheme(.dark)
            .toolbar {
                ToolbarItem {
                    Button(showingGrid ? "List" : "Grid") {
                        showingGrid.toggle()
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
