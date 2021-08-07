//
//  PTCWorksheetViewController.swift
//  PTC APP
//
//  Created by Jaldeep Patel on 2021-08-06.
//  Copyright © 2021 Gurlagan Bhullar. All rights reserved.
//

import UIKit

class PTCWorksheetViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet var dateAndTimeLabel: UILabel!
    @IBOutlet var communicationSituationLabel: UILabel!
    @IBOutlet var communicationSituationTextField: UITextField!
    @IBOutlet var themLabel: UILabel!
    @IBOutlet var themTextView: UITextView!
    @IBOutlet var appreciateLabel: UILabel!
    @IBOutlet var appreciateTextView: UITextView!
    @IBOutlet var rememberLabel: UILabel!
    @IBOutlet var rememberTextView: UITextView!
    @IBOutlet var obstaclesLabel: UILabel!
    @IBOutlet var obstaclesTextView: UITextView!
    @IBOutlet var feelLabel: UILabel!
    @IBOutlet var feelTextView: UITextView!
    @IBOutlet var valueLabel: UILabel!
    @IBOutlet var valueTextView: UITextView!
    @IBOutlet var doLabel: UILabel!
    @IBOutlet var doTextView: UITextView!
    @IBOutlet var youLabel: UILabel!
    @IBOutlet var youTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleElements()
    }
    
    func styleElements() {
        
        //Style textfield
        communicationSituationTextField.layer.cornerRadius = 8
        communicationSituationTextField.layer.borderWidth = 1
        communicationSituationTextField.layer.borderColor = Utilities.primaryTextColor.cgColor
            
        //Style textViews
        Utilities.styleTextView(themTextView)
        Utilities.styleTextView(appreciateTextView)
        Utilities.styleTextView(rememberTextView)
        Utilities.styleTextView(obstaclesTextView)
        Utilities.styleTextView(feelTextView)
        Utilities.styleTextView(valueTextView)
        Utilities.styleTextView(doTextView)
        Utilities.styleTextView(youTextView)
        
        //Style Labels
        Utilities.styleLabel(communicationSituationLabel)
        Utilities.styleLabel(themLabel)
        Utilities.styleLabel(appreciateLabel)
        Utilities.styleLabel(rememberLabel)
        Utilities.styleLabel(obstaclesLabel)
        Utilities.styleLabel(feelLabel)
        Utilities.styleLabel(valueLabel)
        Utilities.styleLabel(doLabel)
        Utilities.styleLabel(youLabel)
    }
    
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
    
    }
    
}
