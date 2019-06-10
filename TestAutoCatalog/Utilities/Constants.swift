//
//  Constants.swift
//  TestAutoCatalog
//
//  Created by nic on 07/06/2019.
//  Copyright © 2019 nic. All rights reserved.
//

import Foundation

struct Constants {
    
    static let minimumYearOfManufacturing: Int = 1955
    static let filenameForJson = "jsondata.txt"
    static let delaySimulated: Int = 5
    
    struct UI {
        
        struct ErrorMessages {
            static let emptyModelname = "Enter model name."
            static let emptyManufacturer = "Enter manufacturer."
            static let cannotProcessData = "Ooops. Can't process data."
            static let fileDoesNotExist = "File with data not found."
            static let cannotWriteToFile = "File with data cannot be accessed."
            static let unexpectedError = "Oops. Something went wrong :("
            static let emptyList = "Empty list. Add some records!"
        }
        
        struct CarBodyStyle {
            static let suv = "Sport utility vehicle."
            static let truck = "Truck. Pickup."
            static let sedan = "Sedan."
            static let van = "Microvan. Minivan (MPV)."
            static let coupe = "Coupe."
            static let wagon = "Station wagon."
            static let convertible = "Convertible / cabriolet."
            static let sport = "Sports car. Muscle car."
            static let diesel = "Diesel."
            static let crossover = "Crossover."
            static let luxury = "Luxury."
            static let hybrid = "Hybrid / Electro."
            static let hatchback = "Hatchback."
        }
        
        struct CarClasses {
            static let a = "A-segment. City Car."
            static let b = "B-segment. Subcompact."
            static let c = "C-segment. Compact / Small family."
            static let d = "D-segment. Large family / Mid-size."
            static let e = "E-segment. Executive / Full-size."
            static let f = "F-segment. Luxury / Full-size luxury."
            static let j = "SUV. Offroad vehicles."
            static let m = "Multipurpose."
            static let s = "Sports / Performance cars."
        }
        
        struct CarDetailScreen {
            static let titleDetail = "Car detail"
            static let titleAdd = "Add car"
            static let titleEdit = "Edit car info"
            
            struct SectionTitles {
                static let model = "Model"
                static let year = "Year"
                static let carClass = "Class"
                static let carType = "Type of car"
                static let manufacturer = "Manufacturer"
            }
        }
        static let add = "Add"
        static let edit = "Edit"
        static let delete = "Delete"
        static let done = "Done"
        static let save = "Save"
        static let select = "Select"
        static let enter = "Enter"
    }
    
    struct Keys {
        static let isHiddenHelpScreen = "isHiddenHelpScreen"
        static let isNotRequiredMockData = "isNotRequiredMockData"
    }
}
