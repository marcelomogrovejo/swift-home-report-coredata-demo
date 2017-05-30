//
//  SaleHistoryViewController.swift
//  HomeReport
//
//  Created by Marcelo Mogrovejo on 5/30/17.
//  Copyright © 2017 Marcelo Mogrovejo. All rights reserved.
//

import UIKit
import CoreData

class SaleHistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: Outles
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Properties
    
    lazy var soldHistory = [SaleHistory]()
    var home: Home?
    weak var managedObjectContext: NSManagedObjectContext!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadSoldHistory()
        
        if let homeImage = home!.image {
            let image = UIImage(data: homeImage as Data)
            imageView.image = image
            imageView.layer.borderWidth = 1
            imageView.layer.cornerRadius = 4
        }
        
        tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UITableViewDataSource methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return soldHistory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "historyCell", for: indexPath) as! SaleHistoryTableViewCell
        
        let saleHistory = soldHistory[indexPath.row]
        cell.configureCell(saleHistory: saleHistory)
        
        return cell
    }
    
    // MARK: Private methods
    
    private func loadSoldHistory() {
        let saleHistory = SaleHistory(context: managedObjectContext)
        soldHistory = saleHistory.getSoldHistory(home: home!, moc: managedObjectContext)
        
        tableView.reloadData()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
