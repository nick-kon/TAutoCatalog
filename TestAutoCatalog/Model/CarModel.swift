//
//  CarModel.swift
//  TestAutoCatalog
//
//  Created by nic on 07/06/2019.
//  Copyright © 2019 nic. All rights reserved.
//

import Foundation

/// Classes of car in Europe

enum CarClass: String, Codable {
    case a = "mini"   // Mini cars
    case b = "small"   // small cars
    case c = "medium"   // medium cars
    case d = "larger"   // larger cars
    case e = "executive"   // executive
    case f = "luxury"   // luxury
    case j = "suv"   // sport utility (suv)
    case m = "multipurpose"   // multipurpose
    case s = "sportCoupe"   // sport coupe
}

enum CarBodyStyle: String, Codable {
    case suv = "suv"
    case truck = "truck"
    case sedan = "sedan"
    case van = "van"
    case coupe = "coupe"
    case wagon = "wagon"
    case convertible = "convertible"
    case sport = "sport"
    case diesel = "diesel"
    case crossover = "crossover"
    case luxury = "luxury"
    case hybrid = "hybrid"
}

struct CarModel: Codable {
    var modelName: String
    var year: Date
    var manufacturer: String
    var bodyStyle: CarBodyStyle
    var carClass: CarClass
}
