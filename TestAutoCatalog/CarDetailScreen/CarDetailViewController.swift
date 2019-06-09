//
//  CarDetailViewController.swift
//  TestAutoCatalog
//
//  Created by nic on 07/06/2019.
//  Copyright © 2019 nic. All rights reserved.
//

import UIKit

class CarDetailViewController: UIViewController, Storyboarded {

    
    @IBOutlet weak var rightBarButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    weak var coordinator: MainCoordinator!
    var viewModel: CarDetailViewModel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupTableView()
        bindViewModel()
    }

    deinit {
        print("Car detail VC deinit")
    }
}

//MARK: - User interactions
private extension CarDetailViewController {
    
    @IBAction func rightBarButtonTapped(_ sender: UIBarButtonItem) {
   //     print("right button tapped")
        if let resultCar = viewModel.composeCarModel() {
            coordinator.didUpdateDetailsForCar(car: resultCar)
        } else {
            print("wrong carModel in detail car VC")
        }
    }
    
}

//MARK: - Private functions
private extension CarDetailViewController {
    func setupTableView() {
        
        let labelCellNib = UINib(nibName: CarDetailLabelViewCell.identifier, bundle: Bundle.main)
        tableView.register(labelCellNib, forCellReuseIdentifier: CarDetailLabelViewCell.identifier)
        
        let textfieldCellNib = UINib(nibName: CarDetailTextfieldViewCell.identifier, bundle: Bundle.main)
        tableView.register(textfieldCellNib, forCellReuseIdentifier: CarDetailTextfieldViewCell.identifier)
        
        let datepickerCellNib = UINib(nibName: CarDetailDatePickerViewCell.identifier, bundle: Bundle.main)
        tableView.register(datepickerCellNib, forCellReuseIdentifier: CarDetailDatePickerViewCell.identifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
    }
    
    func bindViewModel() {
        
        viewModel.title.bind {[unowned self] (title) in
            self.title = title
        }
        
        viewModel.rightBarButtonTitle.bind {[unowned self] (title) in
            self.rightBarButton.title = title
        }
        
        viewModel.reloadRow = {[unowned self] (section) in
            let indexSet = IndexSet(integer: section)
            self.tableView.reloadSections(indexSet, with: .automatic)
        }
        
    }
    
    func editViewModelItem(at index: Int) {
        
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
        
        switch viewModel.state {
        case .normal:
             if let cell = tableView.dequeueReusableCell(withIdentifier: CarDetailLabelViewCell.identifier, for: indexPath) as? CarDetailLabelViewCell {
                            cell.configure(with: item)
                return cell
            }
        case .editing:
            switch item.type {
            case .year:
                if let cell = tableView.dequeueReusableCell(withIdentifier: CarDetailDatePickerViewCell.identifier, for: indexPath) as? CarDetailDatePickerViewCell {
                    cell.delegate = self
                    cell.configure(with: item)
                    return cell
                }
            case .carClass, .carType:
                
                let vc = PopupTableViewController.instantiate()
                var carAttribute: StoredAsEnum
                
                if let carClassItem = item as? CarDetailViewModelCarClassItem {
                    carAttribute = carClassItem.carAttributeEnumValue
                } else {
                    let bodyStyleItem = item as! CarDetailViewModelCarBodyStyleItem
                    carAttribute = bodyStyleItem.carAttributeEnumValue
                }
                
                vc.carAttribute = carAttribute
                vc.delegate = self
                present(vc, animated: true, completion: nil)
                
                if let cell = tableView.dequeueReusableCell(withIdentifier: CarDetailLabelViewCell.identifier, for: indexPath) as? CarDetailLabelViewCell {
                    cell.configure(with: item)
                    return cell
                }
                
            default:
                if let cell = tableView.dequeueReusableCell(withIdentifier: CarDetailTextfieldViewCell.identifier, for: indexPath) as? CarDetailTextfieldViewCell {
                    
                    cell.configure(with: item)
                    cell.textfield.delegate = self
                    return cell
                }
            }
       default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.items[section].title
    }
    
}

//MARK: - UITableViewDelegate
extension CarDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let editAction = UIContextualAction(style: .normal, title: Constants.UI.edit) { (action, view, performed) in
            
            self.viewModel.state = .editing(indexPath.section)
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
            performed(true)
        }
        
        return UISwipeActionsConfiguration(actions: [editAction])
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        return UISwipeActionsConfiguration(actions: [])
    }
}

//MARK: - TableViewPickerDelegate
extension CarDetailViewController: TableViewPickerDelegate {
    func didSelectEnumValue(_ value: StoredAsEnum) {
        viewModel.didSelectEnumValue(value)
    }
}

//MARK: - YearPickerDelegate
extension CarDetailViewController: YearPickerDelegate {
    func didSelectYear(_ year: Int) {
        viewModel.didSelectYear(year)
    }
}

//MARK: - UITextFieldDelegate
extension CarDetailViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
     
        if textField.validateForIsEmpty() {
            return false
        }
        
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        viewModel.didEnterText(textField.text!)
    }
    
}
