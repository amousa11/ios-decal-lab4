//
//  CategoryViewController.swift
//  PokedexLab
//
//  Created by SAMEER SURESH on 2/25/17.
//  Copyright © 2017 iOS Decal. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var pokemonArray: [Pokemon]?
    var cachedImages: [Int:UIImage] = [:]
    var selectedIndexPath: IndexPath?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table?.delegate = self
        table?.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pokemonArray!.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination as! PokemonInfoViewController
        if let ind = (selectedIndexPath?.item){
            if let pok = pokemonArray?[ind]{
                dest.pokemon = pok
            }
            if let img = cachedImages[ind]{
            dest.image = img
            }
        }
        
        
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pokemonTableCell", for: indexPath) as! PokemonTableViewCell
        if let image = cachedImages[indexPath.row] {
            cell.pokemonImageView.image = image // may need to change this!
        } else {
            let url = URL(string: (pokemonArray?[indexPath.item].imageUrl)!)!
            let session = URLSession(configuration: .default)
            let downloadPicTask = session.dataTask(with: url) { (data, response, error) in
                if let e = error {
                    print("Error downloading picture: \(e)")
                } else {
                    if let _ = response as? HTTPURLResponse {
                        if let imageData = data {
                            let image = UIImage(data: imageData)
                            self.cachedImages[indexPath.row] = image
                            cell.pokemonImageView.image = UIImage(data: imageData) // may need to change this!
                            
                        } else {
                            print("Couldn't get image: Image is nil")
                        }
                    } else {
                        print("Couldn't get response code")
                    }
                }
            }
            downloadPicTask.resume()
        }
        
        cell.name.text = pokemonArray?[indexPath.item].name
        cell.number.text = "#" + String(describing: (pokemonArray?[indexPath.item]
            .number)!)
        let attk = pokemonArray?[indexPath.item].attack
        let defense = pokemonArray?[indexPath.item].defense
        let health = pokemonArray?[indexPath.item].health
        cell.stats.text = String(describing: attk!) + "/" + String(describing: defense!) + "/" + String(describing: health!)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndexPath = indexPath
        performSegue(withIdentifier: "toPokemon", sender: self)
    }
    
    @IBOutlet weak var table: UITableView!
}
