//
//  Favorites.swift
//  SnowSeeker
//
//  Created by Shaun Hevey on 18/7/2023.
//

import Foundation

class Favorites: ObservableObject {
    private var resorts: Set<String>

    private let saveKey = "Favorites"
    
    let favouritesFilePath = FileManager.documentsDirectory().appendingPathComponent("Favourites.json")

    init() {
        do {
            let data = try Data(contentsOf: favouritesFilePath)
            resorts = try JSONDecoder().decode(Set<String>.self, from: data)
        } catch {
            resorts = []
        }
    }

    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }

    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }

    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }

    func save() {
        do {
            let data = try JSONEncoder().encode(resorts)
            try data.write(to: favouritesFilePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
}

