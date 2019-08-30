//
//  ListRecyclableViewController.swift
//  Mini Challenge 3
//
//  Created by Muhammad Reynaldi on 21/08/19.
//  Copyright © 2019 11. All rights reserved.
//

import UIKit
import CloudKit

class ListRecyclableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    let cloudDatabase = CKContainer(identifier: "iCloud.Cls.MC3").publicCloudDatabase
    var listNamaSampah = [CKRecord]()
    var sampahGambar = [UIImage]()
    
    let  cellList = "listSampah"
    
    var types = ["Plastic", "Paper", "Metal", "Glass", "Others"]
    var contents : [[CKRecord]] = [[], [], [], [], []]
    var i = 0
    
    @IBOutlet weak var listSampahTV: UITableView!
    
    override func viewDidLoad() {
        //                queryDatabase()
        self.navigationItem.title = "Recyclable List"
        super.viewDidLoad()
        
        setImage()
        
        for i in  0..<types.count{
            getOne(type: types[i])
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "LRecyclableTVCell", for: indexPath) as! ListRecyclableTableViewCell
 
        cell.jenisSampah.text = types[indexPath.row]
        cell.listSampah = contents[indexPath.row]
        cell.imageSampah = sampahGambar[indexPath.row]
        
        DispatchQueue.main.async {
            
            cell.listSampahCV.reloadData()
        }
        
        
        return cell
        
    }
    
    //        func queryDatabase() {
    //            let query = CKQuery(recordType: "Waste", predicate: NSPredicate(value: true))
    //            CKContainer.init(identifier: "iCloud.Cls.MC3").publicCloudDatabase.perform(query, inZoneWith: nil) { (records, _) in
    //                guard let records = records else { return }
    //                let sortedRecords = records.sorted(by: { $1.modificationDate! > $0.modificationDate! })
    //                self.listNamaSampah = sortedRecords
    //                DispatchQueue.main.async {
    //                    self.listSampahTV.reloadData()
    //                }
    //            }
    //        }
    
    func getOne(type: String){
        let pred = NSPredicate(format: "wasteCategory IN %@", [type])
        let query = CKQuery(recordType: "Waste", predicate: pred)
        //        let sort = NSSortDescriptor(key: "lastModifiedUserRecordID", ascending: false)
        //        query.sortDescriptors = [sort]
        let queryOperation = CKQueryOperation (query: query)
        queryOperation.recordFetchedBlock = {
            record in
            print("\(record)")
            
            if let i = self.types.firstIndex(of: type){
                self.contents[i].append(record)
            }
        }
        queryOperation.queryCompletionBlock = {
            queryCursor, error in
            if error != nil {
                print("\(String(describing: error))")
            }
            DispatchQueue.main.async {
                self.listSampahTV.reloadData()
            }
        }
        cloudDatabase.add(queryOperation)
    }
    
    func setImage(){
        for i in listNamaSampah {
            if let data = i["wastePictures"] as? [CKAsset] {
                for i in data{
                    if let img = i.toUIImage(){
                        sampahGambar.append(img)
                    }
                }
            }
        }
    }
}


