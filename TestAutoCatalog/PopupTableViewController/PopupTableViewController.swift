//
//  PopupTableViewController.swift
//  TestAutoCatalog
//
//  Created by nic on 08/06/2019.
//  Copyright © 2019 nic. All rights reserved.
//

import UIKit

class PopupTableViewController: UIViewController, Storyboarded {

    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var carAttribute: StoredAsEnum!
    var viewModel: PopupViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = PopupViewModel(with: carAttribute)
        
        setupTableView()

    }
 }
//MARK: - User interactions
private extension PopupTableViewController {
    @IBAction func closeButtonTapped(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}


//MARK: - Private functions
private extension PopupTableViewController {
    func setupTableView() {
        
        let nib = UINib(nibName: PopupTableViewCell.identifier, bundle: Bundle.main)
        tableView.register(nib, forCellReuseIdentifier: PopupTableViewCell.identifier)
        
        tableView.dataSource = self
        tableView.delegate = self
        
        let indexPath = IndexPath(item: viewModel.selectedIndex, section: 0)
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .middle)
    }
}

//MARK: - UITableViewDataSource
extension PopupTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PopupTableViewCell.identifier, for: indexPath) as! PopupTableViewCell
        cell.configure(with: viewModel.items[indexPath.row])
        return cell
    }
    
}

//MARK: - UITableViewDelegate
extension PopupTableViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.selectItem(at: indexPath.row)
        
    }
    
}
