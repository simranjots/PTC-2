//
//  NewPasteOptionViewController.swift
//  PTC APP
//
//  Created by Simranjot Singh Bagga on 2021-08-20.
//  Copyright © 2021 Gurlagan Bhullar. All rights reserved.
//

import UIKit

class NewPasteOptionViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {


    @IBOutlet var instructionsTableView: UITableView!
    @IBOutlet weak var label: UILabel!
    

    var message : [String]?
    var labelName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.preferredContentSize = CGSize(width:300, height:200) // IMPORTANT

           // REST ARE COSMETIC CHANGES
           self.view.backgroundColor = UIColor.clear
           self.view.isOpaque = true
           self.view.layer.masksToBounds = false
           self.view.layer.shadowOffset = CGSize(width: 0, height: 5)
           self.view.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:1).cgColor
           self.view.layer.shadowOpacity = 0.5
           self.view.layer.shadowRadius = 20
        // Do any additional setup after loading the view.
        
        label.text = labelName ?? "label"
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return message?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "instructionsCell", for: indexPath) as! instuctionsTableViewCell

        cell.instuctionLabel.text = message![indexPath.row]
        return cell
    }
    

}
