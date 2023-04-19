//
//  ContentView.swift
//  Drawing
//
//  Created by Bartosz Lipiński on 19/04/2023.
//

import SwiftUI

// var animatableData = {
//    get { insetAmount }
//    set { insetAmount = newValue }
// }

struct ColorCyclingCircle: View {
    var amount = 0.0
    var steps = 100

    var body: some View {
        ZStack {
            ForEach(0 ..< steps, id: \.self) { value in
                Rectangle()
                    .inset(by: Double(value))
                    .strokeBorder(
                        LinearGradient(
                            gradient: Gradient(colors: [
                                color(for: value, brightness: 1),
                                color(for: value, brightness: 0.5)
                            ]),
                            startPoint: .top,
                            endPoint: .bottom
                        ),
                        lineWidth: 2
                    )
            }
        }
        .drawingGroup()
    }

    func color(for value: Int, brightness: Double) -> Color {
        var targetHue = Double(value) / Double(steps) + amount

        if targetHue > 1 {
            targetHue -= 1
        }

        return Color(hue: targetHue, saturation: 1, brightness: brightness)
    }
}

struct ContentView: View {
    @State private var arrowLineWidth = 5.0
    @State private var colorCycle = 0.0

    var body: some View {
        VStack {
            ArrowShape()
                .strokeBorder(.blue, lineWidth: arrowLineWidth)
                .frame(width: 100, height: 200)

            Button("Random thickness") {
                withAnimation {
                    arrowLineWidth = Double(Int.random(in: 5 ... 15))
                }
            }
            ColorCyclingCircle(amount: colorCycle)
                .frame(width: 300, height: 300)

            Slider(value: $colorCycle)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
