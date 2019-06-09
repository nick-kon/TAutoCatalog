//
//  CarModel.swift
//  TestAutoCatalog
//
//  Created by nic on 07/06/2019.
//  Copyright © 2019 nic. All rights reserved.
//

import Foundation

/// Classes of car in Europe

enum CarModelError: Error {
    case emptyName
    case emptyManufacturer
}

enum CarClass: String, Codable, StoredAsEnum, CaseIterable {
    
    case a = "mini"   // Mini cars
    case b = "small"   // small cars
    case c = "medium"   // medium cars
    case d = "larger"   // larger cars
    case e = "executive"   // executive
    case f = "luxury"   // luxury
    case j = "suv"   // sport utility (suv)
    case m = "multipurpose"   // multipurpose
    case s = "sportCoupe"   // sport coupe
    
    func toString() -> String {
        switch self {
        case .a:
            return Constants.UI.CarClasses.a
        case .b:
            return Constants.UI.CarClasses.b
        case .c:
            return Constants.UI.CarClasses.c
        case .d:
            return Constants.UI.CarClasses.d
        case .e:
            return Constants.UI.CarClasses.e
        case .f:
            return Constants.UI.CarClasses.f
        case .j:
            return Constants.UI.CarClasses.j
        case .m:
            return Constants.UI.CarClasses.m
        case .s:
            return Constants.UI.CarClasses.s
        }
        
    }

}

enum CarBodyStyle: String, Codable, StoredAsEnum, CaseIterable {

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
    
    func toString() -> String {
        switch self {
        case .convertible:
            return Constants.UI.CarBodyStyle.convertible
        case .coupe:
            return Constants.UI.CarBodyStyle.coupe
        case .crossover:
            return Constants.UI.CarBodyStyle.crossover
        case .diesel:
            return Constants.UI.CarBodyStyle.diesel
        case .hybrid:
            return Constants.UI.CarBodyStyle.hybrid
        case .luxury:
            return Constants.UI.CarBodyStyle.luxury
        case .sedan:
            return Constants.UI.CarBodyStyle.sedan
        case .sport:
            return Constants.UI.CarBodyStyle.sport
        case .suv:
            return Constants.UI.CarBodyStyle.suv
        case .truck:
            return Constants.UI.CarBodyStyle.truck
        case .van:
            return Constants.UI.CarBodyStyle.van
        case .wagon:
            return Constants.UI.CarBodyStyle.wagon
        }
    }
    
}

struct CarModel: Codable {
    var modelName: String
    var year: Date
    var manufacturer: String
    var bodyStyle: CarBodyStyle
    var carClass: CarClass
}
