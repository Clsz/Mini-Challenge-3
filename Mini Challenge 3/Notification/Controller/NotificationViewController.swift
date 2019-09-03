//
//  NotificationViewController.swift
//  Mini Challenge 3
//
//  Created by Muhammad Reynaldi on 21/08/19.
//  Copyright © 2019 11. All rights reserved.
//

import UIKit
import CloudKit
class NotificationViewController: UIViewController {

    // Variables
    let cellID = "activityID"
    let segue = "goToDetailNotification"
    let database = CKContainer.init(identifier: "iCloud.Cls.MC3").publicCloudDatabase
    var pickups = [CKRecord]()
    
    
    
    //Outlets
    @IBOutlet weak var pickUpTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellDelegate()
        refresh()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        queryDatabase()
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailNotification = segue.destination as! DetailNotificationViewController
        if let indexPath = pickUpTV.indexPathForSelectedRow{
            let pickup = pickups[indexPath.row]
            detailNotification.objPickUp = pickup
        }
    }
    
}

extension NotificationViewController{
    func refresh(){
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(queryDatabase), for: .valueChanged)
        self.pickUpTV.refreshControl = refreshControl
    }
    
    @objc func queryDatabase() {
        let query = CKQuery(recordType: "PickUp", predicate: NSPredicate(value: true))
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let records = records else {
                print("error",error)
                return }
            let sortedRecords = records.sorted(by: { $0.creationDate! > $1.creationDate! })
            self.pickups = sortedRecords
            DispatchQueue.main.async {
                self.pickUpTV.refreshControl?.endRefreshing()
                self.pickUpTV.reloadData()
            }
        }
    }
    
}

extension NotificationViewController:UITableViewDataSource, UITableViewDelegate{
    
    func cellDelegate(){
        pickUpTV.dataSource = self
        pickUpTV.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pickups.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ActivityTableViewCell
        cell.statusLabel.text = (pickups[indexPath.row].value(forKey: "pickUpStatus") as! String)
        cell.dateLabel.text = (pickups[indexPath.row].value(forKey: "createdAt") as? String)
        cell.pickUpByLabel.text = (pickups[indexPath.row].value(forKey: "pickUpBy") as! String)
        cell.pickUpFrom.text = (pickups[indexPath.row].value(forKey: "pickUpFrom") as! String)
//        cell.dateLabel.text = pickups[indexPath.row]
        
        cell.outerView.littleRoundView()
        cell.outerView.shadowActivity()
        cell.statusView.statusRound()
        cell.pickUpByView.setRoundedView()
        cell.dot1.setRoundedView()
        cell.dot2.setRoundedView()
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: segue, sender: self)
    }
    
}

