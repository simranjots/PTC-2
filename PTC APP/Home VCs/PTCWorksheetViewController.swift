//
//  PTCWorksheetViewController.swift
//  PTC APP
//
//  Created by Jaldeep Patel on 2021-08-06.
//  Copyright © 2021 Gurlagan Bhullar. All rights reserved.
//

import UIKit
import RealmSwift

class PTCWorksheetViewController: UIViewController {

    //MARK: - IBOutlets
    @IBOutlet var dateAndTimeLabel: UILabel!
    @IBOutlet var communicationSituationLabel: UILabel!
    @IBOutlet var communicationSituationTextField: UITextField!
    
    @IBOutlet var themLabel: UILabel!
    @IBOutlet var themTextView1: UITextView!
    @IBOutlet var themTextView2: UITextView!
    @IBOutlet var themTextView3: UITextView!
    @IBOutlet var themButton: UIButton!
    
    @IBOutlet var appreciateLabel: UILabel!
    @IBOutlet var appreciateTextView1: UITextView!
    @IBOutlet var appreciateTextView2: UITextView!
    @IBOutlet var appreciateTextView3: UITextView!
    @IBOutlet var appreciateButton: UIButton!
    
    @IBOutlet var rememberLabel: UILabel!
    @IBOutlet var rememberTextView1: UITextView!
    @IBOutlet var rememberTextView2: UITextView!
    @IBOutlet var rememberTextView3: UITextView!
    @IBOutlet var rememberButton: UIButton!
    
    @IBOutlet var obstaclesLabel: UILabel!
    @IBOutlet var obstaclesTextView1: UITextView!
    @IBOutlet var obstaclesTextView2: UITextView!
    @IBOutlet var obstaclesTextView3: UITextView!
    @IBOutlet var obstaclesButton: UIButton!
    
    @IBOutlet var feelLabel: UILabel!
    @IBOutlet var feelTextView1: UITextView!
    @IBOutlet var feelTextView2: UITextView!
    @IBOutlet var feelTextView3: UITextView!
    @IBOutlet var feelButton: UIButton!
    
    @IBOutlet var valueLabel: UILabel!
    @IBOutlet var valueTextView1: UITextView!
    @IBOutlet var valueTextView2: UITextView!
    @IBOutlet var valueTextView3: UITextView!
    @IBOutlet var valueButton: UIButton!
    
    @IBOutlet var doLabel: UILabel!
    @IBOutlet var doTextView1: UITextView!
    @IBOutlet var doTextView2: UITextView!
    @IBOutlet var doTextView3: UITextView!
    @IBOutlet var doButton: UIButton!
    
    @IBOutlet var youLabel: UILabel!
    @IBOutlet var youTextView1: UITextView!
    @IBOutlet var youTextView2: UITextView!
    @IBOutlet var youTextView3: UITextView!
    @IBOutlet var youButton: UIButton!
    
    @IBOutlet var saveButton: UIBarButtonItem!
    
