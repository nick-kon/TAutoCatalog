//
//  CarDetailViewModelManufacturerItem.swift
//  TestAutoCatalog
//
//  Created by nic on 07/06/2019.
//  Copyright © 2019 nic. All rights reserved.
//

import Foundation

class CarDetailViewModelManufacturerItem: CarDetailViewModelItem {
    var type: CarDetailViewModelItemType {
        return .manufacturer
    }
    
    var title: String {
        return Constants.UI.CarDetailScreen.SectionTitles.manufacturer
    }
    
    var textValue: String
    
    var manufacturer: String
    init(manufacturer: String) {
        self.textValue = manufacturer
        self.manufacturer = manufacturer
    }
}
