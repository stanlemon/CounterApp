//
//  Counter+CoreDataProperties.swift
//  CounterApp
//
//  Created by Stan Lemon on 6/11/19.
//  Copyright © 2019 Stan Lemon. All rights reserved.
//
//

import Foundation
import CoreData


extension Counter {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Counter> {
        return NSFetchRequest<Counter>(entityName: "Counter")
    }

    @NSManaged public var total: Int16

}
