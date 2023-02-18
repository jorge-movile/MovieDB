//
//  MovieCell.swift
//  PruebaMovie
//
//  Created by Jorge Espinoza on 16/02/23.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    weak var delegate: FavoriteDelegate?
    
    @IBOutlet weak var viewInformation: UIView!
    @IBOutlet weak var imageMovie: UIImageView!
    @IBOutlet weak var lbTitleMovie: UILabel!
    @IBOutlet weak var lbDateMovie: UILabel!
    @IBOutlet weak var lbRateMovie: UILabel!
    @IBOutlet weak var btnFavorite: UIButton!
    @IBOutlet weak var lbDescriptionMovie: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageMovie.layer.cornerRadius = 20
        
        viewInformation.layer.cornerRadius = 25
        viewInformation.backgroundColor = Colors.blackMovies
        
        lbTitleMovie.textColor = Colors.greenItemMovies
        lbDateMovie.textColor = Colors.greenItemMovies
        lbRateMovie.textColor = Colors.greenItemMovies
        lbDescriptionMovie.textColor = Colors.white
    }
    
    @IBAction func setFavoriteMovie(_ sender: Any) {
        delegate?.setFavorite(cell: self)
    }
    
}
