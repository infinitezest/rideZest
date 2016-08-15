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
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
