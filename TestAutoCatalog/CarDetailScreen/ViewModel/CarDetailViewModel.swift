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
        case endEditing(Int)
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
            case .endEditing(let index):
                state = .normal
                reloadRow?(index)
            case .adding:
                title.value = Constants.UI.CarDetailScreen.titleAdd
                rightBarButtonTitle.value = Constants.UI.save
            }
        }
    }
    
    var reloadRow: ((Int) -> Void)?
    
    var editingItemIndex: Int? {
        switch state {
        case .editing(let index):
            return index
        default:
            return nil
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
    
    func didSelectEnumValue(_ value: StoredAsEnum) {
        guard let index = editingItemIndex else { return }
        
        if let carClassItem = items[index] as? CarDetailViewModelCarClassItem {
            carClassItem.carAttributeEnumValue = value
        }
        
        if let carBodyStyleItem = items[index] as? CarDetailViewModelCarBodyStyleItem {
            carBodyStyleItem.carAttributeEnumValue = value
        }
        
        state = .endEditing(index)
    }
    
    func didSelectYear(_ year: Int) {

        guard let index = editingItemIndex else { return }
        guard let yearItem = items[index] as? CarDetailViewModelYearItem else { return }
        
        var dateComponents = DateComponents()
        dateComponents.year = year
        if dateComponents.isValidDate(in: Calendar.current) {
            yearItem.year = Calendar.current.date(from: dateComponents)!
            state = .endEditing(index)
        }
    }
    
    func didEnterText(_ text: String) {
        
        guard let index = editingItemIndex else { return }
        
        if let modelNameItem = items[index] as? CarDetailViewModelNameModelItem {
            modelNameItem.modelName = text
        }
        
        if let manufacturerItem = items[index] as? CarDetailViewModelManufacturerItem {
            manufacturerItem.manufacturer = text
        }

        state = .endEditing(index)
    }
    
}



