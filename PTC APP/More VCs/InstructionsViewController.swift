//
//  InstructionsViewController.swift
//  PTC APP
//
//  Created by Jaldeep Patel on 2021-08-05.
//  Copyright © 2021 Gurlagan Bhullar. All rights reserved.
//

import UIKit

class InstructionsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //MARK: - IBOutlet
    @IBOutlet var instructionCollectionView: UICollectionView!
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var previousButtonOutlet: UIButton!
    @IBOutlet var nextButtonOutlet: UIButton!
    
    //Images Array
    let collectionViewImages = ["1", "2", "3"]
    var currentPage = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Utilities.addShadowToButton(previousButtonOutlet)
        Utilities.addShadowToButton(nextButtonOutlet)
        
        pageControl.numberOfPages = collectionViewImages.count
        pageControl.currentPage = 0
        
        //pageControl.isHidden = true
        
    }
    
    @IBAction func previousButtonTapped(_ sender: UIButton) {
        
        let prevIndex = max(pageControl.currentPage - 1, 0)
        let indexPath = IndexPath(item: prevIndex, section: 0)
        pageControl.currentPage = prevIndex
        instructionCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        
        let noOfPages = collectionViewImages.count
        let nextIndex = min(pageControl.currentPage + 1, noOfPages - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        instructionCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    
    //MARK: - Datasource and Delegate Methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionViewImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellIdentifiers.instructionCollectionViewCell, for: indexPath) as! InstructionsCollectionViewCell
        
        cell.instructionsImageView.image = UIImage(named: "\(collectionViewImages[indexPath.row]).png")
        
        //Style ImageView and View
        cell.instructionsImageView.layer.borderWidth = 1
        cell.instructionsImageView.layer.borderColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        cell.instructionsImageView.layer.cornerRadius = 20
        
        cell.imageViewContainer.layer.shadowColor = UIColor.black.cgColor
        cell.imageViewContainer.layer.shadowOpacity = 0.5
        cell.imageViewContainer.layer.shadowOffset = CGSize(width: 0.0, height: 1.7)
        cell.imageViewContainer.layer.cornerRadius = 20
        
        return cell
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let pageWidth = scrollView.frame.width
            self.currentPage = Int((scrollView.contentOffset.x + pageWidth / 2) / pageWidth)
            self.pageControl.currentPage = self.currentPage
        }
    
    
}
