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
    
    enum State {
        case loading
        case error(Error)
        case empty
        case populated([CarViewModel])
    }
    
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
    
    var dataService: CarDataService!
    
    var currentCars: [CarViewModel] {
        switch state {
        case .populated(let cars):
            return cars
        default:
            return []
        }
    }
    
    init() {
        state = .loading
        dataService = CarDataService()
        fetchData()
    }
    
}

//MARK: - Private functions
private extension CarsListViewModel {
    func fetchData() {
        
        dataService.loadMockData()
        
        var result = [CarViewModel]()
        for i in 0 ..< dataService.count {
            let carModel = dataService.getCar(at: i)!
            result.append(CarViewModel(with: carModel))
        }
        
        state = .populated(result)
    }
}
