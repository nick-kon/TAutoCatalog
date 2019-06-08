//
//  CarDetailViewModel.swift
//  TestAutoCatalog
//
//  Created by nic on 07/06/2019.
//  Copyright © 2019 nic. All rights reserved.
//
import Foundation

enum CarDetailViewModelItemType {
    case modelName
    case year
    case manufacturer
    case carClass
    case carType
}
class CarDetailViewModel {
    
    enum State {
        case normal
        case editing(Int)
        case adding
    }
    
    var state: State {
        didSet {
            switch state {
            case .normal:
                title.value = Constants.UI.CarDetailScreen.titleDetail
                rightBarButtonTitle.value = Constants.UI.edit
            case .editing:
                title.value = Constants.UI.CarDetailScreen.titleEdit
                rightBarButtonTitle.value = Constants.UI.done
            case .adding:
                title.value = Constants.UI.CarDetailScreen.titleAdd
                rightBarButtonTitle.value = Constants.UI.save
            }
        }
    }
    
    var items = [CarDetailViewModelItem]()
    
    init(car: CarModel) {
        
        let modelItem = CarDetailViewModelNameModelItem(modelName: car.modelName)
        items.append(modelItem)
        
        let yearItem = CarDetailViewModelYearItem(year: car.year)
        items.append(yearItem)
        
        let manufacturerItem = CarDetailViewModelManufacturerItem(manufacturer: car.manufacturer)
        items.append(manufacturerItem)
        
        let carClassItem = CarDetailViewModelCarClassItem(carClass: car.carClass)
        items.append(carClassItem)
        
        let carTypeItem = CarDetailViewModelCarBodyStyleItem(carBodyStyle: car.bodyStyle)
        items.append(carTypeItem)
        
        state = .normal
    }
    
    
    var title: Box<String> = Box("")
    var rightBarButtonTitle: Box<String> = Box("")
    
}



