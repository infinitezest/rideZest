//
//  Products.swift
//  rideZest
//
//  Created by Ram Mareddy on 8/15/16.
//  Copyright © 2016 infiniteZest. All rights reserved.
//

import UIKit

/**
 Holds information about a single product.
 */
class Product {
    
    /// Name of the product, e.g. UberTAXI
    var displayName: String
    /// Description of the product, e.g. Taxi without the hassle
    var description: String
    
    /// Path of the image on CloudFront
    var imagePath: String
    /// The image fetched from the server
    /// This is non-null only when explicitly fetched
    var image: UIImage?
    
    /**
     Initializes individual product, without image.
    */
    init(displayName: String, description: String, imagePath: String) {
        self.displayName = displayName
        self.description = description
        self.imagePath = imagePath
    }
}

/**
 List of products available at a particular location.
 */
class Products {

    /// Singleton for products.
    /// Products are fetched only once
    static let shared = Products()
    
    // ---------------------------------------------------------------------------------------------
    // MARK: Product Array
    
    /// Array of individual Product objects.
    /// Private, access is through count and subscript.
    private var products = [Product]()
    
    func count()->Int {
        return products.count
    }
    
    subscript(index: Int)->Product {
        return products[index]
    }

    // ---------------------------------------------------------------------------------------------
    // MARK: Initialization
    
    /**
     Products are fetched at the initialization. Since access to this class is via singleton object,
     this is done only once.
     */
    init() {
        fetchProducts()
    }

    /**
     Products are fetched from the server. They are processed into Product objects and a notification
     is posted for the dependent objects to refresh themselves.
     */
    func fetchProducts() {
        Server.shared.fetchProducts { (productArray) in

            guard let productArray = productArray else {
                print("Empty Products")
                return
            }
            
            for productJSON in productArray {
                guard let product = productJSON as? [String: AnyObject] else {
                    print("Empty product")
                    continue
                }
                guard let
                    displayName = product["display_name"] as? String,
                    description = product["description"] as? String,
                    imagePath = product["image"] as? String else {
                        print("Missing values in Product")
                        continue
                }
                let prod = Product(displayName: displayName, description: description, imagePath: imagePath)
                self.products.append(prod)
            }
            
            // Products are fetched and processed
            NSNotificationCenter.defaultCenter().postNotificationName("ProductsFetchedNotification", object: nil)
        }
    }
}
