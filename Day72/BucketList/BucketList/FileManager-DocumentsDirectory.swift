//
//  FileManager-DocumentsDirectory.swift
//  BucketList
//
//  Created by Shaun Hevey on 13/7/2023.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
