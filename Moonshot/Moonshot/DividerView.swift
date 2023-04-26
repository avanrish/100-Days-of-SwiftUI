//
//  DividerView.swift
//  Moonshot
//
//  Created by Bartosz Lipiński on 18/04/2023.
//

import SwiftUI

struct DividerView: View {
    var body: some View {
        Rectangle()
            .frame(height: 2)
            .foregroundColor(.lightBackground)
            .padding(.vertical)
            .accessibilityHidden(true)
    }
}

struct DividerView_Previews: PreviewProvider {
    static var previews: some View {
        DividerView()
    }
}
