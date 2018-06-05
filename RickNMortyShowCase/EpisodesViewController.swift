//
//  EpisodesViewController.swift
//  RickNMortyShowCase
//
//  Created by Developer on 04/06/2018.
//  Copyright © 2018 Developer. All rights reserved.
//

import UIKit

extension UIImageView {
    func downloadedFrom(url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloadedFrom(link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloadedFrom(url: url, contentMode: mode)
    }
}

struct Episode: Decodable {
    
    let name: String
    let air_date: String
    let episode: String
    let image: String
    
}

class EpisodesViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    var episodes = [Episode]()
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        let url = URL(string: "https://api.jsonbin.io/b/5b156b39c2e3344ccd96cc6f")
        
        URLSession.shared.dataTask(with: url!) {(data, response, error) in
            
            if error == nil {
                
                do {
                    self.episodes = try JSONDecoder().decode([Episode].self, from: data!)
                } catch {
                    print("Parse Error")
                }
                DispatchQueue.main.async {
                    print(self.episodes.count)
                    self.collectionView.reloadData()
                }
            }
            
            }.resume()
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "customEpisodesCell", for: indexPath) as! CustomEpisodesCollectionViewCell
        
        cell.nameLbl.text = episodes[indexPath.row].name.capitalized
        cell.seasonLbl.text = episodes[indexPath.row].episode.capitalized
        
        cell.layer.cornerRadius = 20
        
        let completelink = episodes[indexPath.row].image
        
        cell.imageView.downloadedFrom(link: completelink)
        cell.imageView.clipsToBounds = true
        cell.imageView.contentMode = .scaleAspectFill
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showDetailsEpisode", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailsEpisode" {
            let destinationViewController = segue.destination as! EpisodeDetailsViewController
            destinationViewController.episode = episodes[sender as! Int]
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
