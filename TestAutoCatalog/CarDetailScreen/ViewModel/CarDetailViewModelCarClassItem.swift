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
    
    var carClassName: String
    
    init(carClass: CarClass) {
        switch carClass {
        case .a:
            carClassName = Constants.UI.CarDetailScreen.CarClasses.a
        case .b:
            carClassName = Constants.UI.CarDetailScreen.CarClasses.b
        case .c:
            carClassName = Constants.UI.CarDetailScreen.CarClasses.c
        case .d:
            carClassName = Constants.UI.CarDetailScreen.CarClasses.d
        case .e:
            carClassName = Constants.UI.CarDetailScreen.CarClasses.e
        case .f:
            carClassName = Constants.UI.CarDetailScreen.CarClasses.f
        case .j:
            carClassName = Constants.UI.CarDetailScreen.CarClasses.j
        case .m:
            carClassName = Constants.UI.CarDetailScreen.CarClasses.m
        case .s:
            carClassName = Constants.UI.CarDetailScreen.CarClasses.s
        }
        
        textValue = carClassName
    }
}
