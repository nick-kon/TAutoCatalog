//
//  CarDetailViewModelCarClassItem.swift
//  TestAutoCatalog
//
//  Created by nic on 07/06/2019.
//  Copyright © 2019 nic. All rights reserved.
//

import Foundation

class CarDetailViewModelCarClassItem: CarDetailViewModelItem {
    var type: CarDetailViewModelItemType {
        return .carClass
    }
    
    var title: String {
        return Constants.UI.CarDetailScreen.SectionTitles.carClass
    }
    
    var textValue: String
    
    var carClass: CarClass
    
    init(carClass: CarClass) {
        
        textValue = carClass.toString()
        self.carClass = carClass
    }
}
