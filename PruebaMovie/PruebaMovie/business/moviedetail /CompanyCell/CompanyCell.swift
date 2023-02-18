//
//  CompanyCell.swift
//  PruebaMovie
//
//  Created by Jorge Espinoza on 16/02/23.
//

import UIKit

class CompanyCell: UICollectionViewCell {
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var imageCompany: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        viewContainer.layer.cornerRadius = viewContainer.frame.size.width / 2
        viewContainer.backgroundColor = Colors.greenItemMovies
        
        imageCompany.layer.cornerRadius = imageCompany.frame.size.width / 2
    }

}
