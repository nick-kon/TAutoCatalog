//
//  CarDetailViewModelCarTypeItem.swift
//  TestAutoCatalog
//
//  Created by nic on 07/06/2019.
//  Copyright © 2019 nic. All rights reserved.
//

import Foundation

class CarDetailViewModelCarBodyStyleItem: CarDetailViewModelItem {
    var type: CarDetailViewModelItemType {
        return .carType
    }
    
    var title: String {
        return Constants.UI.CarDetailScreen.SectionTitles.carType
    }
    
    var textValue: String = ""
    
    var carAttributeEnumValue: StoredAsEnum {
        didSet {
            textValue = carAttributeEnumValue.toString()
        }
    }
    
    init(carBodyStyle: CarBodyStyle) {

        textValue = carBodyStyle.toString()
        self.carAttributeEnumValue = carBodyStyle
    }
}
