//
//  FavoritesTable+CoreDataProperties.swift
//  
//
//  Created by Jorge Espinoza on 17/02/23.
//
//

import Foundation
import CoreData


extension FavoritesTable {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoritesTable> {
        return NSFetchRequest<FavoritesTable>(entityName: "FavoritesTable")
    }

    @NSManaged public var id: Int64
    @NSManaged public var posterPath: String?
    @NSManaged public var title: String?
    @NSManaged public var overview: String?
    @NSManaged public var date: String?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var rate: Float

}

extension FavoritesTable: Identifiable {
    
}
