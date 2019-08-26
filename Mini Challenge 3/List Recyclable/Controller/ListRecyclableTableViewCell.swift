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
    @IBOutlet weak var listSampahCV: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        queryDatabase()

        // Configure the view for the selected state
    }

    func queryDatabase() {
        let query = CKQuery(recordType: "Waste", predicate: NSPredicate(value: true))
        CKContainer.init(identifier: "iCloud.Cls.MC3").publicCloudDatabase.perform(query, inZoneWith: nil) { (records, _) in
            guard let records = records else { return }
            //            print(records)
            let sortedRecords = records.sorted(by: { $1.modificationDate! > $0.modificationDate! })
            self.listSampah = sortedRecords
            DispatchQueue.main.async {
                self.listSampahCV.reloadData()
            }
        }
    }
    
}


extension ListRecyclableTableViewCell:UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listSampah.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listJenisSampah", for: indexPath) as! ListRecyclableCollectionViewCell
        
        cell.jenisSampah.text = listSampah[indexPath.row].value(forKey: "wasteCategory") as? String
//        cell.gambarSampah.image = listSampah[indexPath.row].value(forKey: "wastePicture") as? UIImage
        return cell
    }
    
    //    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //
    //    }
    
    func cellDelegate2(){
        listSampahCV.dataSource =  self
        listSampahCV.delegate = self
    }
}
