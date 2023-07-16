//
//  Person.swift
//  RememberMe
//
//  Created by Shaun Hevey on 15/7/2023.
//

import Foundation
import UIKit
import CoreLocation
import MapKit

struct Person: Identifiable, Codable, Comparable {
    var id: UUID
    var name: String
    var location: PersonLocation?
    
    static func < (lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }
    
    func hasLocation() -> Bool {
        return location != nil
    }
    
    func getImage() -> UIImage {
        let filePath = FileManager.documentsDirectory.appendingPathComponent("\(id).jpg")
        do {
            let data = try Data(contentsOf: filePath)
            return UIImage(data: data)!
        } catch {
            return UIImage(systemName: "person.crop.circle")!
        }
    }
    
    static var example = Person(id: UUID(), name: "Test Person", location: nil)
}

struct PersonLocation: Identifiable, Codable, Comparable {
    var id: UUID = UUID()
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static func < (lhs: PersonLocation, rhs: PersonLocation) -> Bool {
        lhs.latitude < rhs.latitude
    }
}

