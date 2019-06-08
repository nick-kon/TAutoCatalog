//
//  UITextfieldExtensions.swift
//  TestAutoCatalog
//
//  Created by nic on 09/06/2019.
//  Copyright © 2019 nic. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func validateForIsEmpty() -> Bool {
        self.rightView = nil
        self.rightViewMode = .unlessEditing
        guard text != "" else {
            
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 20))
            imageView.image = UIImage(named: "warning")
            imageView.contentMode = .scaleAspectFit
            
            self.rightView = imageView
            
            return true
        }
        return false
    }
}
