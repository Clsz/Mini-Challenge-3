//
//  ListRecyclableViewController.swift
//  Mini Challenge 3
//
//  Created by Muhammad Reynaldi on 21/08/19.
//  Copyright © 2019 11. All rights reserved.
//

import UIKit
import CloudKit

protocol ReusableViewEnum {}
class ListRecyclableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    var plasticImageArray = [String]()
    var metalImageArray = [String]()
    var paperImageArray = [String]()
    var glassImageArray = [String]()
    var othersImageArray = [String]()
    
    var listNamaSampah = [CKRecord]()
    let  cellList = "listSampah"
    var name = [String]()
    var price = [String]()
    var type = [String]()
    
    var  category = [String]()
    var categoryPlastik = [String]()
    var categoryMetal = [String]()
    var categoryPaper = [String]()
    var categoryGlass = [String]()
    var categoryOthers = [String]()
    
    
    @IBOutlet weak var listSampahTV: UITableView!
    
    override func viewDidLoad() {
        //        queryDatabase()
        self.navigationItem.title = "Recyclable List"
        super.viewDidLoad()
        //       cellDelegate()
        
        category =  ["plastik","metal","paper","glass","others"]
        categoryPlastik = [""]
        categoryMetal = [""]
        categoryPaper = [""]
        categoryGlass = [""]
        categoryOthers = [""]
        
        plasticImageArray = ["p1","p2","p3","p4"]
        metalImageArray = ["m1","m2","m3","m4"]
        paperImageArray = ["pa1","pa2","pa3"]
        glassImageArray = ["g1"]
        othersImageArray = ["o1","o2","o3"]
        
        
        type = ["Plastik","Metal","Fire","Water","Paper"]
        name = ["plastik","metal","fire","water","paper"]
        price = ["plastik","metal","fire","water","paper"]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return plasticImageArray.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "LRecyclableTVCell", for: indexPath) as! ListRecyclableTableViewCell
        
        cell.jenisSampah.text = type[indexPath.row]
        cell.listSampahCV.reloadData()
        
        
        return cell
        
    }
    
    //    func queryDatabase() {
    //        let query = CKQuery(recordType: "Waste", predicate: NSPredicate(value: true))
    //        CKContainer.init(identifier: "iCloud.Cls.MC3").publicCloudDatabase.perform(query, inZoneWith: nil) { (records, _) in
    //            guard let records = records else { return }
    //            let sortedRecords = records.sorted(by: { $1.modificationDate! > $0.modificationDate! })
    //            self.listNamaSampah = sortedRecords
    //            DispatchQueue.main.async {
    //                self.listSampahTV.reloadData()
    //            }
    //        }
    //    }
    
    
}

extension ListRecyclableViewController: UICollectionViewDataSource, UICollectionViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return plasticImageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LRecyclableCVCell", for: indexPath) as! ListRecyclableCollectionViewCell
        //
        //        let harga = listNamaSampah[indexPath.row].value(forKey: "wastePrice") as? Int
        //        cell.hargaSampah.text = "Rp.\(harga ?? 0),-/kg"
        //        cell.namaSampah.text = listNamaSampah[indexPath.row].value(forKey: "wasteName") as? String
        //
        //
        cell.gambarSampah.image = UIImage(named: plasticImageArray[indexPath.row])
        cell.namaSampah.text = name[indexPath.row]
        cell.hargaSampah.text = price[indexPath.row]
        return cell
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellsAcross: CGFloat = 3
        let spaceBetweenCells: CGFloat = 5
        let dim = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
        return CGSize(width: dim, height: dim)
        
    }
    
    
    
}


//extension ListRecyclableViewController: UICollectionViewDataSource,UICollectionViewDelegate{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return listSampah.count
//    }
//
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listJenisSampah", for: indexPath) as! ListRecyclableCollectionViewCell
//
//        cell.jenisSampah.text = listSampah[indexPath.row].value(forKey: "wasteCategory") as? String
//
//        //        cell.gambarSampah.image = listSampah[indexPath.row].value(forKey: "wastePicture") as? UIImage
//        return cell
//    }
//}
//
//extension ListRecyclableViewController:UITableViewDataSource, UITableViewDelegate{
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellList, for: indexPath).view
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 5
//    }
//
//    func cellDelegate(){
//        listSampahTV.dataSource = self
//        listSampahTV.delegate = self
//    }
//
//}

