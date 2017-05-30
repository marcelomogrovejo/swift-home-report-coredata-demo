//
//  HomeListViewController.swift
//  HomeReport
//
//  Created by Marcelo Mogrovejo on 5/29/17.
//  Copyright © 2017 Marcelo Mogrovejo. All rights reserved.
//

import UIKit
import CoreData

class HomeListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: Outlets
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!

    // MARK: Properties
    
    weak var managedObjectContext: NSManagedObjectContext! {
        // Set the home inmediatly
        didSet {
            return home = Home(context: managedObjectContext)
        }
    }
    lazy var homes = [Home]()
    var home: Home? = nil
    var isForSale: Bool = true
    var selectedHome: Home?
    var sortDescriptor = [NSSortDescriptor]()
    var searchPredicate: NSPredicate?
    var request: NSFetchRequest<Home>?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        request = Home.fetchRequest()
        
        loadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Action methods
    
    @IBAction func segmentedAction(_ sender: UISegmentedControl) {
        let selectedValue = sender.titleForSegment(at: sender.selectedSegmentIndex)
        isForSale = selectedValue == "For Sale" ? true : false
        loadData()
    }

    // MARK: UITableViewDataSource methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return homes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "homeCell", for: indexPath) as! HomeListTableViewCell
        
        let currentHome = homes[indexPath.row]
        cell.configureCell(home: currentHome)
        
        return cell
    }
    
    // MARK: Private methods
    
    private func loadData() {
        var predicates = [NSPredicate]()
        
        let statusPredicate = NSPredicate(format: "isForSale = %@", isForSale as CVarArg)
        predicates.append(statusPredicate)
        
        if let additionalPredicate = searchPredicate {
            predicates.append(additionalPredicate)
        }
        let predicate = NSCompoundPredicate(type: .and, subpredicates: predicates)
        request?.predicate = predicate
        
        if sortDescriptor.count > 0 {
            request?.sortDescriptors = sortDescriptor
        }
        
        homes = home!.getHomesByStatus(request: request!, moc: managedObjectContext)
        tableView.reloadData()
    }
    
    // MARK: Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segueHistory" {
            let selectedIndexPath = tableView.indexPathForSelectedRow
            selectedHome = homes[selectedIndexPath!.row]
            
            let destinationController = segue.destination as! SaleHistoryViewController
            destinationController.home = selectedHome
            destinationController.managedObjectContext = managedObjectContext
        } else if segue.identifier == "segueToFilter" {
            // Reset the filters at the first time
            sortDescriptor = []
            searchPredicate = nil
            
            let controller = segue.destination as! FilterTableViewController
            // HomeListViewController will be the delegate for FilterTableViewController
            controller.delegate = self
        }
    }
    
}

// Implement the protocol defined on FilterTableViewController

extension HomeListViewController: FilterTableViewControllerDelegate {
    
    func updateHomeList(filterBy: NSPredicate?, sortBy: NSSortDescriptor?) {
        if let filter = filterBy {
            searchPredicate = filter
        }
        if let sort = sortBy {
            sortDescriptor.append(sort)
        }
    }
}
