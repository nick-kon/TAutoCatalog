//
//  CarDetailViewController.swift
//  TestAutoCatalog
//
//  Created by nic on 07/06/2019.
//  Copyright © 2019 nic. All rights reserved.
//

import UIKit

class CarDetailViewController: UIViewController, Storyboarded {

    @IBOutlet weak var tableView: UITableView!
    weak var coordinator: MainCoordinator!
    var viewModel: CarDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        // Do any additional setup after loading the view.
    }

}
//MARK: - Private functions
private extension CarDetailViewController {
    func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
}

//MARK: - UITableViewDataSource
extension CarDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items[section].numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.items[section].title
    }
    
}

//MARK: - UITableViewDelegate
extension CarDetailViewController: UITableViewDelegate {

}
