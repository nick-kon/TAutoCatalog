//
//  CarsListScreenViewController.swift
//  TestAutoCatalog
//
//  Created by nic on 07/06/2019.
//  Copyright © 2019 nic. All rights reserved.
//

import UIKit

class CarsListScreenViewController: UIViewController, Storyboarded {
    

    @IBOutlet weak var helpView: UIView!

    @IBOutlet weak var tableView: UITableView!
    var carsViewModel: CarsListViewModel!
    weak var coordinator: MainCoordinator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setupTableView()
        setupHelpScreen()
        // Do any additional setup after loading the view.
    }

    deinit {
        print("CarsListScreenViewController deinit")
    }
}

//MARK: - User interactions
private extension CarsListScreenViewController {
    @IBAction func addButtonTapped(_ sender: UIButton) {
        coordinator.addCar()
    }
    
    @IBAction func helpViewCloseButtonTapped(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.5, animations: {
            self.helpView.alpha = 0
        }) { (success) in
            UserDefaults.standard.set(true, forKey: Constants.Keys.isHiddenHelpScreen)
            self.helpView.removeFromSuperview()
        }
        
    }
    
}

//MARK: - Private functions
private extension CarsListScreenViewController {
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self

    }
    
    func setupHelpScreen() {
        if (!UserDefaults.standard.bool(forKey: Constants.Keys.isHiddenHelpScreen)) {
            helpView.frame = view.bounds
            view.addSubview(helpView)
        }
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        coordinator.showDetailForCar(at: indexPath.row)
    }
}

//MARK: - DataServiceListener
extension CarsListScreenViewController: DataServiceListener {
    func synchronize(at index: Int) {
     
        //update viewModel
        carsViewModel.synchronizeEntity(at: index)
        
        //update tableview
        let indexPath = IndexPath(row: index, section: 0)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    func synchronizeAll() {
        carsViewModel.synchronizeAll()
        tableView.reloadData()
    }
    
}
