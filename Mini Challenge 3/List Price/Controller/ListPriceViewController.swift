//
//  ListPriceViewController.swift
//  Mini Challenge 3
//
//  Created by Muhammad Reynaldi on 23/08/19.
//  Copyright © 2019 11. All rights reserved.
//

import UIKit

class ListPriceViewController: UIViewController {
    
    // Variables
    let cellID = "listPrice"

    // OUtlets
    @IBOutlet weak var listPriceTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
}
