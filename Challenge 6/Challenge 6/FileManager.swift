//
//  FileManager.swift
//  Challenge 6
//
//  Created by Bartosz Lipiński on 29/04/2023.
//

import SwiftUI

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
