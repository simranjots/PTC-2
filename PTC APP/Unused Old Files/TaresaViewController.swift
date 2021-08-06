////
////  TaresaViewController.swift
////  PTC APP
////
////  Created by Gurlagan Bhullar on 2020-03-10.
////  Copyright © 2020 Gurlagan Bhullar. All rights reserved.
////
//
//import Foundation
//import UIKit
//import SafariServices
//
//class TaresaViewController: UIViewController {
//
//    @IBOutlet weak var websiteButton: UIButton!
//    @IBAction func watchButtonTapped() {
//        showSafariVC(for: "http://www.connecttothecore.com")
//    }
//    
//    override func viewDidLoad() {
//        websiteButton.layer.cornerRadius = websiteButton.frame.size.width/2
//           websiteButton.layer.cornerRadius = websiteButton.frame.size.width/40
//
//    }
//    func showSafariVC(for url: String) {
//        guard let url = URL(string: url) else {
//            //Show an invalid URL error alert
//            return
//        }
//        
//        let safariVC = SFSafariViewController(url: url)
//        present(safariVC, animated: true)
//    }
//}
