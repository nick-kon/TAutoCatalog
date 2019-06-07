//
//  CarsListScreenViewController.swift
//  TestAutoCatalog
//
//  Created by nic on 07/06/2019.
//  Copyright © 2019 nic. All rights reserved.
//

import UIKit

class CarsListScreenViewController: UIViewController, Storyboarded {
    

    @IBOutlet weak var tableView: UITableView!
    var carsViewModel: CarsListViewModel!
    weak var coordinator: MainCoordinator!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        carsViewModel = CarsListViewModel()
       
        setupTableView()
        
        // Do any additional setup after loading the view.
    }

}

//MARK: - User interactions
private extension CarsListScreenViewController {
    @IBAction func addButtonTapped(_ sender: UIButton) {
        coordinator.addCar()
        print("addCar")
    }
    
}

//MARK: - Private functions
private extension CarsListScreenViewController {
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self

    }
}

//MARK: - UITableViewDataSource
extension CarsListScreenViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carsViewModel.currentCars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CarsListCell.identifier, for: indexPath) as! CarsListCell
        cell.configure(with: carsViewModel.currentCars[indexPath.row])
        return cell
    }
    
}
//MARK: - UITableViewDelegate
extension CarsListScreenViewController: UITableViewDelegate {
    
}
