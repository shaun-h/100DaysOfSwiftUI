//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Shaun Hevey on 3/7/2023.
//

import SwiftUI

struct Student: Hashable {
    let name: String
    
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc

    @FetchRequest(sortDescriptors: []) var wizards: FetchedResults<Wizard>

    let students = [Student(name: "Harry Potter"), Student(name: "Hermione Granger")]

    var body: some View {
        VStack {
            List(wizards, id: \.self) { wizard in
                Text(wizard.name ?? "Unknown")
            }

            Button("Add") {
                let wizard = Wizard(context: moc)
                wizard.name = "Harry Potter"
            }

            Button("Save") {
                do {
                    if moc.hasChanges {
                        try moc.save()
                    }
                } catch {
                    print(error.localizedDescription)
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
