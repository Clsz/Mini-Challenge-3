//
//  OnBoardingViewController.swift
//  Mini Challenge 3
//
//  Created by Muhammad Reynaldi on 04/09/19.
//  Copyright © 2019 11. All rights reserved.
//

import UIKit

class OnBoardingViewController: UIViewController, UIScrollViewDelegate, OnBoardingInputData {
    
    func didTap(){
        performSegue(withIdentifier: "segueToMainVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let dest = segue.destination
        dest.modalPresentationStyle = .fullScreen
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        scrollView.delegate = self
        
        let guidelineSlides:[Slide] = createSlides()
        setupSlideScrollView(guidelineSlides: guidelineSlides)
        
        pageControl.numberOfPages = guidelineSlides.count
        pageControl.currentPage = 0
        
        view.bringSubviewToFront(pageControl)
    }
    
    func createSlides() -> [Slide]{
        
        let slide1: Slide = Bundle.main.loadNibNamed( "Slide", owner: self, options: nil)?.first as! Slide
        slide1.imageView.image = UIImage(named: "garbage-truck")
        slide1.imageView.isHidden = false
        slide1.myLabel.text = "Pick Up"
        slide1.myDescription.text = "Give us your recyclable trash merely by calling us through Up Trash"
        slide1.myButton.isHidden = true
        
        let slide2: Slide = Bundle.main.loadNibNamed( "Slide", owner: self, options: nil)?.first as! Slide
        slide2.imageView.image = UIImage(named: "group_3")
        slide2.myLabel.text = "Sort It"
        slide2.myDescription.text = "Start by sorting your trash according to the recyclable list!"
        slide2.myButton.isHidden = true
        
        let slide3: Slide = Bundle.main.loadNibNamed( "Slide", owner: self, options: nil)?.first as! Slide
        slide3.imageView.image = UIImage(named: "photocamera")
        slide3.myLabel.text = "Take a Photo"
        slide3.myDescription.text = "Then take a clear picture of your sorted trash!"
        slide3.myButton.isHidden = true
        //slide3.listener?.didTap()
        
        let slide4: Slide = Bundle.main.loadNibNamed("Slide", owner: self, options: nil)?.first as! Slide
        slide4.imageView.image = UIImage(named: "give-money")
        slide4.myLabel.text = "Get Money"
        slide4.myDescription.text = "Simple little act that let you save the world and earn extra income!"
        //slide4.myButton.setImage("Got It Button", for: <#T##UIControl.State#>)
        slide4.listener = self
        
        //        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.imageAction))
        //        slide3.imageView.addGestureRecognizer(tapGesture)
        
        return [slide1, slide2, slide3, slide4]
    }
    
    func setupSlideScrollView(guidelineSlides: [Slide]){
        scrollView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(guidelineSlides.count), height: view.frame.height)
        scrollView.isPagingEnabled = true
        
        for i in 0 ..< guidelineSlides.count{
            guidelineSlides[i].frame = CGRect(x: view.frame.width * CGFloat(i), y: 0, width: view.frame.width, height: view.frame.height)
            
            scrollView.addSubview(guidelineSlides[i])
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageIndex = round(scrollView.contentOffset.x/view.frame.width)
        pageControl.currentPage = Int(pageIndex)
    }
    
    
}

protocol OnBoardingInputData{
    func didTap()
}
