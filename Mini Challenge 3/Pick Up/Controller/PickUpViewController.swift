//
//  PickUpViewController.swift
//  Mini Challenge 3
//
//  Created by Muhammad Reynaldi on 21/08/19.
//  Copyright © 2019 11. All rights reserved.
//

import UIKit
import CloudKit
class PickUpViewController: UIViewController {
    
    // Variables
    var imageEvidence = [UIImage]()
    let cellID = "evidenceID"
    let database = CKContainer.init(identifier: "iCloud.Cls.MC3").publicCloudDatabase
    var mediaURL:NSURL?
    
    //Outlets
    @IBOutlet weak var addressTV: UITextView!
    @IBOutlet weak var evidenceCollectionView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellDelegate()
        imageEvidence.append(UIImage(named: "Add")!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setView()
        evidenceCollectionView.reloadData()
        navigationController?.navigationBar.isHidden = false
    }
    
    @objc func requestTapped(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        request()
    }
    
    
}
extension PickUpViewController{
    func saveUser(){
        let aldi = CKRecord(recordType: "User")
        
        aldi["name"] = "Aldi"
        aldi["address"] = "Taman Kencana Blok C4 No 11"
        aldi["balance"] = 100000
        
        database.save(aldi) { (record, error) in
            guard record != nil else { return }
            print("saved record")
        }
    }
    
    func setView(){
        self.navigationItem.title = "Pick Up"
        let request = UIBarButtonItem(title: "Request", style: .plain, target: self, action: #selector(requestTapped(_:)))
        self.navigationItem.rightBarButtonItem  = request
        self.navigationItem.rightBarButtonItem?.tintColor = #colorLiteral(red: 0.03574425727, green: 0.5716548562, blue: 0.3996006846, alpha: 1)
        self.navigationItem.leftBarButtonItem?.tintColor = #colorLiteral(red: 0.03574425727, green: 0.5716548562, blue: 0.3996006846, alpha: 1)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        addressTV.pickRound()
        addressTV.setShadowView()
    }
    
}

extension PickUpViewController:UICollectionViewDataSource, UICollectionViewDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func cellDelegate(){
        evidenceCollectionView.dataSource = self
        evidenceCollectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.imageEvidence.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! EvidenceCollectionViewCell
        cell.evidenceImage.image = imageEvidence[indexPath.row]
        cell.evidenceImage.littleRound()
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.row == 0{
            let imagePickerController = UIImagePickerController()
            imagePickerController.delegate = self
            
            let actionSheet = UIAlertController(title: "Photo Source", message: "Choose your photo evidence ", preferredStyle: .actionSheet)
            
            actionSheet.addAction(.init(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            }))
            actionSheet.addAction(.init(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
                imagePickerController.sourceType = .photoLibrary
                self.present(imagePickerController, animated: true, completion: nil)
            }))
            actionSheet.addAction(.init(title: "Cancel", style: .cancel, handler: nil))
            
            self.present(actionSheet, animated: true, completion: nil)
        }else{
            
        }
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        self.imageEvidence.append(image)
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func request(){
        //Image
        let data = imageEvidence.first!.jpegData(compressionQuality: 1.0)
        let url = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(NSUUID().uuidString+".dat")
        do {
            try data!.write(to: url!, options: [])
        } catch let e as NSError {
            print("Error! \(e)");
            return
        }
        //Get Referemce
        let userId = CKRecord.ID(recordName: "4DD23698-1376-452F-9FA8-06C63E1E6D85")
        
        let newPickUp = CKRecord(recordType: "PickUp")
        newPickUp["photoEvidence"] = CKAsset(fileURL: url!)
        newPickUp["idUser"] = CKRecord.Reference(recordID: userId, action: CKRecord_Reference_Action.none)
        newPickUp["pickUpFrom"] = addressTV.text
        
        database.save(newPickUp) { (record, erro) in
            do { try FileManager.default.removeItem(at: url!) }
            catch let e { print("Error deleting temp file: \(e)") }
            
           
            guard record != nil else { return }
            print("saved request")
        }
    }
        
    
}
