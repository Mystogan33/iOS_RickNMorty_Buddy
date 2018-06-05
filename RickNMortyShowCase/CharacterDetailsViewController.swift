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

        nameLbl.text = character.name
        speciesLbl.text = character.species
        statusLbl.text = character.status
        genderLbl.text = character.gender
        originLbl.text = character.origin
        lastLocationLbl.text = character.location
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
