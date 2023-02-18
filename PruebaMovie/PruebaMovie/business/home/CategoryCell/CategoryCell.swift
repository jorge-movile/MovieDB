//
//  CategoryCell.swift
//  PruebaMovie
//
//  Created by Jorge Espinoza on 17/02/23.
//

import UIKit

class CategoryCell: UICollectionViewCell {
    
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var lbCategory: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        viewContainer.layer.cornerRadius = 8
        lbCategory.textColor = Colors.white
    }
    
    override var isSelected: Bool{
        didSet{
            if self.isSelected {
                viewContainer.backgroundColor = Colors.graySegmented
                
                lbCategory.font = UIFont(name: "Helvetica Neue Bold", size: 14)
            } else {
                viewContainer.backgroundColor = Colors.semiBlack
                
                lbCategory.font = UIFont(name: "Helvetica Neue", size: 14)
            }
        }
    }
}
