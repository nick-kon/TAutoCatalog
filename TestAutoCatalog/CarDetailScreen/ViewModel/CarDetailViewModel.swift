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
        case modified
    }
    
    var isAddingCar = false
    
    var state: State {
        didSet {
            switch state {
            case .normal:
                title.value = Constants.UI.CarDetailScreen.titleDetail
            case .editing:
                title.value = isAddingCar ? Constants.UI.CarDetailScreen.titleAdd : Constants.UI.CarDetailScreen.titleEdit
                rightBarButtonEnabled.value = false
            case .endEditing(let index):
                state = .modified
                rightBarButtonTitle.value = isAddingCar ? Constants.UI.add : Constants.UI.done
                rightBarButtonEnabled.value = true
                reloadRow?(index)
            case .modified:
                let _ : Int = 0
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
    
    private var initialCar: CarModel?
    
    init(car: CarModel) {
        
        initialCar = car
        
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
    var rightBarButtonEnabled: Box<Bool> = Box(false)
    
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
    
    func composeCarModel() -> Result<CarModel, CarModelError> {

            for item in items {
                switch item.type {
                case .carClass:
                    let carClassItem = item as! CarDetailViewModelCarClassItem
                    initialCar?.carClass = carClassItem.carAttributeEnumValue as! CarClass
                case .carType:
                    let carBodyStyleItem = item as! CarDetailViewModelCarBodyStyleItem
                    initialCar?.bodyStyle = carBodyStyleItem.carAttributeEnumValue as! CarBodyStyle
                case .manufacturer:
                    let manufacturerItem = item as! CarDetailViewModelManufacturerItem
                    guard manufacturerItem.isValid() else {return .failure(CarModelError.emptyManufacturer) }
                    initialCar?.manufacturer = manufacturerItem.manufacturer
                case .modelName:
                    let modelNameItem = item as! CarDetailViewModelNameModelItem
                    guard modelNameItem.isValid() else { return .failure(CarModelError.emptyName)}
                    initialCar?.modelName = modelNameItem.modelName
                case .year:
                    let yearItem = item as! CarDetailViewModelYearItem
                    initialCar?.year = yearItem.year
                }
            }
        
        return .success(initialCar!)
  
    }
}



