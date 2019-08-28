//
//  ListPriceTableViewCell.swift
//  Mini Challenge 3
//
//  Created by Muhammad Reynaldi on 23/08/19.
//  Copyright © 2019 11. All rights reserved.
//

import UIKit

class ListPriceTableViewCell: UITableViewCell {

    @IBOutlet weak var namaSampah: UILabel!
    @IBOutlet weak var hargaSampah: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
