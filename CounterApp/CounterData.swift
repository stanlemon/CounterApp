//
//  CounterData.swift
//  CounterApp
//
//  Created by Stan Lemon on 6/10/19.
//  Copyright © 2019 Stan Lemon. All rights reserved.
//

import SwiftUI
import Combine
import CoreData

final class CounterData: ObservableObject  {
    
    let appDelegate: AppDelegate
    let context: NSManagedObjectContext
    
    init() {
        print("Counter data initialized")
        
        appDelegate = UIApplication.shared.delegate as! AppDelegate
        context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Counter")
        fetchRequest.fetchLimit = 1
        
        do {
            print("Loading data")
            
            let results = try context.fetch(fetchRequest) as! [Counter]
            
            print("Found results ", results)
            
            if results.capacity > 0 {
                self.count = results[0].total
            }
        } catch {
            // Do something in response to error condition
            print("Failed trying to load")
            print("Error info: \(error)")
        }
    }
    
    let didChange = PassthroughSubject<CounterData, Never>()
    
    @Published
    var count: Int16 = 0  {
        didSet {
            print("Data changed to ", self.count)
            didChange.send(self)
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Counter")
            fetchRequest.fetchLimit = 1
            
            do {
                let results = try context.fetch(fetchRequest) as! [Counter]
                
                if results.capacity > 0 {
                    print("Updating existing entity")
                    
                    results[0].total = self.count
                } else {
                    print("Creating new entity")
                    
                    let newEntity = NSEntityDescription.insertNewObject(forEntityName: "Counter", into: context) as! Counter
                    
                    newEntity.total = self.count
                }
                
                try context.save();
            } catch {
                // Do something in response to error condition
                print("Failed trying to save")
                print("Error info: \(error)")
            }
        }
    }
}
