//
//  PokemonTableViewCell.swift
//  PokedexLab
//
//  Created by Ali Mousa on 3/2/17.
//  Copyright © 2017 iOS Decal. All rights reserved.
//

import Foundation
import UIKit

class PokemonTableViewCell : UITableViewCell {
    
    @IBOutlet weak var pokemonImageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var stats: UILabel!
}
