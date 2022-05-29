//
//  SynopsisTableViewCell.swift
//  MovieApp-TakeHomeProject
//
//  Created by Ikmal Azman on 16/05/2022.
//

import UIKit

class SynopsisTableViewCell: UITableViewCell {
    
    @IBOutlet weak var synopsisTitle: UILabel!
    @IBOutlet weak var synopsisDescription : UILabel!
    
    static let identifier = "SynopsisTableViewCel"
    
    static func nib() -> UINib {
        return UINib(nibName: "\(SynopsisTableViewCell.self)", bundle: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        selectionStyle = .none
        
        if synopsisDescription.text?.count ?? 0 < 1 {
            synopsisTitle.isHidden = true
        }
    }
}
