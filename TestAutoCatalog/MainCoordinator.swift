//
//  Coordinator.swift
//  TestAutoCatalog
//
//  Created by nic on 07/06/2019.
//  Copyright © 2019 nic. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController
    let dataService: CarDataService
    
    
    private var currentCarIndex: Int = 0
    
    init(with navController: UINavigationController) {
        self.navigationController = navController
        dataService = CarDataService()

    }
    
    func start() {
        
        let vc = CarsListScreenViewController.instantiate()
        dataService.listenter = vc
        //prepare data
        let viewModel = CarsListViewModel(with: dataService)
        vc.carsViewModel = viewModel
        vc.coordinator = self
        
        navigationController.pushViewController(vc, animated: false)
    }
    
    func addCar() {
        
        let vc = CarDetailViewController.instantiate()
        let car = CarModel.getDefaultCarModel()
        let viewModel = CarDetailViewModel(car: car)
        viewModel.isAddingCar = true
        vc.viewModel = viewModel
        
        vc.title = Constants.UI.CarDetailScreen.titleAdd
        vc.rightBarButton.title = Constants.UI.add
        
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
        
    }
    
    func showDetailForCar(at index: Int) {
        currentCarIndex = index
        
        let vc = CarDetailViewController.instantiate()
        vc.coordinator = self

        //prepare data
        let viewModel = CarDetailViewModel(car: dataService[index])
        vc.viewModel = viewModel
        
        vc.title = Constants.UI.CarDetailScreen.titleDetail
        
        navigationController.pushViewController(vc, animated: true)
    }
    
    func didUpdateDetailsForCar(car: CarModel) {
        dataService[currentCarIndex] = car
        navigationController.popViewController(animated: true)
    }
    
    func didAddCar(car: CarModel) {
        dataService.append(car)
        navigationController.popViewController(animated: true)
    }
    
    func autosaveToFile() {
        dataService.save(completion: nil)
    }
}
