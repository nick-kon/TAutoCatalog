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
    
    var textValue: String
    
    var modelName: String {
        didSet {
            textValue = modelName
        }
    }
    
    init(modelName: String) {
        
        self.textValue = modelName
        self.modelName = modelName
    }
    
    func isValid() -> Bool {
        
        return textValue.count > 0 ? true : false

    }
}
