//
//  Omdb.swift
//  InformationFilms
//
//  Created by Gabriel de Sousa Borges on 2/18/16.
//  Copyright © 2016 Gabriel de Sousa Borges. All rights reserved.
//

import UIKit

//protocolo para onde passo o resultado da pesquisa
protocol searchResultsProtocol {
    func didReceiveSearchResults(results: NSArray)
}

class SearchOnline: NSObject {
    
    var delegate: searchResultsProtocol?
    var editionKey = String()
    var jsonObj = [String: AnyObject]()
    
    //Aqui faço a pesquisa pelo nome do filme
    func searchInAPI(key: String) {
        
        let baseURL = NSURL(string: "http://www.omdbapi.com")
        
        editionKey = key.stringByReplacingOccurrencesOfString(" ", withString: "+", options: NSStringCompareOptions.CaseInsensitiveSearch, range: nil)
        
        let url = NSURL(string: "?s=?" + "\(editionKey)" + "&r-json", relativeToURL: baseURL)
        let request = NSURLRequest(URL: url!)
        let sessionURL = NSURLSession.sharedSession()
        let jsonResults = sessionURL.dataTaskWithRequest(request, completionHandler: {(data, response, error) in
            
            if error != nil {
                print(error?.localizedDescription)
            }
            
            do {
                self.jsonObj = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as! [String : AnyObject]
                
                if let results: NSArray = self.jsonObj["Search"] as? NSArray {
                    self.delegate?.didReceiveSearchResults(results)
                }
                
            } catch let error as NSError {
                print("json error: \(error.localizedDescription)")
            }
            
        })
        
        jsonResults.resume()
        
    }
    
    //Aqui faço pelo id do filme, uso na DescriptionMovie para recuperar dados necessarios
    func advancedSearchById(id: String) {
        
        var searchQuery="?i=\(id)"
        searchQuery += "&r=json"
        
        let encodedSearchQuery = searchQuery.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())
        advancedSearchByQuery(encodedSearchQuery!)
        
    }
    
    func advancedSearchByQuery(query:String) {
        
        let baseUrl = NSURL(string: "http://www.omdbapi.com")!
        let url = NSURL(string: query, relativeToURL:baseUrl)!
        let request = NSMutableURLRequest(URL: url)
        let urlSession = NSURLSession.sharedSession()
        let task = urlSession.dataTaskWithRequest(request, completionHandler: {(data, response, error) -> Void in
            
            if error != nil {
                print(error!.localizedDescription)
            }
            
            do {
                let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers) as? NSDictionary
                let movie = Movie(json: jsonResult!)
                var movieResults = [Movie]()
                movieResults.append(movie)
            }
            catch {
                print("Could not convert result to json dictionary")
            }
            
        })
        
        task.resume()
        
    }
    
}

