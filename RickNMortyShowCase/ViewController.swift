//
//  ViewController.swift
//  RickNMortyShowCase
//
//  Created by Developer on 04/06/2018.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

fileprivate struct RawServerResponseCharacter: Decodable {
    
    struct OriginCharacter: Decodable {
        var name: String
    }
    
    struct LocationCharacter: Decodable {
        var name: String
    }
    
    var name: String
    var status: String
    var species: String
    var gender: String
    var image: String
    
    var origin: OriginCharacter
    var location: LocationCharacter
}

struct ServerResponseCharacter: Decodable {
    let name: String
    let status: String
    let species: String
    let gender: String
    let image: String
    
    let origin: String
    let location: String
    
    init(from decoder: Decoder) throws {
        let rawResponse = try RawServerResponseCharacter(from: decoder)
        
        // Now you can pick items that are important to your data model,
        // conveniently decoded into a Swift structure
        name = String(rawResponse.name)
        status = String(rawResponse.status)
        species = String(rawResponse.species)
        gender = String(rawResponse.gender)
        image = String(rawResponse.image)
        
        
        origin = String(rawResponse.origin.name)
        location = String(rawResponse.location.name)
    }
}

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var characters = [ServerResponseCharacter]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let url = URL(string: "https://api.jsonbin.io/b/5b15304cc2e3344ccd96cc4d")
        URLSession.shared.dataTask(with: url!) {(data, response, error) in
            
            if error == nil {
                
                do {
                    self.characters = try JSONDecoder().decode([ServerResponseCharacter].self, from: data!)
                } catch {
                    print("Parse Error")
                }
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
            
        }.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customPersonnagesCell", for: indexPath) as! CustomCollectionViewCell
        
        cell.nameLbl.text = characters[indexPath.row].name.capitalized
        
        let completelink = characters[indexPath.row].image
        
        cell.layer.cornerRadius = 12
        
        cell.imageView.downloadedFrom(link: completelink)
        cell.imageView.clipsToBounds = true
        cell.imageView.layer.cornerRadius = 54
        cell.imageView.contentMode = .scaleAspectFill
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetailsCharacter", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailsCharacter" {
            let destinationViewController = segue.destination as! CharacterDetailsViewController
            destinationViewController.character = characters[sender as! Int]
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

