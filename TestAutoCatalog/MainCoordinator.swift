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
    
    
    init(with navController: UINavigationController) {
        self.navigationController = navController
    }
    
    func start() {
        let vc = CarsListScreenViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
    }
    
    func addCar() {
        
        let vc = AddCarViewController.instantiate()
        navigationController.pushViewController(vc, animated: true)
        
    }
    
}
