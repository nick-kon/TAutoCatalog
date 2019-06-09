//
//  CarsListViewModel.swift
//  TestAutoCatalog
//
//  Created by nic on 07/06/2019.
//  Copyright © 2019 nic. All rights reserved.
//

import Foundation



struct CarViewModel {
    let modelName: String
    let year: Date
    
    init(with car: CarModel) {
        modelName = car.modelName
        year = car.year
    }
    
}

class CarsListViewModel {
    
    private var _currentCars: LinkedList<CarViewModel>
    
    enum State {
        case loading
        case error(Error)
        case empty
        case populated
    }
    
    let dataService: CarDataService!
    var state: State {
        didSet {
            switch state {
            case .loading:
                print("loading")
            default:
                print("default")
            }
        }
    }
    
    var currentCars: LinkedList<CarViewModel> {
        get {
            switch state {
            case .populated:
                return _currentCars
            default:
                return LinkedList<CarViewModel>()
            }
        }
        set {
            switch state {
            case .populated:
                _currentCars = newValue
            default:
                print("default in current cars set")
            }
        }
    }
    
    init(with dataService: CarDataService) {
        state = .loading
        self.dataService = dataService
        _currentCars = LinkedList<CarViewModel>()
        
        fetchData()
    }
    
    func synchronizeEntity(at index: Int) {
            currentCars[index] =  CarViewModel(with: dataService[index])
    }
}

//MARK: - Private functions
private extension CarsListViewModel {
    func fetchData() {
        
       dataService.loadMockData()
        
     //   var result = [CarViewModel]()
        for i in 0 ..< dataService.count {
            let carModel = dataService[i]
            _currentCars.append(CarViewModel(with: carModel))
        }
        
        state = .populated
    }
    

}
