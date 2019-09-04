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
    
    var objListSampah:CKRecord?
    
    var selectedIndex: Int = 0
    
    @IBOutlet weak var namaSampah: UILabel!
    @IBOutlet weak var hargaSampah: UILabel!
    @IBOutlet weak var gambarSampah: UIImageView!
    @IBOutlet weak var listExample: UICollectionView!
    
    @IBOutlet weak var kotakHitam: UIView!
    @IBOutlet weak var buttonBack: UIButton!
    
    var listContohSampah = [CKRecord]()
    var contohImageSampah = [UIImage]()
    let cloudDatabase = CKContainer(identifier: "iCloud.Cls.MC3").publicCloudDatabase
//    var types = ["Clean Plastic Cup", "Bucket", "Plastic Bottle", "Plastic Bag", "Book/Magazine", "Carton", "HVS Paper", "Tin/Iron Sheeting", "Cooper", "Glass Bottle", "CD/ Cable", "Storage Battery", "Carpet"]
//    var contents : [[CKRecord]] = [[], [], [], [], [], [], [], [], [], [], [], [], [], [], []]
   
    let imagee: [UIImage] = [
        UIImage(named: "p1")!,
        UIImage(named: "p2")!,
        UIImage(named: "p3")!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        queryDatabase()
        setLabel()
        setImage()
        setTitleImage()
        print("Lol")
        cellDelegate()
        buttonBack.setRoundedView()
        buttonBack.setShadowButton()
        
        gambarSampah.roundCorners([.bottomRight], radius: 74)
        kotakHitam.roundCorners([.bottomRight], radius: 74)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func buttonBack(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func queryDatabase() {
        let query = CKQuery(recordType: "Waste", predicate: NSPredicate(value: true))
        cloudDatabase.perform(query, inZoneWith: nil) { (records, error) in
            guard let records = records else {
                print("error",error)
                return
                
            }
//            let sortedRecords = records.sorted(by: { $0.creationDate! > $1.creationDate! })
//            self.listSampah = sortedRecords
            self.listContohSampah = records
            DispatchQueue.main.async {
                //                self.setImage()
                self.listExample.reloadData()
            }
        }
    }
    
    func setLabel(){
        var harga = objListSampah?.value(forKey: "wastePrice") as! Int
        namaSampah.text = objListSampah?.value(forKey: "wasteName") as! String
        hargaSampah.text = "Rp.\(harga ?? 0),-/kg"
    }
    
    func setTitleImage(){
        let data = objListSampah?["wastePictures"] as? CKAsset
        gambarSampah.image = data?.toUIImage()
    }
    
    func setImage(){
        if let data = objListSampah?["wastePictureExample"] as? [CKAsset]{
            contohImageSampah.removeAll()
            for i in data{
                if let img = i.toUIImage(){
                    contohImageSampah.append(img)
                }
            }
        }
    }
}

extension ListRecyclableExampleViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contohImageSampah.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "listExample", for: indexPath) as! ListRecyclableExampleCollectionViewCell
        
//        cell.gambarExample.image = imagee[indexPath.row]
        
//        if let data = listContohSampah[indexPath.row].value(forKey: "wastePictureExample") as? [CKAsset],
//            let img = data.first?.toUIImage() {
//            cell.gambarExample.image = img
//        }
        
        cell.gambarExample.image = contohImageSampah[indexPath.row]
        
        return cell
    }
    
    func cellDelegate() {
        listExample.delegate = self
        listExample.dataSource = self
        
    }

}
