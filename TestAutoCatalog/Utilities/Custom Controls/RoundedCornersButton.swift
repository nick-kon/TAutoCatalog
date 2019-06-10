//
//  RoundedCornersButton.swift
//  TestAutoCatalog
//
//  Created by nic on 10/06/2019.
//  Copyright © 2019 nic. All rights reserved.
//

import Foundation
import UIKit

class RoundedCornersButton: UIButton {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5
        
    }
}

