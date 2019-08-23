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
        cellDelegate()
        super.viewDidLoad()
    }
    

}
extension ListPriceViewController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
    func cellDelegate(){
        listPriceTableView.dataSource = self
        listPriceTableView.delegate = self
    }
}
