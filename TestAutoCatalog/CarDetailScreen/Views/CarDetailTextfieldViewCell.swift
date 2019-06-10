//
//  CarDetailTextfieldViewCell.swift
//  TestAutoCatalog
//
//  Created by nic on 08/06/2019.
//  Copyright © 2019 nic. All rights reserved.
//

import UIKit

class CarDetailTextfieldViewCell: UITableViewCell {

    @IBOutlet weak var textfield: UITextField!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with item: CarDetailViewModelItem) {
        
        textfield.text = item.textValue
        textfield.placeholder = Constants.UI.enter + " \(item.title.lowercased())"
    }
    
}
