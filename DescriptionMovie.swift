//
//  DescriptionMovie.swift
//  InformationFilms
//
//  Created by Gabriel de Sousa Borges on 2/18/16.
//  Copyright © 2016 Gabriel de Sousa Borges. All rights reserved.
//

import UIKit

class DescriptionMovie: UIViewController {
   
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var directorLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    @IBOutlet weak var ratedLabel: UILabel!
    @IBOutlet weak var plotLabel: UILabel!

    //Algumas informaçoes que pego da minha celula
    var id = ""
    var cellTitle = ""
    var cellDetailYear = ""
    var cellPoster = ""
    var searchById = SearchOnline()
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        scroll.contentInset = UIEdgeInsetsMake(0, 0, 400, 300)
        searchById.advancedSearchById(id)
        getInfoMovies()
        self.navigationItem.title = cellTitle
        
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        scrollSettings()
    }
    
    func scrollSettings() {
        scroll.frame = self.view.bounds
        scroll.contentSize.height = 300
        scroll.contentSize.width = 300
    }
    
    //Coloco nessa funcao as informacoes que eu pego
    func getInfoMovies() {
        
        titleLabel.text = cellTitle
        yearLabel.text = cellDetailYear
        genreLabel.text = GlobalMovies.genereMovie
        directorLabel.text = GlobalMovies.directorMovie
        ratedLabel.text = GlobalMovies.ratedMovie
        
        //Caso ele receba uma strig N/A ele recebe uma imagem de poster nao encontrado
        if cellPoster == "N/A" {
            posterView.image = UIImage(named: "notFound.png")
        } else {
            posterView.image = UIImage(data: NSData(contentsOfURL: NSURL(string: cellPoster)!)!)
        }
      
        //Faço uma quebra de linha para o meu Plot
        plotLabel.lineBreakMode = NSLineBreakMode.ByCharWrapping
        plotLabel.numberOfLines = 5
        plotLabel.text = GlobalMovies.plotMovie
        
    }
    
  
    
}