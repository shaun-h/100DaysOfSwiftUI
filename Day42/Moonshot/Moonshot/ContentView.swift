//
//  ContentView.swift
//  Moonshot
//
//  Created by Shaun Hevey on 26/6/2023.
//

import SwiftUI


struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var showGrid: Bool = true
    
    var body: some View {
        NavigationView {
            if showGrid {
                GridMissionView(missions: missions, astronauts: astronauts)
                    .navigationTitle("Moonshot")
                    .background(.darkBackground)
                    .preferredColorScheme(.dark)
                    .toolbar {
                        Button("List") {
                            showGrid.toggle()
                        }
                    }
            } else {
                ListMissionView(missions: missions, astronauts: astronauts)
                    .navigationTitle("Moonshot")
                    .background(.darkBackground)
                    .preferredColorScheme(.dark)
                    .toolbar {
                        Button("Grid") {
                            showGrid.toggle()
                        }
                    }
            }
            
        }
    }
}

struct ListMissionView: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    
    var body: some View {
        List {
            ForEach(missions) { mission in
                NavigationLink {
                    MissionView(mission: mission, astronauts: astronauts)
                } label: {
                    HStack {
                        Image(mission.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 75, height: 75)
                            .padding(.leading)
                        
                        VStack {
                            Text(mission.displayName)
                                .font(.headline)
                                .foregroundColor(.white)
                            Text(mission.formattedLaunchDate)
                                .font(.caption)
                                .foregroundColor(.white.opacity(0.5))
                        }
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(.lightBackground)
                            
                    )
                    
                }
                .listRowSeparator(.hidden)
            }
            .listRowBackground(Color.darkBackground)
        }
        .scrollContentBackground(.hidden)
    }
}

struct GridMissionView: View {
    let missions: [Mission]
    let astronauts: [String: Astronaut]
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns) {
                ForEach(missions) { mission in
                    NavigationLink {
                        MissionView(mission: mission, astronauts: astronauts)
                    } label: {
                        VStack {
                            Image(mission.image)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding()

                            VStack {
                                Text(mission.displayName)
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text(mission.formattedLaunchDate)
                                    .font(.caption)
                                    .foregroundColor(.white.opacity(0.5))
                            }
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background(.lightBackground)
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.lightBackground)
                        )
                    
                    }
                }
            }
            .padding([.horizontal, .bottom])
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
