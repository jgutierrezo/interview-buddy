//
//  Language+CoreDataProperties.swift
//  interview-buddy
//
//  Created by Rodrigo Chavez on 2022-12-07.
//

import Foundation
import CoreData


extension Language {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Language> {
        return NSFetchRequest<Language>(entityName: "Languages")
    }

    @NSManaged public var language: String?
    @NSManaged public var image: Data?
    @NSManaged public var searchKey: String?
    @NSManaged public var imageName: String?

}

extension Language : Identifiable {

}
