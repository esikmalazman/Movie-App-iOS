//
//  UIViewController + Extensions.swift
//  MovieApp-TakeHomeProject
//
//  Created by Ikmal Azman on 20/05/2022.
//

import Foundation
import UIKit

extension UIViewController {
    func showErrorAlert(_ error : APIError, completion : @escaping ()-> Void = {}) {
        let alert = UIAlertController(title: "Error",
                                      message: error.rawValue,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            completion()
        }
        alert.addAction(okAction)
        DispatchQueue.main.async { [weak self] in
            self?.present(alert, animated: true)
        }
    }
}
