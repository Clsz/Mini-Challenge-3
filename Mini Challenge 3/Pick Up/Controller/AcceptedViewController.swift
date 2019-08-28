//
//  AcceptedViewController.swift
//  Mini Challenge 3
//
//  Created by Muhammad Reynaldi on 28/08/19.
//  Copyright © 2019 11. All rights reserved.
//

import UIKit

class AcceptedViewController: UIViewController {

    @IBOutlet weak var okButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        okButton.acceptRound()
    }
    
    @IBAction func okTapped(_ sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
