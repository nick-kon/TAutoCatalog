//
//  UITableViewCellExtensions.swift
//  TestAutoCatalog
//
//  Created by nic on 07/06/2019.
//  Copyright © 2019 nic. All rights reserved.
//

import Foundation
import UIKit
extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}
