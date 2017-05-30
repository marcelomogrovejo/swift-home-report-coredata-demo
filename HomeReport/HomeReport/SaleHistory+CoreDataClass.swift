//
//  SaleHistory+CoreDataClass.swift
//  HomeReport
//
//  Created by Marcelo Mogrovejo on 5/24/17.
//  Copyright © 2017 Marcelo Mogrovejo. All rights reserved.
//

import Foundation
import CoreData

@objc(SaleHistory)
public class SaleHistory: NSManagedObject {

    func getSoldHistory(home: Home, moc: NSManagedObjectContext) -> [SaleHistory] {
        let request: NSFetchRequest<SaleHistory> = SaleHistory.fetchRequest()
        request.predicate = NSPredicate(format: "home = %@", home)
        
        do {
            let soldHistory = try moc.fetch(request)
            return soldHistory
        } catch {
            fatalError("Error in getting sold history")
        }
        
    }

}
