//
//  ListRecyclableTableViewCell.swift
//  Mini Challenge 3
//
//  Created by Steven Gunawan on 23/08/19.
//  Copyright © 2019 11. All rights reserved.
//

import UIKit
import CloudKit

class ListRecyclableTableViewCell: UITableViewCell {
    
    var listSampah = [CKRecord]()
    var imageSampah = [UIImage]()
    let cloudDatabase = CKContainer(identifier: "iCloud.Cls.MC3").publicCloudDatabase
    weak var delegate2 : recycleDelegate?
    var openCity : CKRecord?
    
    @IBOutlet weak var listSampahCV: UICollectionView!
    @IBOutlet weak var jenisSampah: UILabel!
    
    override func awakeFromNib() {
        listSampahCV.delegate = self
        listSampahCV.dataSource = self
        
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
//    func setImage(){
//        for i in listSampah {
//            if let data = i["wastePictures"] as? [CKAsset] {
//                print("WOi")
//                for i in data{
//                    if let img = i.toUIImage(){
//                        imageSampah.append(img)
//                    }
//                }
//            }
//        }
//    }
//    
//    @objc func queryDatabase() {
//        let query = CKQuery(recordType: "Waste", predicate: NSPredicate(value: true))
//        cloudDatabase.perform(query, inZoneWith: nil) { (records, error) in
//            guard let records = records else {
//                print("error",error)
//                return }
//            let sortedRecords = records.sorted(by: { $0.creationDate! > $1.creationDate! })
//            self.listSampah = sortedRecords
//            DispatchQueue.main.async {
////                self.setImage()
//                self.listSampahCV.reloadData()
//            }
//        }
//    }
    
}

extension ListRecyclableTableViewCell:UICollectionViewDataSource,UICollectionViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listSampah.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LRecyclableCVCell", for: indexPath) as! ListRecyclableCollectionViewCell
        
        let harga = listSampah[indexPath.row].value(forKey: "wastePrice") as? Int
        cell.hargaSampah.text = "Rp.\(harga ?? 0),-/kg"
        cell.namaSampah.text = listSampah[indexPath.row].value(forKey: "wasteName") as? String
//        cell.gambarSampah.image = imageSampah[indexPath.row]
        if let data = listSampah[indexPath.row].value(forKey: "wastePictures") as? CKAsset,
            let img = data.toUIImage() {
            cell.gambarSampah.image = img
        }
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let cellsAcross: CGFloat = 3
        let spaceBetweenCells: CGFloat = 5
        let dim = (collectionView.bounds.width - (cellsAcross - 1) * spaceBetweenCells) / cellsAcross
        return CGSize(width: dim, height: dim)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate2!.openCity(listSampah[indexPath.row])
    }
    
}


