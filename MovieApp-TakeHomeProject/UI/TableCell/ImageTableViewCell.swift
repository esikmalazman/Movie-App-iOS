//
//  ImageTableViewCell.swift
//  MovieApp-TakeHomeProject
//
//  Created by Ikmal Azman on 16/05/2022.
//

import UIKit

class ImageTableViewCell: UITableViewCell {
    @IBOutlet weak var posterImage : UIImageView!
    
    static let identifier = "ImageTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "\(ImageTableViewCell.self)", bundle: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        selectionStyle = .none
    }
}
