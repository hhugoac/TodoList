//
//  TodoListEntity+CoreDataProperties.swift
//  TodoList
//
//  Created by Hugo Alonzo on 25/05/24.
//
//

import Foundation
import CoreData


extension TodoListEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TodoListEntity> {
        return NSFetchRequest<TodoListEntity>(entityName: "TodoListEntity")
    }

    @NSManaged public var createdAt: Date?
    @NSManaged public var name: String?

}

extension TodoListEntity : Identifiable {

}
