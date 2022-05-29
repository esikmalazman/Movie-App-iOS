//
//  UIView + Extensions.swift
//  MovieApp-TakeHomeProject
//
//  Created by Ikmal Azman on 16/05/2022.
//

import Foundation
import UIKit

var spinnerView : UIView?

extension UIView {
    /// Allow to load view from XIB
    class func initFromNib<T: UIView>() -> T {
        return Bundle.main.loadNibNamed(String(describing: self), owner: nil, options: nil)?[0] as! T
    }
    
    func addSpinner() {
        spinnerView = UIView(frame: self.bounds)
        guard let spinnerView = spinnerView else {
            return
        }
        spinnerView.backgroundColor = .gray.withAlphaComponent(0.5)
        
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.center = self.center
        activityIndicator.startAnimating()
        spinnerView.addSubview(activityIndicator)
        addSubview(spinnerView)
        
    }
    
    func removeSpinner() {
        spinnerView?.removeFromSuperview()
    }
}
