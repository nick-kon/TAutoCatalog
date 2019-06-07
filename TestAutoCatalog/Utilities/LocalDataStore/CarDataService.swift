//
//  CarDataService.swift
//  TestAutoCatalog
//
//  Created by nic on 07/06/2019.
//  Copyright © 2019 nic. All rights reserved.
//

import Foundation

class CarDataService {
    
    private let cars: LinkedList<CarModel>
    
    init() {
        cars = LinkedList<CarModel>()
    }
    
    var count: Int {
        return cars.count
    }
    
}

//MARK: - API
extension CarDataService {

    func append(_ car: CarModel) {
        cars.append(car)
    }
    
    func delete(at index: Int) {
       try! cars.delete(at: index)
    }
    
    func getCar(at index: Int) -> CarModel? {
        return try! cars.getValue(at: index)
    }
    
    func updateCar(at index: Int, with car: CarModel) {
        cars.update(at: index, with: car)
    }
    
    func loadMockData() {
        
        
      //  let car1 = CarModel(modelName: "Focus", year: Date(), manufacturer: "Ford", car)
      //  let car2 = CarModel(modelName: "Camry", year: Date(), manufacturer: "Toyota")
      //  let car3 = CarModel(modelName: "Ram", year: Date(), manufacturer: "Dodge")
        let car1 = CarModel(modelName: "Focus", year: Date(), manufacturer: "Ford", bodyStyle: .sedan, carClass: .c)
        let car2 = CarModel(modelName: "Camry", year: Date(), manufacturer: "Toyota", bodyStyle: .crossover, carClass: .d)
        let car3 = CarModel(modelName: "Ram", year: Date(), manufacturer: "Dodge", bodyStyle: .truck, carClass: .f)
        
        cars.append(car1)
        cars.append(car2)
        cars.append(car3)
//        print("added")
//        for i in 0 ..< cars.count {
//            let car = try! cars.getValue(at: i)
//            print(car?.modelName)
//        }
//        
//        print("deleted at 1")
//        try! cars.delete(at: 1)
//
//        for i in 0 ..< cars.count {
//            let car = try! cars.getValue(at: i)
//            print(car?.modelName)
//        }
//
//        print("deleted at 1")
//        try! cars.delete(at: 1)
//
//        for i in 0 ..< cars.count {
//            let car = try! cars.getValue(at: i)
//            print(car?.modelName)
//        }
    }

//    func load(completion: @escaping (Result<LinkedList<CarModel>, Error>) -> Void) {
//        
//        loadMockData()
//
//        completion(.success(cars))
//
//    }
    
    func export() {
        
    }
}


