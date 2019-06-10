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
                isNeededActivityIndicator.value = true
//                print("loading")
            case .error(let error):
                titleInFooterView.value = error.localizedDescription
                print(error.localizedDescription)
            case .populated:
                isNeededActivityIndicator.value = false
                reloadView?()
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
    
// Binding
    var isNeededActivityIndicator = Box(true)
    var titleInFooterView = Box("")
    var reloadView: (() -> Void)?
    
    
    init(with dataService: CarDataService) {
        state = .loading
        self.dataService = dataService
        _currentCars = LinkedList<CarViewModel>()
        
        fetchData()
    }
    
    func synchronizeEntity(at index: Int) {
        
            currentCars[index] =  CarViewModel(with: dataService[index])
    }
    
    func synchronizeAll() {
        _currentCars.deleteAll()
        for i in 0 ..< dataService.count {
            let carModel = dataService[i]
            _currentCars.append(CarViewModel(with: carModel))
        }
    }
    
}

//MARK: - Private functions
private extension CarsListViewModel {
    func fetchData() {
        
        dataService.load { [weak self] (error) in
            if let error = error {
                self?.state = .error(error)
            } else {
                self?.synchronizeAll()
                self?.state = .populated
            }
        }
        
        
//        dataService.load { (result) in
//            switch result {
//            case .success(let data):
//                print(data)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
        
    //    dataService.export()
//
//        synchronizeAll()
//
//        state = .populated
    }
    

}
