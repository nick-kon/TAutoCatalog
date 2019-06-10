//
//  RoundButton.swift
//  TestAutoCatalog
//
//  Created by nic on 10/06/2019.
//  Copyright © 2019 nic. All rights reserved.
//

import Foundation
import UIKit

class RoundButton: UIButton {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = frame.height / 2
        layer.shadowOpacity = 0.35
        layer.shadowOffset = CGSize(width: 0, height: 10)
        layer.shadowRadius = 5
    }
}