    //MARK: -  Variable
    let realm = try! Realm()
    var viewType: String = ""
    var situationName: String = ""
    var myIndex = 0
    var activityNameArray : Results<SituationData>?
    var selectedUser: userModel?
    
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        styleElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        updateUI(type: viewType)
    }
    

    func validateFields() -> String? {
    
        //Validate communication situation is not blank
        if communicationSituationTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Communication situation should not be empty."
        }
        
        //Validate communication situation should not contain special charactors
        let cleanedcommunicationSituation = communicationSituationTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if Utilities.isStringValid(cleanedcommunicationSituation) == true {
            return "Communication situation should not contain any special charactors or numbers."
        }
        return nil
    }
    
    //MARK: - IBActions:
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        
        let error = validateFields()
        
        if error != nil {
            showAlert(title: "Warning", message: error!, buttonTitle: "OK")
        } else {
            if viewType == "add"{
                
            let title = communicationSituationTextField.text
            
            if let title = title{
                writeData(title: title)
            }
            }else if viewType == "edit"{
                updateData()
            }
            navigationController?.popViewController(animated: true)
            }
        }
    
    @IBAction func themButtonTapped(_ sender: UIButton) {
        
    }

    @IBAction func appreciateButtonTapped(_ sender: UIButton) {
        
    }

    @IBAction func rememberButtonTapped(_ sender: UIButton) {
        
    }

    @IBAction func obstaclesButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func feelButtonTapped(_ sender: UIButton) {
        
    }

    @IBAction func valueButtonTapped(_ sender: UIButton) {
        
    }

    @IBAction func doButtonTapped(_ sender: UIButton) {
        
    }

    @IBAction func youButtonTapped(_ sender: UIButton) {
        
    }

    
    
    
    

    func writeData(title: String)  {
        
        let todo = SituationData()
        todo.situationTitle = title
        todo.date = Date().shortdateToString()!
        todo.time = Date().currentTime()
        todo.value = valueTextView1.text!
        todo.feel = feelTextView1.text!
        todo.obstacle = obstaclesTextView1.text!
        todo.remember = rememberTextView1.text!
        todo.them = themTextView1.text!
        todo.appreciate = appreciateTextView1.text!
        todo.doitem = doTextView1.text!
        todo.you = youTextView1.text!
        todo.user = (selectedUser?.email)!
        save(situationData: todo)
        
    }
    
    func updateData() {
        if let situationData = activityNameArray?[myIndex]{
            do {
                try realm.write {
                    situationData.situationTitle = communicationSituationTextField.text!
                    situationData.date =  Date().shortdateToString()!
                    situationData.value = valueTextView1.text!
                    situationData.feel = feelTextView1.text!
                    situationData.obstacle = obstaclesTextView1.text!
                    situationData.remember = rememberTextView1.text!
                    situationData.them = themTextView1.text!
                    situationData.appreciate = appreciateTextView1.text!
                    situationData.doitem = doTextView1.text!
                    situationData.you = youTextView1.text!
                    situationData.prefix = true
                }
            } catch {
                print("Error saving done status \(error)")
            }
        }
    }
    
    func save(situationData: SituationData)  {
        
        if let currentU = self.selectedUser {
        do {
            try realm.write {
                currentU.situationData.append(situationData)
               // realm.add(situationData)
            }
        }catch {
            print("Error saving situation Data\(error)")
        }
        }
    }
    
    
    func updateUI(type: String) {
        
        let dt =  "\(Date().shortdateToString() ?? "Aug 6, 2021") | " + "\(Date().currentTime())"
        
        dateAndTimeLabel.text = dt
        
        activityNameArray = realm.objects(SituationData.self)
        
        if viewType == "show" {
            saveButton.isEnabled = false
            saveButton.image = UIImage(named: "")
            communicationSituationTextField.text = activityNameArray![self.myIndex].situationTitle
            dateAndTimeLabel.text =   "\(activityNameArray![self.myIndex].date ) | " + "\( activityNameArray![self.myIndex].time)"
            valueTextView1.text = activityNameArray![self.myIndex].value
            feelTextView1.text = activityNameArray![self.myIndex].feel
            obstaclesTextView1.text = activityNameArray![self.myIndex].obstacle
            rememberTextView1.text = activityNameArray![self.myIndex].remember
            themTextView1.text = activityNameArray![self.myIndex].them
            appreciateTextView1.text = activityNameArray![self.myIndex].appreciate
            doTextView1.text =  activityNameArray![self.myIndex].doitem
            youTextView1.text =  activityNameArray![self.myIndex].you
            userInteractionDisabled()
        }else if viewType == "add" {
            communicationSituationTextField.text = ""
            valueTextView1.text = ""
            feelTextView1.text = ""
            obstaclesTextView1.text = ""
            rememberTextView1.text = ""
            themTextView1.text = ""
            appreciateTextView1.text = ""
            doTextView1.text = ""
            youTextView1.text = ""
        }else if viewType == "edit" {
            communicationSituationTextField.text = activityNameArray![self.myIndex].situationTitle
            valueTextView1.text = activityNameArray![self.myIndex].value
            feelTextView1.text = activityNameArray![self.myIndex].feel
            obstaclesTextView1.text = activityNameArray![self.myIndex].obstacle
            rememberTextView1.text = activityNameArray![self.myIndex].remember
            themTextView1.text = activityNameArray![self.myIndex].them
            appreciateTextView1.text = activityNameArray![self.myIndex].appreciate
            doTextView1.text =  activityNameArray![self.myIndex].doitem
            youTextView1.text =  activityNameArray![self.myIndex].you
        }
    }
    
    //MARK: - user interaction Disabled
    func userInteractionDisabled() {
        communicationSituationTextField.isUserInteractionEnabled = false
        valueTextView1.isEditable = false
        feelTextView1.isEditable = false
        obstaclesTextView1.isEditable = false
        rememberTextView1.isEditable = false
        themTextView1.isEditable = false
        appreciateTextView1.isEditable = false
        doTextView1.isEditable = false
        youTextView1.isEditable = false
    }
    
    func styleElements() {
        
        //Style textfield
        communicationSituationTextField.layer.cornerRadius = 8
        communicationSituationTextField.layer.borderWidth = 1
        communicationSituationTextField.layer.borderColor = Utilities.primaryTextColor.cgColor
            
        //Style textViews
        Utilities.styleTextView(themTextView1)
        Utilities.styleTextView(appreciateTextView1)
        Utilities.styleTextView(rememberTextView1)
        Utilities.styleTextView(obstaclesTextView1)
        Utilities.styleTextView(feelTextView1)
        Utilities.styleTextView(valueTextView1)
        Utilities.styleTextView(doTextView1)
        Utilities.styleTextView(youTextView1)
        
        Utilities.styleTextView(themTextView2)
        Utilities.styleTextView(appreciateTextView2)
        Utilities.styleTextView(rememberTextView2)
        Utilities.styleTextView(obstaclesTextView2)
        Utilities.styleTextView(feelTextView2)
        Utilities.styleTextView(valueTextView2)
        Utilities.styleTextView(doTextView2)
        Utilities.styleTextView(youTextView2)
        
        Utilities.styleTextView(themTextView3)
        Utilities.styleTextView(appreciateTextView3)
        Utilities.styleTextView(rememberTextView3)
        Utilities.styleTextView(obstaclesTextView3)
        Utilities.styleTextView(feelTextView3)
        Utilities.styleTextView(valueTextView3)
        Utilities.styleTextView(doTextView3)
        Utilities.styleTextView(youTextView3)
        
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
        
        //Style Buttons
        themButton.layer.cornerRadius = 17.0
        appreciateButton.layer.cornerRadius = 17.0
        rememberButton.layer.cornerRadius = 17.0
        obstaclesButton.layer.cornerRadius = 17.0
        feelButton.layer.cornerRadius = 17.0
        valueButton.layer.cornerRadius = 17.0
        doButton.layer.cornerRadius = 17.0
        youButton.layer.cornerRadius = 17.0
    }
    
}
