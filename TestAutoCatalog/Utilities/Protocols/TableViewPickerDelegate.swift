//
//  TableViewPickerDelegate.swift
//  TestAutoCatalog
//
//  Created by nic on 08/06/2019.
//  Copyright © 2019 nic. All rights reserved.
//

import Foundation

protocol TableViewPickerDelegate: AnyObject {
    func didSelectEnumValue(_ value: StoredAsEnum)
    func cancelSelection()
}
