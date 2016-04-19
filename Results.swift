//
//  Results.swift
//  InformationFilms
//
//  Created by Gabriel de Sousa Borges on 2/26/16.
//  Copyright © 2016 Gabriel de Sousa Borges. All rights reserved.
//

import UIKit
import CoreData

class Results: UIViewController, UITableViewDataSource, UITableViewDelegate {
        
    @IBOutlet weak var tableView: UITableView!

    var Movies = [NSManagedObject]()
    let appDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext //Objeto que armazena informacoes
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        
        //Acesso a tabela no core data
        let fetchRequest = NSFetchRequest(entityName: "ModelMovie")
        
        //Tratamento de erro com do cath
        do {
            let results = try appDelegate.executeFetchRequest(fetchRequest)
            Movies = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
        
        saveMovie(GlobalMovies.titleMovie, yearSave: GlobalMovies.yearMovie, directorSave: GlobalMovies.directorMovie, genereSave: GlobalMovies.genereMovie, plotSave: GlobalMovies.plotMovie, ratedSave: GlobalMovies.ratedMovie, posterSave: GlobalMovies.posterMovie, imdbIDSave: GlobalMovies.imdbIDMovie)
        
        tableView.reloadData()
        
    }
    
    //MARK: - Metodos da tableView
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Movies.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("CellMovie", forIndexPath: indexPath) as! MovieCell
        
        let movie = Movies[indexPath.row]
        cell.nameLabel.text = movie.valueForKey("title") as? String
        cell.yearLabel.text = movie.valueForKey("year") as? String
        cell.ratedLabel.text = movie.valueForKey("rated") as? String

        return cell
    }
    
    //Opcao para poder deletar minha celula
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        //Verifico se o estado para poder deletar
        if editingStyle == .Delete {
            Movies.removeAtIndex(indexPath.row)
            deleteObjects()
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
        
    }
    
    //Funcao que deleta os objetos do meu Core Data (criei esta funcao)
    func deleteObjects() {
        
        let appDel = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        let coord = appDel.persistentStoreCoordinator
        
        let fet = NSFetchRequest(entityName: "ModelMovie")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fet) //responsavel por deletar as coisas no meu core data
        
        do {
            try coord!.executeRequest(deleteRequest, withContext: appDel)
        } catch let error as NSError {
            debugPrint(error)
        }
        
    }
    
    //Salva a minha tarefa no banco (criei esta funcao)
    func saveMovie(titleSave: String, yearSave: String, directorSave: String, genereSave: String, plotSave: String, ratedSave: String, posterSave: String, imdbIDSave: String) {
        
        let appDelegateSave = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
        
        let entity =  NSEntityDescription.entityForName("ModelMovie", inManagedObjectContext: appDelegateSave)
        
        let context = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: appDelegateSave)
        
        context.setValue(titleSave, forKey: "title")
        context.setValue(yearSave, forKey: "year")
        context.setValue(directorSave, forKey: "director")
        context.setValue(genereSave, forKey: "genere")
        context.setValue(plotSave, forKey: "plot")
        context.setValue(ratedSave, forKey: "rated")
        context.setValue(posterSave, forKey: "poster")
        context.setValue(imdbIDSave, forKey: "imdbID")
        
        do {
            try appDelegateSave.save()
            Movies.append(context)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
}
