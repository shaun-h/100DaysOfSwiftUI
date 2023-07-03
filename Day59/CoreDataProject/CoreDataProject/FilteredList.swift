//
//  FilteredList.swift
//  CoreDataProject
//
//  Created by Shaun Hevey on 3/7/2023.
//

import CoreData
import SwiftUI

enum FilterType: CaseIterable {
    case beginsWith, contains, endswith, like, matches
}

struct FilteredList<T: NSManagedObject, Content: View>: View {
    @FetchRequest var fetchRequest: FetchedResults<T>
    let content: (T) -> Content
    
    var body: some View {
        List(fetchRequest, id: \.self) { item in
            self.content(item)
        }
    }
    
    init(filterKey: String, filterValue: String, predicate: FilterType, sortOptions: [SortDescriptor<T>], @ViewBuilder content: @escaping (T) -> Content) {
        let predicateString = FilteredList<T, Content>.predicateString(type: predicate)
        _fetchRequest = FetchRequest<T>(sortDescriptors: sortOptions, predicate: NSPredicate(format: "%K &K %@", filterKey, predicateString, filterValue))
        self.content = content
    }
    
    static func predicateString(type: FilterType) -> String {
        switch type {
        case .contains:
            return "CONTAINS"
        case .beginsWith:
            return "BEGINS"
        case .endswith:
            return "ENDSWITH"
        case .like:
            return "LIKE"
        case .matches:
            return "MATCHES"
        }
    }
}
