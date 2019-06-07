//
//  CarDetailViewModelItem.swift
//  TestAutoCatalog
//
//  Created by nic on 07/06/2019.
//  Copyright © 2019 nic. All rights reserved.
//

import Foundation

protocol CarDetailViewModelItem {
    var type: CarDetailViewModelItemType { get }
    var numberOfRows: Int { get }
    var title: String { get }
    var textValue: String { get }
}

extension CarDetailViewModelItem {
    var numberOfRows: Int {
        return 1
    }
}
