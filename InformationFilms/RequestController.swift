//
//  ViewController.swift
//  InformationFilms
//
//  Created by Gabriel de Sousa Borges on 2/18/16.
//  Copyright © 2016 Gabriel de Sousa Borges. All rights reserved.
//

import Foundation
import UIKit

class RequestController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, searchResultsProtocol {
    
    var omdbAPI = SearchOnline()
    var tableData = []
    var rowData = NSDictionary()
    var passPoster = String()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var button: UIButton!
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        //Delegates da API e da Search Bar
        textField.delegate = self
        omdbAPI.delegate = self
        self.navigationController?.navigationBar.tintColor = UIColor.redColor()
        
    }
    
    //Verifico a quantidade de caractesres para encontrar alguma coisa
    @IBAction func addSearch() {
        
        if textField.text?.isEmpty == true {
            
            let alert = UIAlertController(title: "Ops!", message: "Write name the Movie", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
        
        if textField.text?.characters.count >= 2 {
            starActivy()
            omdbAPI.searchInAPI(textField.text!)
            let delay = 1.5 * Double(NSEC_PER_SEC)
            let time = dispatch_time(DISPATCH_TIME_NOW, Int64(delay))
            dispatch_after(time, dispatch_get_main_queue()) {
                self.stopActivy()
            }
        }
        
        textField.text = ""
        textField.resignFirstResponder()
        
    }
    
    func starActivy() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
    }
    
    func stopActivy() {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = false
    }
    
    //Implemento o metodo do delegate
    func didReceiveSearchResults(results: NSArray) {
        tableData = results
        
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
        })
    
    }
    
    //MARK: - Metodos da tableView
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        
        //Elas vao assumir esses valores para passar para as celulas
        rowData = tableData[indexPath.row] as! NSDictionary
        let movieName = rowData["Title"] as! String
        cell.textLabel!.text = NSLocalizedString(movieName, comment: "Title")
        
        let movieYear = rowData["Year"] as! String
        cell.detailTextLabel!.text = NSLocalizedString(movieYear, comment: "Year")
        
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let path = tableView.indexPathForSelectedRow
        let cell = tableView.cellForRowAtIndexPath(path!)
        
        if segue.identifier == "segue" {
            let destination: DescriptionMovie = segue.destinationViewController as! DescriptionMovie
            
            //Usa esse cara so para passar o id para minha variavel id
            let vetInfo = tableData[(path?.row)!] as! NSDictionary
            destination.id = vetInfo["imdbID"] as! String

            destination.cellPoster = vetInfo["Poster"] as! String
            destination.cellTitle = (cell?.textLabel?.text)!
            destination.cellDetailYear = (cell?.detailTextLabel?.text)!
            
        }
        
    }
    
}

