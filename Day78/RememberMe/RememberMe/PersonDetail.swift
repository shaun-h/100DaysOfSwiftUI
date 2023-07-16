//
//  PersonDetail.swift
//  RememberMe
//
//  Created by Shaun Hevey on 15/7/2023.
//

import SwiftUI
import MapKit

struct PersonDetail: View {
    @State var person: Person
    @State var showing: Int
    @State var mapRegion: MKCoordinateRegion
    
    
    init(person: Person) {
        _person = State(initialValue: person)
        _showing = State(initialValue: 0)
        
        _mapRegion = State(initialValue: MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: person.location?.latitude ?? 50, longitude: person.location?.longitude ?? 0), span: MKCoordinateSpan(latitudeDelta: 25, longitudeDelta: 25)))
        
    }
    
    var body: some View {
        VStack {
            HStack {
                Text(person.name)
                    .font(.title)
                    .padding(.leading)
                Spacer()
                
            }
            if person.hasLocation() {
                Picker("What is your favorite color?", selection: $showing) {
                    Text("Image").tag(0)
                    Text("Map").tag(1)
                }
                .pickerStyle(.segmented)
                .padding(.bottom)
            }
            if showing == 0 {
                Image(uiImage:person.getImage())
                    .resizable()
                    .frame(width: 200, height: 200)
                    .scaledToFit()
            } else if showing == 1 {
                Map(coordinateRegion: $mapRegion, annotationItems: [person.location!]) { location in
                    MapAnnotation(coordinate: location.coordinate) {
                        VStack {
                            Image(systemName: "star.circle")
                                .resizable()
                                .foregroundColor(.red)
                                .frame(width: 44, height: 44)
                                .background(.white)
                                .clipShape(Circle())
                        }
                    }
                }

            }
            Spacer()
        }
        
    }
}

struct PersonDetail_Previews: PreviewProvider {
    static var previews: some View {
        PersonDetail(person: Person.example)
    }
}
