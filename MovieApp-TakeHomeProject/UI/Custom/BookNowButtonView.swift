//
//  BookNowButtonView.swift
//  MovieApp-TakeHomeProject
//
//  Created by Ikmal Azman on 16/05/2022.
//

import UIKit

protocol BookNowButtonViewDelegate : AnyObject {
    func bookNowButtonView(_ view : BookNowButtonView, didTapBookButton : UIButton)
}

class BookNowButtonView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var bookNowButton: UIButton!
    
    static let nibName = "BookNowButtonView"
    weak var delegate : BookNowButtonViewDelegate?
    
    static func instantiate() -> BookNowButtonView {
        let view : BookNowButtonView = BookNowButtonView.initFromNib()
        return view
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        translatesAutoresizingMaskIntoConstraints = false
        bookNowButton.layer.cornerRadius = 8
    }
}

extension BookNowButtonView {
    @IBAction func didTapBookButton(_ sender: UIButton) {
        delegate?.bookNowButtonView(self, didTapBookButton: sender)
    }
}

