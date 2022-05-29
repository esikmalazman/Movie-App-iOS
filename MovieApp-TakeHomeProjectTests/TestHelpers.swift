//
//  TestHelpers.swift
//  MovieApp-TakeHomeProjectTests
//
//  Created by Ikmal Azman on 20/05/2022.
//

import UIKit

func tap(_ button : UIBarButtonItem) {
    _ = button.target?.perform(button.action, with: nil)
}
