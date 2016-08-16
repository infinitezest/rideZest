//
//  ProductTableViewCell.swift
//  rideZest
//
//  Created by Ram Mareddy on 8/15/16.
//  Copyright © 2016 infiniteZest. All rights reserved.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    // ---------------------------------------------------------------------------------------------
    // MARK: Outlets
    
    /// Name of the product
    @IBOutlet weak var displayName: UILabel!
    /// Description of the product
    @IBOutlet weak var productDescription: UILabel!

    /// Image of the product.
    /// Only downloaded the first time it is accessed.
    @IBOutlet weak var productImage: UIImageView!

    /**
     Updates the controls in the cell. If the image is nil, the download from the server
     will be kicked off.
    */
    func updateControlsWithProduct(product: Product) {
        displayName.text = product.displayName
        productDescription.text = product.description
        
        if product.image == nil {
            // Fetch Image
        } else {
            productImage.image = product.image
        }
    }
}
