//
//  PopupTableViewModel.swift
//  TestAutoCatalog
//
//  Created by nic on 08/06/2019.
//  Copyright © 2019 nic. All rights reserved.
//

import Foundation

class PopupViewModel {
    var items = [String]()
    var mapToEnumValues = [StoredAsEnum]()
    
    private(set) var selectedIndex: Int = 0
    
    var selectedItemAsEnumValue: StoredAsEnum {
        return mapToEnumValues[selectedIndex]
    }
    
    func selectItem(at index: Int) {
        selectedIndex = index
    }
    
    init(with carAttribute: StoredAsEnum) {
        
        if let bodyStyle = carAttribute as? CarBodyStyle {
            
            for (index, style) in CarBodyStyle.allCases.enumerated(){
                if style == bodyStyle {
                    selectedIndex = index
                }
                items.append(style.toString())
                mapToEnumValues.append(style)
            }
            
        } else if let carClass = carAttribute as? CarClass {
            for (index, carClassInArr) in CarClass.allCases.enumerated(){
                if carClass == carClassInArr {
                    selectedIndex = index
                }
                items.append(carClassInArr.toString())
                mapToEnumValues.append(carClassInArr)
            }
        }
        
    }
}
