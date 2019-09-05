//
//  ListPriceViewController.swift
//  Mini Challenge 3
//
//  Created by Muhammad Reynaldi on 23/08/19.
//  Copyright © 2019 11. All rights reserved.
//

import UIKit
import CloudKit

class ListPriceViewController: UIViewController {
    
    // Variables
    let cellID = "listPrice"
    let cloudDatabase = CKContainer.default().publicCloudDatabase

    
    var listPrice = [CKRecord]()
    

    // OUtlets
    @IBOutlet weak var listPriceTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellDelegate()
        queryDatabase()
        loading()
        
        self.navigationItem.title = "Price List"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden  = false
    }
    
    func loading() {
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    func queryDatabase() {
        let query = CKQuery(recordType: "Waste", predicate: NSPredicate(value: true))
        CKContainer.init(identifier: "iCloud.Cls.MC3").publicCloudDatabase.perform(query, inZoneWith: nil) { (records, _) in
            guard let records = records else { return }
//            print(records)
            let sortedRecords = records.sorted(by: { $1.modificationDate! > $0.modificationDate! })
            self.listPrice = sortedRecords
            DispatchQueue.main.async {
                self.listPriceTableView.reloadData()
                self.dismiss(animated: false, completion: nil)
            }
        }
    }
        
    
    }
    
    
    

extension ListPriceViewController:UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listPrice.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ListPriceTableViewCell
        let harga = listPrice[indexPath.row].value(forKey: "wastePrice") as? Int
        cell.namaSampah.text = listPrice[indexPath.row].value(forKey: "wasteName") as? String
        cell.hargaSampah.text = "Rp.\(harga ?? 0),-/kg"
        return cell
    }
    
    func cellDelegate(){
        listPriceTableView.dataSource = self
        listPriceTableView.delegate = self
    }
    
    
    
}
