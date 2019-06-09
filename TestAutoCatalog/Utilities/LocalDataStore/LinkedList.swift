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


class ListNode<T> {
    let id: UUID
    var value: T
    var pNext: ListNode<T>?
    
    init(value: T) {
        id = UUID()
        self.value = value
    }
    
}

class LinkedList<T>{
    private var head: ListNode<T>?
    private(set) var count: Int = 0

    subscript(index: Int) -> T {
        get {
            return try! getValue(at: index)!
        }
        set {
            update(at: index, with: newValue)
        }
    }
    
    deinit {
        let str = String(describing: T.self)
        print("Linked List deinit with type: " + str)
    }
//MARK: - API

    func append(_ value: T) {
       let newNode = ListNode(value: value)

        if head == nil {
            head = newNode
        } else {
            var iterator = head
            
            while iterator?.pNext != nil{
                iterator = iterator?.pNext
            }
            
            iterator!.pNext = newNode
        }
        count += 1
    }
    
    func append(_ node: ListNode<T>) {
    
      if head == nil {
            head = node
        } else {
            let lastNode = try! getNode(at: count - 1)
            lastNode?.pNext = node
        }
        
        count += 1
    }
    

    func delete(at index: Int) throws {
        
        guard index < count, index >= 0 else { throw ListError.IndexOutOfRange }
        
        if index == 0 {
            head = nil
        } else {
            let prevNode = try! getNode(at: index - 1)
            let deletedNode = try! getNode(at: index)
            prevNode!.pNext = deletedNode!.pNext
        }
        count -= 1
    }
    
    
//MARK: - Private functions
    
    private func getNode(at index: Int) throws -> ListNode<T>? {
        guard index < count, index >= 0 else { throw ListError.IndexOutOfRange  }
        var iterator = head
        for _ in 0 ..< index {
            iterator = iterator?.pNext
        }
        return iterator
    }
    
    private func getValue(at index: Int) throws -> T? {
        let node = try! getNode(at: index)
        return node?.value
    }
    
    private func update(at index: Int, with value: T) {
        let updatedNode = try! getNode(at: index)
        updatedNode?.value = value
    }
    
}



