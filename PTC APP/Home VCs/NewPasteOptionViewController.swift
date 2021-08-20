//
//  NewPasteOptionViewController.swift
//  PTC APP
//
//  Created by Simranjot Singh Bagga on 2021-08-20.
//  Copyright © 2021 Gurlagan Bhullar. All rights reserved.
//

import UIKit

class NewPasteOptionViewController: UIViewController {

    @IBOutlet weak var textview: UITextView!
    var message : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize = CGSize(width:200, height:200) // IMPORTANT

           // REST ARE COSMETIC CHANGES
           self.view.backgroundColor = UIColor.clear
           self.view.isOpaque = true
           self.view.layer.masksToBounds = false
           self.view.layer.shadowOffset = CGSize(width: 0, height: 5)
           self.view.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:1).cgColor
           self.view.layer.shadowOpacity = 0.5
           self.view.layer.shadowRadius = 20
        // Do any additional setup after loading the view.
        textview.text = message ?? "hello"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
