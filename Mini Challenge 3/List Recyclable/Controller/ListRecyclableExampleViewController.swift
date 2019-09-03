//
//  ListRecyclableExampleViewController.swift
//  Mini Challenge 3
//
//  Created by Steven Gunawan on 31/08/19.
//  Copyright © 2019 11. All rights reserved.
//

import UIKit
import CloudKit

class ListRecyclableExampleViewController: UIViewController {
  
    var selectedIndex: Int = 0
    @IBOutlet weak var namaSampah: UILabel!
    @IBOutlet weak var hargaSampah: UILabel!
    @IBOutlet weak var listExample: UICollectionView!
    
    var listContohSampah: CKRecord?
    
    let cloudDatabase = CKContainer(identifier: "iCloud.Cls.MC3").publicCloudDatabase
    
//    var types = ["Plastic", "Paper", "Metal", "Glass", "Others"]
//    var contents : [[CKRecord]] = [[], [], [], [], []]
//    var i = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        queryDatabase()
        
        

//        for i in  0..<types.count{
//            getOne(type: types[i])
//        }
        
    
    }
    
            func queryDatabase() {
                let query = CKQuery(recordType: "Waste", predicate: NSPredicate(value: true))
                CKContainer.init(identifier: "iCloud.Cls.MC3").publicCloudDatabase.perform(query, inZoneWith: nil) { (records, _) in
                    guard let records = records else { return }
//                    let sortedRecords = records.sorted(by: { $1.modificationDate! > $0.modificationDate! })
//
//                    self.listContohSampah = sortedRecords
                    DispatchQueue.main.async {
//                         let harga = self.listContohSampah.first?.value(forKey: "wastePrice") as? Int
                        self.namaSampah.text = self.listContohSampah!["wasteName"]
//                            .first?.value(forKey: "wasteName") as? String
//                        self.hargaSampah.text = "Rp.\(harga ?? 0),-/kg"
                    }
                }
            }
    
//    func getOne(type: String){
//        let pred = NSPredicate(format: "wasteName IN %@", [type])
//        let query = CKQuery(recordType: "Waste", predicate: pred)
//        //                let sort = NSSortDescriptor(key: "lastModifiedUserRecordID", ascending: false)
//        //                query.sortDescriptors = [sort]
//        let queryOperation = CKQueryOperation (query: query)
//        queryOperation.recordFetchedBlock = {
//            record in
//            print("\(record)")
//
//            if let i = self.types.firstIndex(of: type){
//                self.contents[i].append(record)
//            }
////        }
//        queryOperation.queryCompletionBlock = {
//            queryCursor, error in
//            if error != nil {
//                print("\(String(describing: error))")
//            }
////            DispatchQueue.main.async {
////                self.listSampahTV.reloadData()
////            }
//        }
//        cloudDatabase.add(queryOperation)
//    }
    

//    
//    func getData() {
//        namaSampah.text =
//        hargaSampah.text =
//    }

    
 

}

//extension ListRecyclableExampleViewController: UICollectionViewDataSource, UICollectionViewDelegate {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
////        return listContohSampah.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listExample", for: indexPath) as! ListRecyclableExampleCollectionViewCell
//        
////        let harga = listContohSampah[indexPath.row].value(forKey: "wastePrice") as? Int
////        cell.hargaSampah.text = "Rp.\(harga ?? 0),-/kg"
////        cell.namaSampah.text = listSampah[indexPath.row].value(forKey: "wasteName") as? String
////        cell.gambarSampah.image = imageSampah
//        
//        return cell
//    }
//    
//    func cellDelegate() {
//        listExample.delegate = self
//        listExample.dataSource = self
//        
//    }
//    
//    
//    
//    
//    
//    
//}
