//
//  CarsListScreenViewController.swift
//  TestAutoCatalog
//
//  Created by nic on 07/06/2019.
//  Copyright © 2019 nic. All rights reserved.
//

import UIKit

class CarsListScreenViewController: UIViewController, Storyboarded {
    @IBOutlet weak var HelpViewContentView: UIView!
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var tableFooterLabel: UILabel!
    @IBOutlet weak var tableFooterView: UIView!
    @IBOutlet weak var activityInicator: UIActivityIndicatorView!
    
    @IBOutlet weak var helpView: UIView!

    @IBOutlet weak var tableView: UITableView!
    var carsViewModel: CarsListViewModel!
    weak var coordinator: MainCoordinator!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupHelpScreen()

        setupTableView()
        bindViewModel()
        // Do any additional setup after loading the view.
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
            self.view.removeVisualEffect()
            self.removeLogoImageView()
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
            view.addDarkBlurEffect()
            helpView.frame = view.bounds
            HelpViewContentView.addRoundedCorners()
            view.addSubview(helpView)
        } else {
            removeLogoImageView()
        }
    }
    
    func removeLogoImageView() {
        
        UIView.animate(withDuration: 2, delay: 0.5, options: [.curveEaseIn], animations: {
            
            let newX = self.logoImageView.bounds.width
            self.logoImageView.transform = CGAffineTransform(translationX: 0 - newX, y: 0)
        }, completion: { (finished) in
            self.logoImageView.removeFromSuperview()
        })
        
    }
    
    func bindViewModel() {
        carsViewModel.reloadView = {[unowned self] in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        carsViewModel.isNeededActivityIndicator.bindAndFire {[unowned self] (isNeeded) in
            DispatchQueue.main.async {
                isNeeded ? self.activityInicator.startAnimating() : self.activityInicator.stopAnimating()
            }
        }
        
        carsViewModel.titleInFooterView.bindAndFire {[unowned self] (text) in
            DispatchQueue.main.async {
                if text.isEmpty {
                    self.tableView.tableFooterView = nil
                } else {
                    self.tableFooterLabel.text = text
                    self.tableView.tableFooterView = self.tableFooterView
                }
            }
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
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        return UISwipeActionsConfiguration(actions: [])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let deleteAction = UIContextualAction(style: .destructive, title: Constants.UI.delete) {[unowned self] (action, view, performed) in
            self.carsViewModel.delete(at: indexPath.row)
            performed(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
     
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
