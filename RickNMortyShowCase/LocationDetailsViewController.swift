//
//  LocationDetailsViewController.swift
//  RickNMortyShowCase
//
//  Created by Developer on 05/06/2018.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

class LocationDetailsViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var typeLbl: UILabel!
    @IBOutlet weak var dimensionLbl: UILabel!
    
    var location : Location!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.downloadedFrom(link: location.image)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        
        nameLbl.text = location.name
        nameLbl.layer.cornerRadius = 20
        
        typeLbl.text = location.type
        typeLbl.layer.cornerRadius = 20
        
        dimensionLbl.text = location.dimension
        dimensionLbl.layer.cornerRadius = 20
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
