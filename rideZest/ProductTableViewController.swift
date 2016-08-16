//
//  ProductTableViewController.swift
//  rideZest
//
//  Created by Ram Mareddy on 8/15/16.
//  Copyright © 2016 infiniteZest. All rights reserved.
//

import UIKit

class ProductTableViewController: UITableViewController {

    /// Observer for the products fetched notification
    /// This needs to be release when the instance of this class removed from memory
    var productsFetchedNotificationObserver: AnyObject?
   
    /**
     When products are fetched from the server, the table view needs to be reloaded on the main queue.
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        productsFetchedNotificationObserver = NSNotificationCenter.defaultCenter().addObserverForName("ProductsFetchedNotification",
                                                                object: nil, queue: NSOperationQueue.mainQueue()) { (notification) in
            self.tableView.reloadData()
        }
    }

    /**
     Remove the notification observers at the time of deinitialization.
     */
    deinit {
        if let productsFetchedNotificationObserver = productsFetchedNotificationObserver {
            NSNotificationCenter.defaultCenter().removeObserver(productsFetchedNotificationObserver)
        }
    }
    
    // ---------------------------------------------------------------------------------------------
    // MARK: Table view data source

    /**
     All the products are shown in a single section.
     */
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    /**
     At the beginning the count of products is 0. But this will change after the products are fetched
     from the server.
     */
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Products.shared.count()
    }

    /**
     Product Table View cell is updated with the values from the Product object at the right index.
     */
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as? ProductTableViewCell else {
            return ProductTableViewCell()
        }
        cell.updateControlsWithProduct(Products.shared[indexPath.row])
        return cell
    }
}
