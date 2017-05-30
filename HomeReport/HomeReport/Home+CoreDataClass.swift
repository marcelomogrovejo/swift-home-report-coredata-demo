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

    func getHomesByStatus(isForSale: Bool, moc: NSManagedObjectContext) -> [Home] {
        let request: NSFetchRequest<Home> =  Home.fetchRequest()
        request.predicate = NSPredicate(format: "isForSale  = %@", isForSale as CVarArg)
        
        do {
            let homes = try moc.fetch(request)
            return homes
        } catch {
            fatalError("Error in getting list of homes")
        }
        
    }
}
