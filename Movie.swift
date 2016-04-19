//
//  Movie.swift
//  InformationFilms
//
//  Created by Gabriel de Sousa Borges on 2/19/16.
//  Copyright © 2016 Gabriel de Sousa Borges. All rights reserved.
//

import Foundation
import CoreData

class Movie {
    
    var title: String
    var year: String
    var rated: String
    var genere: String
    var director: String
    var plot: String
    var poster: String
    var imdbID: String
    
    init (json: NSDictionary) {
        
        //Alimento o meu json com as chaves que contem as informaçoes
        title = json["Title"] as! String
        year = json["Year"] as! String
        rated = json["Rated"] as! String
        genere = json["Genre"] as! String
        director = json["Director"] as! String
        plot = json["Plot"] as! String
        imdbID = json["imdbID"] as! String
        poster = json["Poster"] as! String
        
        //Alimento minhas variaveis globais com as informaçoes do filme
        GlobalMovies.titleMovie = title
        GlobalMovies.yearMovie = year
        GlobalMovies.ratedMovie = rated
        GlobalMovies.genereMovie = genere
        GlobalMovies.directorMovie = director
        GlobalMovies.plotMovie = plot
        GlobalMovies.posterMovie = poster
        GlobalMovies.imdbIDMovie = imdbID
        
    }
}
 