//
//  DetailNotificationViewController.swift
//  Mini Challenge 3
//
//  Created by Muhammad Reynaldi on 21/08/19.
//  Copyright © 2019 11. All rights reserved.
//

import UIKit
import CloudKit
class DetailNotificationViewController: UIViewController {

    // Variables
    var objPickUp:CKRecord?
    let cellID = "summaryCell"
    let cellImg = "cellImage"
    var detailPickUps = [CKRecord]()
    let database = CKContainer.init(identifier: "iCloud.Cls.MC3").publicCloudDatabase
    var tempImage = [UIImage]()
    let first = Int.random(in: 100000000..<10000000000)
    let second = Int.random(in: 0...10)
    let third = Int.random(in: 0...1000)
    
    //Outlets
    @IBOutlet weak var bookingID: UILabel!
    @IBOutlet weak var pickUpByLabel: UILabel!
    @IBOutlet weak var pickUpFromLabel: UILabel!
    @IBOutlet weak var pickUpAt: UILabel!
    @IBOutlet weak var totalBalanceLabel: UILabel!
    @IBOutlet weak var pickUpView: UIView!
    @IBOutlet weak var dot1: UIView!
    @IBOutlet weak var dot2: UIView!
    
    
    
    @IBOutlet weak var imageCV: UICollectionView!
    @IBOutlet weak var summaryTV: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setLabel()
        setView()
        setImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setLabel()
        setView()
        setImage()
    }
    
}
extension DetailNotificationViewController{
    func setLabel(){
        pickUpByLabel.text = objPickUp?["pickUpBy"]
        pickUpFromLabel.text = objPickUp?["pickUpFrom"]
        bookingID.text = "IOS-\(first)-\(second)-\(third)"
    }
    
    func setView(){
        pickUpView.setRoundedView()
        dot1.setRoundedView()
        dot2.setRoundedView()
        cellDelegate()
        cellDelegateCV()
    }
    
    func setImage(){
        if let data = objPickUp?["photoEvidence"] as? [CKAsset]{
            for i in data{
                if let img = i.toUIImage(){
                    tempImage.append(img)
                }
            }
        }
    }
    
    func setTotal(){
        
    }
    
    @objc func queryDatabase() {
        let query = CKQuery(recordType: "detailPickUp", predicate: NSPredicate(value: true))
        database.perform(query, inZoneWith: nil) { (records, error) in
            guard let records = records else {
                print("error",error)
                return }
            let sortedRecords = records.sorted(by: { $0.creationDate! > $1.creationDate! })
            self.detailPickUps = sortedRecords
            DispatchQueue.main.async {
                self.summaryTV.refreshControl?.endRefreshing()
                self.summaryTV.reloadData()
            }
        }
    }
}
extension DetailNotificationViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    func cellDelegateCV(){
        imageCV.dataSource = self
        imageCV.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tempImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellImg, for: indexPath) as! DetailImageCollectionViewCell
        cell.imageEvi.image = tempImage[indexPath.row]
        return cell
    }
    
    
}

extension DetailNotificationViewController:UITableViewDataSource,UITableViewDelegate{
    
    func cellDelegate(){
        summaryTV.dataSource = self
        summaryTV.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailPickUps.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! DetailActivityTableViewCell
        
        cell.jenisSampahLabel.text = (detailPickUps[indexPath.row].value(forKey: "listSampah") as! String)
        cell.beratSampahLabel.text = (detailPickUps[indexPath.row].value(forKey: "beratSampah") as! String)
        return cell
    }
    
}
