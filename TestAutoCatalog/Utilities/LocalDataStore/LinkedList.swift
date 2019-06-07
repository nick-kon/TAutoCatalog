//
//  LocalDataStore.swift
//  TestAutoCatalog
//
//  Created by nic on 07/06/2019.
//  Copyright © 2019 nic. All rights reserved.
//

import Foundation


enum ListError: Error {
    case IndexOutOfRange
}


class ListNode {
    let id: UUID
    var carInfo: CarModel!
    var pNext: ListNode?
    
    init(car: CarModel) {
        id = UUID()
        carInfo = car
    }
    
}

class LinkedList{
    private var head: ListNode?
    private(set) var count: Int = 0
    
    //MARK: - API
    
    func append(_ node: ListNode) {
    
      if head == nil {
            head = node
        } else {
            var iterator = head
        
            while iterator?.pNext != nil{
                iterator = iterator?.pNext
            }
    
            iterator!.pNext = node
        }
        
        count += 1
    }
    
    func delete(at index: Int) throws {
        
        guard index < count, index >= 0 else { throw ListError.IndexOutOfRange }
        
        if index == 0 {
            head = nil
        } else {
            let prevNode = try! get(at: index - 1)
            let deletedNode = try! get(at: index)
            prevNode!.pNext = deletedNode!.pNext
        }
        count -= 1
    }
    
    func get(at index: Int) throws -> ListNode? {
        guard index < count else { throw ListError.IndexOutOfRange  }
        var iterator = head
        for _ in 0 ..< index {
            iterator = iterator?.pNext
        }
        return iterator
    }
    
    
    
}
