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
    
    
    //private vars:
    
    private var currentCarIndex: Int = 0
    
    init(with navController: UINavigationController) {
        self.navigationController = navController
        dataService = CarDataService()
    }
    
    func start() {
        
        let vc = CarsListScreenViewController.instantiate()
        
        //prepare data
        let viewModel = CarsListViewModel(with: dataService)
        vc.carsViewModel = viewModel
        vc.coordinator = self
        
        navigationController.pushViewController(vc, animated: false)
    }
    
    func addCar() {
        
        let vc = CarDetailViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
        
    }
    
    func showDetailForCar(at index: Int) {
        currentCarIndex = index
        
        let vc = CarDetailViewController.instantiate()
        vc.coordinator = self

        //prepare data
        let viewModel = CarDetailViewModel(car: dataService.getCar(at: index)!)
        vc.viewModel = viewModel
        
        navigationController.pushViewController(vc, animated: true)
    }
    
}
