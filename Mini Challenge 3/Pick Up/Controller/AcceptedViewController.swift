//
//  AcceptedViewController.swift
//  Mini Challenge 3
//
//  Created by Muhammad Reynaldi on 28/08/19.
//  Copyright © 2019 11. All rights reserved.
//

import UIKit

class AcceptedViewController: UIViewController {
    
    
    let segue = "backToRoot"
    
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var viewOutter: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        okButton.acceptRound()
        viewOutter.accRound()
        viewOutter.shadow()
    }
    
    @IBAction func okTapped(_ sender: UIButton) {
       performSegue(withIdentifier: segue, sender: nil)
    }
}
