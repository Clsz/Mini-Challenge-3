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
    let segue = "goToAccept"
    let segue1 = "goToMap"
    var imageEvidence = [UIImage]()
    var tempImage = [CKAsset]()
    let cellID = "cellEvidence"
    let database = CKContainer.init(identifier: "iCloud.Cls.MC3").publicCloudDatabase
    var mediaURL:NSURL?
    var accessoryDoneButton: UIBarButtonItem!
    let accessoryToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
    let flexiblea = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    
    //Outlets
    @IBOutlet weak var addressTF: UITextField!
    @IBOutlet weak var evidenceCollectionView: UICollectionView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellDelegate()
        imageEvidence.append(UIImage(named: "Add")!)
        setView()
        setDoneOnKeyboard()
        addGesture()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setView()
        evidenceCollectionView.reloadData()
        navigationController?.navigationBar.isHidden = false
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    @objc func requestTapped(_ sender: UIButton) {
        performSegue(withIdentifier: segue, sender: self)
        request()
    }
    
    @IBAction func unwindToPickup(_ unwindSegue: UIStoryboardSegue) {
        if let sourceViewController = unwindSegue.source as? SelectMapViewController{
            if let a = sourceViewController.mapAddress.text{
                addressTF.text = a
            }
        }
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
        view1.pickRound()
        view2.pickRound()
        addressTF.roundPick()
        addressTF.shadows()
    }
    
    func setDoneOnKeyboard() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(PickUpViewController.dismissKeyboard))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        self.addressTF.inputAccessoryView = keyboardToolbar
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
        
    func addGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addressTapped(tapGesture:)))
            
        addressTF.isUserInteractionEnabled = true
        addressTF.addGestureRecognizer(tapGesture)
    }
    
    @objc func addressTapped(tapGesture: UITapGestureRecognizer){
        performSegue(withIdentifier: segue1, sender: nil)
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
//        self.imageEvidence.removeAll()
        self.imageEvidence.append(image)
        print("after picked: \(imageEvidence.count)")
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func request(){
        print("origin data: \(imageEvidence.count)")
        for (index, item) in imageEvidence.enumerated(){
            if index > 0 {
                if let newData = item.jpegData(compressionQuality: 0.00001){
                    if let data = createAsset(data: newData){
                        tempImage.append(data)
                    }
                }
            }
        }
        print("modified data: \(tempImage.count)")
        //Get Referemce
        let userId = CKRecord.ID(recordName: "4DD23698-1376-452F-9FA8-06C63E1E6D85")
        
        let newPickUp = CKRecord(recordType: "PickUp")
        newPickUp["photoEvidence"] = tempImage
        newPickUp["idUser"] = CKRecord.Reference(recordID: userId, action: CKRecord_Reference_Action.none)
        newPickUp["pickUpFrom"] = addressTF.text
        newPickUp["pickUpBy"] = "Bank Sampah Mitra Pusani"
        newPickUp["pickUpStatus"] = "Done"
        
        database.save(newPickUp) { (record, error) in
            guard record != nil else {
                print("error", error)
                return }
            print("saved request with data: \(record!["photoEvidence"])")
            
        }
    }
    
    fileprivate func createAsset(data: Data) -> CKAsset? {
        
        var returnAsset: CKAsset? = nil
        
        let tempStr = ProcessInfo.processInfo.globallyUniqueString
        let filename = "\(tempStr)_file.dat"
        let baseURL = URL(fileURLWithPath: NSTemporaryDirectory())
        let fileURL = baseURL.appendingPathComponent(filename, isDirectory: false)
        
        do {
            try data.write(to: fileURL, options: [.atomicWrite])
            returnAsset = CKAsset(fileURL: fileURL)
        } catch {
            print("Error creating asset: \(error)")
        }
        
        return returnAsset
    }
}

