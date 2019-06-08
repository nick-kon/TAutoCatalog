//
//  PopupTableViewCell.swift
//  TestAutoCatalog
//
//  Created by nic on 08/06/2019.
//  Copyright © 2019 nic. All rights reserved.
//

import UIKit

class PopupTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with title: String) {
        titleLabel.text = title
    }
    
}
