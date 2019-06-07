//
//  CarDetailViewModelNameModelItem.swift
//  TestAutoCatalog
//
//  Created by nic on 07/06/2019.
//  Copyright © 2019 nic. All rights reserved.
//

import Foundation

class CarDetailViewModelNameModelItem : CarDetailViewModelItem {
    var type: CarDetailViewModelItemType {
        return .modelName
    }
    
    var title: String {
        return Constants.UI.CarDetailScreen.SectionTitles.model
    }
    
    var modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }
}
