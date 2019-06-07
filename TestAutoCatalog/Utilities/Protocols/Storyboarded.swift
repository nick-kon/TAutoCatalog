//
//  Storyboarded.swift
//  TestAutoCatalog
//
//  Created by nic on 07/06/2019.
//  Copyright © 2019 nic. All rights reserved.
//

import Foundation
import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    static func instantiate() -> Self {
        
        let storyboard = UIStoryboard(name: String(describing: self), bundle: Bundle.main)
        return storyboard.instantiateInitialViewController() as! Self
    }
}
