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
        
        let labelCellNib = UINib(nibName: CarDetailLabelViewCell.identifier, bundle: Bundle.main)
        tableView.register(labelCellNib, forCellReuseIdentifier: CarDetailLabelViewCell.identifier)
        
        let textfieldCellNib = UINib(nibName: CarDetailTextfieldViewCell.identifier, bundle: Bundle.main)
        tableView.register(textfieldCellNib, forCellReuseIdentifier: CarDetailTextfieldViewCell.identifier)
        
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
        let item = viewModel.items[indexPath.section]
        

        if let cell = tableView.dequeueReusableCell(withIdentifier: CarDetailTextfieldViewCell.identifier, for: indexPath) as? CarDetailTextfieldViewCell {
            cell.configure(with: item)
            return cell
        }

        
//        if let cell = tableView.dequeueReusableCell(withIdentifier: CarDetailLabelViewCell.identifier, for: indexPath) as? CarDetailLabelViewCell {
//            cell.configure(with: item)
//            return cell
//        }
//        switch item.type {
//        case .modelName:
//            if let cell = tableView.dequeueReusableCell(withIdentifier: CarDetailLabelViewCell.identifier, for: indexPath) as? CarDetailLabelViewCell {
//                cell.configure(with: item)
//            }
//        case .year:
//
//
//        }
        return UITableViewCell()

    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.items[section].title
    }
    
}

//MARK: - UITableViewDelegate
extension CarDetailViewController: UITableViewDelegate {

}
