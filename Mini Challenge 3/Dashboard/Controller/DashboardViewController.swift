//
//  DashboardViewController.swift
//  Mini Challenge 3
//
//  Created by Muhammad Reynaldi on 21/08/19.
//  Copyright © 2019 11. All rights reserved.
//

import UIKit
import AVKit
class DashboardViewController: UIViewController {
    
    // Variables
    let cellID = "sortID"
    var sortImages = [UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "3")]
    var a:AcceptedViewController?
    var isLogin:Bool = false
    
    //Outlet
    @IBOutlet weak var sortCollectionView: UICollectionView!
    @IBOutlet weak var pickUpButton: UIButton!
    @IBOutlet weak var priceListButton: UIButton!
    @IBOutlet weak var recyclableStuffButton: UIButton!
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var accountPlace: UIView!
    @IBOutlet weak var accountBar: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellDelegate()
        setView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        navigationController?.navigationBar.isHidden = true
    }
    
    @IBAction func profileTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToProfile", sender: self)
//        if isLogin == true{
//            performSegue(withIdentifier: "goToProfile", sender: nil)
//        }else{
//            performSegue(withIdentifier: "goToLogin", sender: nil)
//        }
    }
    
    @IBAction func pickUpTapped(_ sender: UIButton) {
        self.performSegue(withIdentifier: "goToPickUp", sender: self)
        
        //CheckSession
    }
    
    @IBAction func unwindToDashboard(_ unwindSegue: UIStoryboardSegue) {
        let sourceViewController = unwindSegue.source as? LoginViewController
//        isLogin = sourceViewController?.login ?? false
    }
    
    @IBAction func unwindToRoot(_ unwindSegue: UIStoryboardSegue) {
        if let sourceViewController = unwindSegue.source as? AcceptedViewController{
            return
        }
    }
    
    
}
extension DashboardViewController{
    func setView(){
        imageProfile.setRounded()
        pickUpButton.littleRoundButton()
        priceListButton.littleRoundButton()
        recyclableStuffButton.littleRoundButton()
        accountPlace.reallyRound()
        accountBar.barRound()
    }
    
    func popToRoot(_ sender:String) {
        navigationController?.popToRootViewController(animated: true)
        print(sender)
    }
    
    func checkSession(id:String){
        if isLogin{
            performSegue(withIdentifier: id, sender: nil)
        }else{
            performSegue(withIdentifier: "goToLogin", sender: nil)
        }
    }
}

extension DashboardViewController:UICollectionViewDataSource, UICollectionViewDelegate{
    
    func cellDelegate(){
        sortCollectionView.dataSource = self
        sortCollectionView.delegate = self
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sortImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! SortInfoCollectionViewCell
        cell.sortImage.image = sortImages[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            setVideo("1")
        } else if indexPath.row == 1 {
            setVideo("1")
        } else if indexPath.row == 2 {
            setVideo("1")
        }
        
    }
    
    func setVideo(_ nameVideo: String) {
        if let path = Bundle.main.path(forResource: nameVideo, ofType: "MOV") {
            
            let video = AVPlayer(url: URL(fileURLWithPath: path))
            let videoPlayer = AVPlayerViewController()
            videoPlayer.player = video
            
            present(videoPlayer, animated: true, completion: {
                video.play()
            })
        }
    }
    
}
