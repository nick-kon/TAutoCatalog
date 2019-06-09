//
//  AbleToShowErrorMessage.swift
//  TestAutoCatalog
//
//  Created by nic on 09/06/2019.
//  Copyright © 2019 nic. All rights reserved.
//

import Foundation
import UIKit

protocol AbleToShowMessage where Self: UIViewController {
    func showErrorMessage(_ msg: String, completion: (() -> Void)?)
}

extension AbleToShowMessage {
    func showErrorMessage(_ msg: String, completion: (() -> Void)?) {
    
        let alertController = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: completion)
    }
}
