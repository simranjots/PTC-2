//
//  testTableVIew.swift
//  PTC APP
//
//  Created by Gurlagan Bhullar on 2020-03-04.
//  Copyright © 2020 Gurlagan Bhullar. All rights reserved.
//

import Foundation
import  UIKit
import CoreData

class testTableView : UIViewController{
  var quote: Quote?
     var managedObjectContext: NSManagedObjectContext?
    @IBOutlet weak var name1: UITextField!
    override func viewDidLoad() {
         super.viewDidLoad()

         title = "Add Quote"

         if let quote = quote {
             name1.text = quote.name
            // contentsTextView.text = quote.contents
         }
        print("ajnduindiuwnfa")
            //   print(quote)
     }
   
    @IBAction func pressed(_ sender: UIButton) {
          print("pressing button")
        
        guard let managedObjectContext = managedObjectContext else { return }

        if quote == nil {
            // Create Quote
            let newQuote = Quote(context: managedObjectContext)

            // Configure Quote
            newQuote.createdAt = Date().timeIntervalSince1970

            // Set Quote
            quote = newQuote
        }

        if let quote = quote {
            // Configure Quote
            quote.name = name1.text
          //  quote.contents = contentsTextView.text
        }
        
      
       
        
    }
}

