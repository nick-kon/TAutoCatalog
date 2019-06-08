//
//  CarDetailDatePickerViewCell.swift
//  TestAutoCatalog
//
//  Created by nic on 08/06/2019.
//  Copyright © 2019 nic. All rights reserved.
//

import UIKit

class CarDetailDatePickerViewCell: UITableViewCell {

    @IBOutlet weak var datePicker: UIPickerView!
    private var years = [Int]()
    var getSelectedYear: ((Int) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
         let currentYear = Calendar.current.component(.year, from: Date())
        
        for i in Constants.minimumYearOfManufacturing ... currentYear {
            years.append(i)
        }
        
        datePicker.dataSource = self
        datePicker.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with item: CarDetailViewModelItem) {
        guard let item = item as? CarDetailViewModelYearItem else { return }
        
        let itemYear = Calendar.current.component(.year, from: item.year)
        let index = itemYear - Constants.minimumYearOfManufacturing

        datePicker.selectRow(index, inComponent: 0, animated: true)
    }
}

//MARK: - UIPickerViewDataSource
extension CarDetailDatePickerViewCell: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return years.count
    }
}

//MARK: - UIPickerViewDelegate
extension CarDetailDatePickerViewCell: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(years[row])
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("did select date: \(years[row])")
        getSelectedYear?(years[row])
    }
}
