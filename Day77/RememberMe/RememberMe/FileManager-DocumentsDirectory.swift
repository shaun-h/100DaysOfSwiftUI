//
//  FileManager-DocumentsDirectory.swift
//  RememberMe
//
//  Created by Shaun Hevey on 15/7/2023.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
