//
//  FileManager-DocumentsDirectory.swift
//  HotProspects
//
//  Created by Shaun Hevey on 17/7/2023.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
