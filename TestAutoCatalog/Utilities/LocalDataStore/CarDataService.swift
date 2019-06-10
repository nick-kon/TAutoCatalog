//
//  CarDataService.swift
//  TestAutoCatalog
//
//  Created by nic on 07/06/2019.
//  Copyright © 2019 nic. All rights reserved.
//

import Foundation

enum DataServiceError: Error {
    case fileDoesNotExists
    case cannotProcessData
    case unexpectedError
    case cannotWriteToFile
}

class CarDataService{

    private let cars: LinkedList<CarModel>
    var listenter: DataServiceListener?
    
    var URLToFilename: URL {
        return getDocumentsDirectory().appendingPathComponent(Constants.filenameForJson)
    }
    
    init() {
        cars = LinkedList<CarModel>()
    }
    
    var count: Int {
        return cars.count
    }
}
//MARK: - Save & load to file
extension CarDataService {
    
    func save(completion: ((DataServiceError?) -> Void)?) {
        
        guard let data = encodeToJSON() else {
            completion?(DataServiceError.cannotProcessData)
            return
        }
       DispatchQueue.global(qos: .background).async {
            
            if FileManager.default.fileExists(atPath: self.URLToFilename.path) {
                do {
                    try FileManager.default.removeItem(at: self.URLToFilename )
                } catch {
                    completion?(DataServiceError.unexpectedError)
                }
            }
            
            do {
                try data.write(to: self.URLToFilename, options: .atomic)
            } catch {
                completion?(DataServiceError.cannotWriteToFile)
            }
        }
    }
    
    func load(completion: @escaping (DataServiceError?) -> Void) {
        
        if UserDefaults.standard.bool(forKey: Constants.Keys.isNotRequiredMockData) {
            
            let deadLine = DispatchTime.now() + .seconds(Constants.delaySimulated)
            
            DispatchQueue.main.asyncAfter(deadline: deadLine) {
                
                guard FileManager.default.fileExists(atPath: self.URLToFilename.path)
                    else { completion(DataServiceError.fileDoesNotExists)
                            return
                }
                
                do {
                    let data = try Data(contentsOf: self.URLToFilename)
                        try self.decodeFromJSON(jsonData: data)
                    completion(nil)
                } catch {
                    completion(DataServiceError.cannotProcessData)
                }
            }
        } else {
            self.loadMockData()
            UserDefaults.standard.set(true, forKey: Constants.Keys.isNotRequiredMockData)
            completion(nil)
        }
    }

}

//MARK: - Private functions
private extension CarDataService {
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func loadMockData() {
        
        let car1 = CarModel(modelName: "Focus", year: Date(), manufacturer: "Ford", bodyStyle: .sedan, carClass: .c)
        let car2 = CarModel(modelName: "Camry", year: Date(), manufacturer: "Toyota", bodyStyle: .crossover, carClass: .d)
        let car3 = CarModel(modelName: "Patriot", year: Date(), manufacturer: "UAZ", bodyStyle: .truck, carClass: .f)
        let car4 = CarModel(modelName: "Vesta", year: Date(), manufacturer: "Lada", bodyStyle: .hybrid, carClass: .b)
        
        cars.append(car1)
        cars.append(car2)
        cars.append(car3)
        cars.append(car4)
        
    }
    
    func encodeToJSON() -> Data? {
        
        var arr = [CarModel]()
        
        for i in 0 ..< count {
            arr.append(cars[i])
        }
        
        return try? JSONEncoder().encode(arr)
    }
    
    func decodeFromJSON(jsonData: Data) throws {
        
        do {
            let cars =  try JSONDecoder().decode([CarModel].self, from: jsonData)
            
            for car in cars {
                self.cars.append(car)
            }
            
        } catch {
            throw(error)
        }
    }
}

//MARK: - API
extension CarDataService {
    
    func append(_ car: CarModel) {
        cars.append(car)
        save(completion: nil)
        listenter?.synchronizeAll()
    }
    
    func delete(at index: Int) {
       try! cars.delete(at: index)
        save(completion: nil)
        listenter?.synchronizeAll()
    }
    
    subscript(index: Int) -> CarModel {
        get {
            return cars[index]
        }
        set {
            cars[index] = newValue
            save(completion: nil)
            listenter?.synchronize(at: index)
        }
    }
}


