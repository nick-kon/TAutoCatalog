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
        case error(DataServiceError)
        case empty
        case populated
    }
    
    
    
    let dataService: CarDataService!
    var state: State {
        didSet {
            switch state {
            case .loading:
                isNeededActivityIndicator.value = true
                print(".loading")
//                print("loading")
            case .error(let error):
                var text = ""
                switch error {
                case .cannotProcessData:
                    text = "cannot process data"
                case .fileDoesNotExists:
                    text = "file does not exists"
                case .cannotWriteToFile:
                    text = "cannot write to file"
                case .unexpectedError:
                    text = "unexpected error"
                }
                
                titleInFooterView.value = text
                isNeededActivityIndicator.value = false

            case .populated:
                print(".populated")
                isNeededActivityIndicator.value = false
                titleInFooterView.value = ""
                reloadView?()
            case .empty:
                isNeededActivityIndicator.value = false
                reloadView?()
                titleInFooterView.value = "Empty list. Add some records"
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
        
        print("cars list view model init")
        
        state = .loading
        self.dataService = dataService
        _currentCars = LinkedList<CarViewModel>()
        
        fetchData()
    }
    
    deinit {
        print("cars list view model deinit")
    }
    
    //MARK: - Public functions
    func synchronizeEntity(at index: Int) {
        
            currentCars[index] =  CarViewModel(with: dataService[index])
    }
    
    func delete(at index: Int) {
        dataService.delete(at: index)
    }
    
    func synchronizeAll() {
        _currentCars.deleteAll()
        for i in 0 ..< dataService.count {
            let carModel = dataService[i]
            _currentCars.append(CarViewModel(with: carModel))
        }
        
       state =  dataService.count > 0 ?  .populated : .empty
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
    }

}
