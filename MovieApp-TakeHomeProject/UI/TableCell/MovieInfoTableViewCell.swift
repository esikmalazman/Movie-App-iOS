//
//  MovieInfoTableViewCell.swift
//  MovieApp-TakeHomeProject
//
//  Created by Ikmal Azman on 16/05/2022.
//

import UIKit

class MovieInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var languageLabel: UIButton!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
    var data : MovieDetails?
    static let identifier = "MovieInfoTableViewCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "\(MovieInfoTableViewCell.self)", bundle: nil)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupButtonPadding()
        setupLanguageLabel()
        selectionStyle = .none
    }
}


private extension MovieInfoTableViewCell {
    func setupButtonPadding() {
        languageLabel.tintColor = .white
        let isLanguageEmpty = languageLabel.titleLabel?.text?.count ?? 0 < 1
        languageLabel.backgroundColor = isLanguageEmpty ? .white :.black
        languageLabel.contentEdgeInsets  = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        languageLabel.layer.cornerRadius = 8
    }
    
    func setupLanguageLabel() {
        languageLabel.tintColor = .white
        languageLabel.backgroundColor = AppTheme.darkishPink
    }
}

