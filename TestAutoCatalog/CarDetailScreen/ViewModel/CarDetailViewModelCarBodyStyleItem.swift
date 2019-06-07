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
    
    var carBodyStyle: String
    
    init(carBodyStyle: CarBodyStyle) {
        switch carBodyStyle {
        case .convertible:
            self.carBodyStyle = Constants.UI.CarDetailScreen.CarBodyStyle.convertible
        case .coupe:
            self.carBodyStyle = Constants.UI.CarDetailScreen.CarBodyStyle.coupe
        case .crossover:
            self.carBodyStyle = Constants.UI.CarDetailScreen.CarBodyStyle.crossover
        case .diesel:
            self.carBodyStyle = Constants.UI.CarDetailScreen.CarBodyStyle.diesel
        case .hybrid:
            self.carBodyStyle = Constants.UI.CarDetailScreen.CarBodyStyle.hybrid
        case .luxury:
            self.carBodyStyle = Constants.UI.CarDetailScreen.CarBodyStyle.luxury
        case .sedan:
            self.carBodyStyle = Constants.UI.CarDetailScreen.CarBodyStyle.sedan
        case .sport:
            self.carBodyStyle = Constants.UI.CarDetailScreen.CarBodyStyle.sport
        case .suv:
            self.carBodyStyle = Constants.UI.CarDetailScreen.CarBodyStyle.suv
        case .truck:
            self.carBodyStyle = Constants.UI.CarDetailScreen.CarBodyStyle.truck
        case .van:
            self.carBodyStyle = Constants.UI.CarDetailScreen.CarBodyStyle.van
        case .wagon:
            self.carBodyStyle = Constants.UI.CarDetailScreen.CarBodyStyle.wagon
        }
    }
}
