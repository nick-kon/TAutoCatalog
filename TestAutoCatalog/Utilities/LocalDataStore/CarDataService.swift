//
//  CarDataService.swift
//  TestAutoCatalog
//
//  Created by nic on 07/06/2019.
//  Copyright © 2019 nic. All rights reserved.
//

import Foundation

class CarDataService  {
   // let arr = Array()
    private let cars: LinkedList<CarModel>
    var listenter: DataServiceListener?
    
    init() {
        cars = LinkedList<CarModel>()
    }
    
    var count: Int {
        return cars.count
    }
    deinit {
        print("cardataservice deinit")
    }
}
//MARK: - private functions
private extension CarDataService {
    
    func loadFromFile() {
        
        
    }
}

//MARK: - API
extension CarDataService {
    
    func append(_ car: CarModel) {
        cars.append(car)
        listenter?.synchronizeAll()
    }
    
    func delete(at index: Int) {
       try! cars.delete(at: index)
        listenter?.synchronizeAll()
    }
    
    subscript(index: Int) -> CarModel {
        get {
            return cars[index]
        }
        set {
            cars[index] = newValue
            listenter?.synchronize(at: index)
        }
    }
    
    func loadMockData() {
        
        let car1 = CarModel(modelName: "Focus", year: Date(), manufacturer: "Ford", bodyStyle: .sedan, carClass: .c)
        let car2 = CarModel(modelName: "Camry", year: Date(), manufacturer: "Toyota", bodyStyle: .crossover, carClass: .d)
        let car3 = CarModel(modelName: "Ram", year: Date(), manufacturer: "Dodge", bodyStyle: .truck, carClass: .f)
        
        cars.append(car1)
        cars.append(car2)
        cars.append(car3)

    }

//    func load(completion: @escaping (Result<LinkedList<CarModel>, Error>) -> Void) {
//        
//        loadMockData()
//
//        completion(.success(cars))
//
//    }
    
    func encodeToJSON() -> Data? {
        
        var arr = [CarModel]()
        
        for i in 0 ..< count {
            arr.append(cars[i])
        }
        
        return try? JSONEncoder().encode(arr)
    }
    
    func decodeFromJSON(jsonData: Data) {
        
        let cars =  try! JSONDecoder().decode([CarModel].self, from: jsonData)
        
        for car in cars {
            self.cars.append(car)
        }
        
    }
    
    func saveToFile() {
        
    }
}


