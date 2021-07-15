//
//  DetailViewController.swift
//  PTC APP
//
//  Created by Gurlagan Bhullar on 2020-03-10.
//  Copyright © 2020 Gurlagan Bhullar. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
   
    
    @IBOutlet weak var dateUI: UILabel!
    @IBOutlet weak var communiUI: UILabel!
    @IBOutlet weak var themUI: UILabel!
    @IBOutlet weak var AppreciateUI: UILabel!
    @IBOutlet weak var feelUI: UILabel!
    @IBOutlet weak var valueUI: UILabel!
    @IBOutlet weak var doUI: UILabel!
    @IBOutlet weak var youUI: UILabel!
    @IBOutlet weak var rememUI: UILabel!
    @IBOutlet weak var obstUI: UILabel!
    @IBOutlet weak var situtionTitle: UITextField!
    static let reuseIdentifier = "VideoCell"
    var passingValue : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateUI.layer.cornerRadius = 10
        dateUI.layer.masksToBounds = true
        communiUI.layer.cornerRadius = 10
        communiUI.layer.masksToBounds = true
        themUI.layer.cornerRadius = 8
        themUI.layer.masksToBounds = true
        AppreciateUI.layer.cornerRadius = 8
        AppreciateUI.layer.masksToBounds = true
        feelUI.layer.cornerRadius = 8
        feelUI.layer.masksToBounds = true
        valueUI.layer.cornerRadius = 8
        valueUI.layer.masksToBounds = true
        doUI.layer.cornerRadius = 8
        doUI.layer.masksToBounds = true
        youUI.layer.cornerRadius = 8
        youUI.layer.masksToBounds = true
        rememUI.layer.cornerRadius = 8
        rememUI.layer.masksToBounds = true
        obstUI.layer.cornerRadius = 8
        obstUI.layer.masksToBounds = true

     setupUI()
    }
    
    func setupUI(){
   situtionTitle.text = passingValue
    }
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        showSimpleActionSheet()
    }
    
    func showSimpleActionSheet() {
          let alert = UIAlertController(title: "Title", message: "Please Select an Option", preferredStyle: .actionSheet)
          alert.addAction(UIAlertAction(title: "Save To the Files", style: .default, handler: { (_) in
              print("User click Approve button")
          }))
          
       
          
          alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { (_) in
              print("User click Dismiss button")
          }))
          
          self.present(alert, animated: true, completion: {
              print("completion block")
          })
      }

}
