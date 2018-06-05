//
//  LocationsViewController.swift
//  RickNMortyShowCase
//
//  Created by Developer on 04/06/2018.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit


struct Location: Decodable {
    
    let name: String
    let type: String
    let dimension: String
    let image: String
    
}

class LocationsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    
    var locations = [Location]()
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        collectionView.dataSource = self
        collectionView.delegate = self
        
        let url = URL(string: "https://api.jsonbin.io/b/5b155b877a973f4ce578525a")
        
        URLSession.shared.dataTask(with: url!) {(data, response, error) in
            
            if error == nil {
                
                do {
                    self.locations = try JSONDecoder().decode([Location].self, from: data!)
                } catch {
                    print("Parse Error")
                }
                DispatchQueue.main.async {
                    print(self.locations.count)
                    self.collectionView.reloadData()
                }
            }
            
            }.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return locations.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customLocationsCell", for: indexPath) as! CustomLocationsCollectionViewCell
        
        cell.layer.cornerRadius = 20
        
        cell.nameLbl.text = locations[indexPath.row].name.capitalized
        cell.typeLbl.text = locations[indexPath.row].type.capitalized
        cell.dimensionLbl.text = locations[indexPath.row].dimension.capitalized
        
        let completelink = locations[indexPath.row].image
        
        cell.imageView.downloadedFrom(link: completelink)
        cell.imageView.clipsToBounds = true
        cell.imageView.contentMode = .scaleAspectFill
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetailsLocation", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailsLocation" {
            let destinationViewController = segue.destination as! LocationDetailsViewController
            destinationViewController.location = locations[sender as! Int]
        }
    }

}
