//
//  ListRecyclableViewController.swift
//  Mini Challenge 3
//
//  Created by Muhammad Reynaldi on 21/08/19.
//  Copyright © 2019 11. All rights reserved.
//

import UIKit
import CloudKit

protocol recycleDelegate : AnyObject{
    func openCity(_ city : CKRecord)
}

class ListRecyclableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, recycleDelegate {
    
    
    let cloudDatabase = CKContainer(identifier: "iCloud.Cls.MC3").publicCloudDatabase
    var segueIndex:Int = 0
    let cellList = "listSampah"
    var listSampah = [CKRecord]()
    var types = ["Plastic", "Paper", "Metal", "Glass", "Others"]
    var contents : [[CKRecord]] = [[], [], [], [], []]
    var dex = 0
    var  indexx:Int?
    var tempCity : CKRecord?
    
    
    @IBOutlet weak var listSampahTV: UITableView!
    
    override func viewDidLoad() {
        //                queryDatabase()
        self.navigationItem.title = "Recyclable List"
        loading()
        
        super.viewDidLoad()
        //
        //        setImage()
        
        for i in  0..<types.count{
            getOne(type: types[i])
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contents.count-1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "LRecyclableTVCell", for: indexPath) as! ListRecyclableTableViewCell
        
        cell.jenisSampah.text = types[indexPath.row]
        cell.listSampah = contents[indexPath.row]
        cell.listSampahCV.reloadData()
        
        cell.delegate2 = self
        
        
        return cell
        
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
    
    func getOne(type: String){
        print(#function)
        let pred = NSPredicate(format: "wasteCategory IN %@", [type])
        let query = CKQuery(recordType: "Waste", predicate: pred)
        //                let sort = NSSortDescriptor(key: "lastModifiedUserRecordID", ascending: false)
        //                query.sortDescriptors = [sort]
        let queryOperation = CKQueryOperation (query: query)
        //        queryOperation.desiredKeys = ["wasteName"]
        queryOperation.recordFetchedBlock = {
            record in
            print(record)
            
            if let i = self.types.firstIndex(of: type){
                self.contents[i].append(record)
            }
        }
        queryOperation.queryCompletionBlock = {
            queryCursor, error in
            
            if error != nil {
                print("\(String(describing: error))")
            }
            
            self.dex += 1
            
            if self.dex == self.types.count {
                print(self.contents)
                DispatchQueue.main.async {
                    self.listSampahTV.reloadData()
                    self.dismiss(animated: false, completion: nil)
                }
            }
            
        }
        cloudDatabase.add(queryOperation)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let sampahExample = segue.destination as! ListRecyclableExampleViewController
        
        //        if let indexPath = listSampah.indexPathForSelectedRow{
        let sampah = tempCity
        sampahExample.objListSampah = sampah
        //        }
    }
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        let detailNotification = segue.destination as! DetailNotificationViewController
    //        if let indexPath = pickUpTV.indexPathForSelectedRow{
    //            let sampah = pickups[indexPath.row]
    //            detailNotification.objPickUp = sampah
    //        }
    //    }
    
    
    func openCity(_ city: CKRecord) {
        tempCity = city
        //        print(tempString)
        //        if segueIndex >= 0 {
        //            selectIndex()
        performSegue(withIdentifier: "goToExamplePage", sender: self)
        //        }
    }
    //
    //    func selectIndex() {
    //        for index in 0...contents.count-1 {
    //            if tempString == "\(index)" {
    //                segueIndex = index
    //            }
    //        }
    //    }
    
}


