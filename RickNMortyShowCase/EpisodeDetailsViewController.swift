//
//  EpisodeDetailsViewController.swift
//  RickNMortyShowCase
//
//  Created by Developer on 05/06/2018.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

class EpisodeDetailsViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var seasonLbl: UILabel!
    @IBOutlet weak var airDateLbl: UILabel!
    
    var episode: Episode!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.downloadedFrom(link: episode.image)
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        
        nameLbl.text = episode.name
        nameLbl.layer.cornerRadius = 20
        
        seasonLbl.text = episode.episode
        seasonLbl.layer.cornerRadius = 20
        
        airDateLbl.text = episode.air_date
        airDateLbl.layer.cornerRadius = 20
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
