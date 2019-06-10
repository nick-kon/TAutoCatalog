//
//  UIViewControllerExtensions.swift
//  TestAutoCatalog
//
//  Created by nic on 10/06/2019.
//  Copyright © 2019 nic. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addRoundedCorners() {
        layer.cornerRadius = 10
    }
    
    func addShadow() {
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 4
    }
    
    func addDarkBlurEffect() {
        let blur = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = self.bounds
        addSubview(blurView)
        
    }
    
    func removeVisualEffect() {
        if let effectView = subviews.first(where: {$0 is UIVisualEffectView}) {
            effectView.removeFromSuperview()
        }
    }
}
