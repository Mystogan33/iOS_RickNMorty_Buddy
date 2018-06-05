//
//  CharacterDetailsViewController.swift
//  RickNMortyShowCase
//
//  Created by Developer on 05/06/2018.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var speciesLbl: UILabel!
    @IBOutlet weak var statusLbl: UILabel!
    @IBOutlet weak var genderLbl: UILabel!
    @IBOutlet weak var originLbl: UILabel!
    @IBOutlet weak var lastLocationLbl: UILabel!
    
    var character: ServerResponseCharacter!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.downloadedFrom(link: character.image)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        
        nameLbl.text = character.name
        nameLbl.layer.cornerRadius = 20
        
        speciesLbl.text = character.species
        speciesLbl.layer.cornerRadius = 20
        
        statusLbl.text = character.status
        genderLbl.layer.cornerRadius = 20
        
        genderLbl.text = character.gender
        genderLbl.layer.cornerRadius = 20
        
        originLbl.text = character.origin
        originLbl.layer.cornerRadius = 20
        
        lastLocationLbl.text = character.location
        lastLocationLbl.layer.cornerRadius = 20
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
