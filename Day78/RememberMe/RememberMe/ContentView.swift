//
//  ContentView.swift
//  RememberMe
//
//  Created by Shaun Hevey on 15/7/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    var body: some View {
        NavigationView {
            List(viewModel.people.sorted()) { person in
                HStack {
                    NavigationLink {
                        PersonDetail(person: person)
                    } label: {
                        Image(uiImage:person.getImage())
                            .resizable()
                            .scaledToFill()
                            .frame(width: 45, height: 45)
                            .clipShape(Circle())
                        Text(person.name)
                    }
                }
            }
            .navigationTitle("Remember Me")
            .toolbar {
                Button() {
                    viewModel.showAddUserSheet = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showAddUserSheet) {
                ImagePicker(image: $viewModel.newPersonImage)
            }
            .onChange(of: viewModel.newPersonImage) { _ in
                viewModel.askForName = true
            }
            .alert("Enter name", isPresented: $viewModel.askForName) {
                TextField("Name", text: $viewModel.newName)
                Button("Save", action: {
                    viewModel.addNewPerson()
                } )
            } message: {
                Text("Please enter the persons name")
            }

        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
