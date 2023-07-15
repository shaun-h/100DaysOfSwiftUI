//
//  ContentView+ViewModel.swift
//  RememberMe
//
//  Created by Shaun Hevey on 15/7/2023.
//

import Foundation
import SwiftUI

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var people: [Person]
        @Published var showAddUserSheet: Bool = false
        @Published var askForName: Bool = false
        @Published var newPersonImage: UIImage?
        @Published var newName: String = ""
        
        let peopleFilePath = FileManager.documentsDirectory.appendingPathComponent("People.json")
        
        init() {
            do {
                let data = try Data(contentsOf: peopleFilePath)
                people = try JSONDecoder().decode([Person].self, from: data)
            } catch {
                people = []
            }
        }
        
        func addNewPerson() {
            guard let image = newPersonImage else { return }
            
            let id = UUID()
            let person = Person(id: id, name: newName)
            
            let filePath = FileManager.documentsDirectory.appendingPathComponent("\(id).jpg")
            if let jpegData = image.jpegData(compressionQuality: 0.8) {
                try? jpegData.write(to: filePath, options: [.atomic, .completeFileProtection])
            }
            
            people.append(person)
            newName = ""
            save()
        }
        
        func getPersonImage(person: Person) -> UIImage {
            let filePath = FileManager.documentsDirectory.appendingPathComponent("\(person.id).jpg")
            do {
                let data = try Data(contentsOf: filePath)
                return UIImage(data: data)!
            } catch {
                return UIImage(systemName: "person.crop.circle")!
            }
        }
                
        func save() {
            do {
                let data = try JSONEncoder().encode(people)
                try data.write(to: peopleFilePath, options: [.atomic, .completeFileProtection])
            } catch {
                print("Unable to save data.")
            }
        }
    }
}
