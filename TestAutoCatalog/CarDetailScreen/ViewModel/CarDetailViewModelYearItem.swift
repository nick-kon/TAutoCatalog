//
//  CarDetailViewModelYearItem.swift
//  TestAutoCatalog
//
//  Created by nic on 07/06/2019.
//  Copyright © 2019 nic. All rights reserved.
//

import Foundation

class CarDetailViewModelYearItem: CarDetailViewModelItem {
    var type: CarDetailViewModelItemType {
        return .year
    }
    
    var title: String {
        return Constants.UI.CarDetailScreen.SectionTitles.year
    }
    
    var textValue: String
    
    var year: Date {
        didSet {
            textValue = year.getYearComponentAsString()
        }
    }
    
    init(year: Date) {
        self.textValue = year.getYearComponentAsString()
        self.year = year
    }
}
