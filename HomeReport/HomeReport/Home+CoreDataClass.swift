//
//  Home+CoreDataClass.swift
//  HomeReport
//
//  Created by Marcelo Mogrovejo on 5/24/17.
//  Copyright © 2017 Marcelo Mogrovejo. All rights reserved.
//

import Foundation
import CoreData

@objc(Home)
public class Home: NSManagedObject {

    var soldPredicate: NSPredicate = NSPredicate(format: "isForSale = false")
    let request: NSFetchRequest<Home> = Home.fetchRequest()
    
    func getHomesByStatus(request: NSFetchRequest<Home>, moc: NSManagedObjectContext) -> [Home] {
        do {
            let homes = try moc.fetch(request)
            return homes
        } catch {
            fatalError("Error in getting list of homes")
        }
    }
    
    internal func getTotalHomeSales(moc: NSManagedObjectContext) -> String {
        request.predicate = soldPredicate
        request.resultType = .dictionaryResultType
        
        let sumExpressionDescription = NSExpressionDescription()
        sumExpressionDescription.name = "totalSales"
        sumExpressionDescription.expression = NSExpression(forFunction: "sum", arguments: [NSExpression(forKeyPath: "price")])
        sumExpressionDescription.expressionResultType = .doubleAttributeType
        
        request.propertiesToFetch = [sumExpressionDescription]
        
        do {
            let results = try moc.fetch(request as! NSFetchRequest<NSFetchRequestResult>) as! [NSDictionary]
            let dictionary = results.first!
            let totalSales = dictionary["totalSales"] as! Double
            
            return totalSales.currencyFormatter
        } catch {
            fatalError("Error getting total home sales")
        }
    }
    
}
