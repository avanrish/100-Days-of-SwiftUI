//
//  ArrowShape.swift
//  Drawing
//
//  Created by Bartosz Lipiński on 19/04/2023.
//

import SwiftUI

struct ArrowShape: InsettableShape {
    var insetAmount = 0.0

    var animatableData: Double {
        get { insetAmount }
        set { insetAmount = newValue }
    }

    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.minX, y: rect.maxY * 0.4))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY * 0.4))
        path.closeSubpath()
        path.move(to: CGPoint(x: rect.midX, y: rect.maxY * 0.4))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.maxY))
        path.closeSubpath()

        return path
    }

    func inset(by amount: CGFloat) -> some InsettableShape {
        var arrow = self
        arrow.insetAmount += amount
        return arrow
    }
}
