//
//  ActivityTableViewCell.swift
//  Mini Challenge 3
//
//  Created by Muhammad Reynaldi on 22/08/19.
//  Copyright © 2019 11. All rights reserved.
//

import UIKit

class ActivityTableViewCell: UITableViewCell {

    @IBOutlet weak var outerView: UIView!
    @IBOutlet weak var statusView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var pickUpByView: UIView!
    @IBOutlet weak var pickUpByLabel: UILabel!
    @IBOutlet weak var dot1: UIView!
    @IBOutlet weak var dot2: UIView!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var pickUpFrom: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

}
