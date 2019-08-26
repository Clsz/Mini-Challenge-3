//
//  DetailActivityTableViewCell.swift
//  Mini Challenge 3
//
//  Created by Muhammad Reynaldi on 25/08/19.
//  Copyright © 2019 11. All rights reserved.
//

import UIKit

class DetailActivityTableViewCell: UITableViewCell {

    @IBOutlet weak var jenisSampahLabel: UILabel!
    @IBOutlet weak var beratSampahLabel: UILabel!
    @IBOutlet weak var hargaSampahLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
