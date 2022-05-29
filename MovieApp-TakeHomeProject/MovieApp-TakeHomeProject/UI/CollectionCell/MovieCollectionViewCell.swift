//
//  MovieCollectionViewCell.swift
//  MovieApp-TakeHomeProject
//
//  Created by Ikmal Azman on 15/05/2022.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet var customContentView : UIView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet weak var popularityLabel: UILabel!
    
    static let identifier = "MovieCollectionViewCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    static func nib()-> UINib {
        return UINib(nibName: "\(MovieCollectionViewCell.self)", bundle: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        customContentView.layer.cornerRadius = 8
        contentView.layer.cornerRadius = 8
        posterImageView.layer.cornerRadius = 8
    }
}
