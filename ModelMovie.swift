//
//  CoreDataInformation.swift
//  InformationFilms
//
//  Created by Gabriel de Sousa Borges on 2/28/16.
//  Copyright © 2016 Gabriel de Sousa Borges. All rights reserved.
//

import CoreData

@objc(ModelMovie)

class ModelMovie: NSManagedObject {

    @NSManaged var title: String
    @NSManaged var year: String
    @NSManaged var director: String
    @NSManaged var genere: String
    @NSManaged var rated: String
    @NSManaged var poster: String
    @NSManaged var plot: String
    @NSManaged var imdbID: String
    
}
