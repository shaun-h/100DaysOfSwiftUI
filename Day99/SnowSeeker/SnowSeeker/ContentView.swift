//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Shaun Hevey on 18/7/2023.
//

import SwiftUI

extension View {
    @ViewBuilder func phoneOnlyStackNavigationView() -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.navigationViewStyle(.stack)
        } else {
            self
        }
    }
}

struct ContentView: View {
    enum ResortsSortingKeys: CaseIterable {
        case Default, Alphabetical, Country
    }
    
    
    let resorts: [Resort] = Bundle.main.decode("resorts.json")
    @State private var searchText = ""
    @State private var sortKey: ResortsSortingKeys = .Default
    @StateObject var favorites = Favorites()
    
    var filteredResorts: [Resort] {
        var sorted = resorts
        
        if sortKey != .Default {
            sorted = resorts.sorted {
                if sortKey == .Alphabetical {
                    return $0.name < $1.name
                }
                
                return $0.country < $1.country
            }
        }
        if searchText.isEmpty {
            return sorted
        } else {
            return sorted.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("Sort By", selection: $sortKey) {
                    ForEach(ResortsSortingKeys.allCases, id:\.self) { option in
                        Text(String(describing: option))
                    }
                }
                .pickerStyle(.segmented)
                .padding(.horizontal)
                
                List(filteredResorts) { resort in
                    NavigationLink {
                        ResortView(resort: resort)
                    } label: {
                        HStack {
                            Image(resort.country)
                                .resizable()
                                .scaledToFill()
                                .frame(width: 40, height: 25)
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 5)
                                )
                                .overlay(
                                    RoundedRectangle(cornerRadius: 5)
                                        .stroke(.black, lineWidth: 1)
                                )
                            
                            VStack(alignment: .leading) {
                                Text(resort.name)
                                    .font(.headline)
                                Text("\(resort.runs) runs")
                                    .foregroundColor(.secondary)
                            }
                            
                            if favorites.contains(resort) {
                                Spacer()
                                Image(systemName: "heart.fill")
                                    .accessibilityLabel("This is a favorite resort")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
                .navigationTitle("Resorts")
                .searchable(text: $searchText, prompt: "Search for a resort")
            }
            WelcomeView()
        }
        .environmentObject(favorites)
        //.phoneOnlyStackNavigationView()
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
