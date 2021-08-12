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

    func writeData(title: String)  {
        
        let todo = SituationData()
        todo.situationTitle = title
        todo.date = Date().shortdateToString()!
        todo.time = Date().currentTime()
        todo.value = valueTextView.text!
        todo.feel = feelTextView.text!
        todo.obstacle = obstaclesTextView.text!
        todo.remember = rememberTextView.text!
        todo.them = themTextView.text!
        todo.appreciate = appreciateTextView.text!
        todo.doitem = doTextView.text!
        todo.you = youTextView.text!
        todo.user = (selectedUser?.email)!
        save(situationData: todo)
        
    }
    
    func updateData() {
        if let situationData = activityNameArray?[myIndex]{
            do {
                try realm.write {
                    situationData.situationTitle = communicationSituationTextField.text!
                    situationData.date =  Date().shortdateToString()!
                    situationData.value = valueTextView.text!
                    situationData.feel = feelTextView.text!
                    situationData.obstacle = obstaclesTextView.text!
                    situationData.remember = rememberTextView.text!
                    situationData.them = themTextView.text!
                    situationData.appreciate = appreciateTextView.text!
                    situationData.doitem = doTextView.text!
                    situationData.you = youTextView.text!
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
            valueTextView.text = activityNameArray![self.myIndex].value
            feelTextView.text = activityNameArray![self.myIndex].feel
            obstaclesTextView.text = activityNameArray![self.myIndex].obstacle
            rememberTextView.text = activityNameArray![self.myIndex].remember
            themTextView.text = activityNameArray![self.myIndex].them
            appreciateTextView.text = activityNameArray![self.myIndex].appreciate
            doTextView.text =  activityNameArray![self.myIndex].doitem
            youTextView.text =  activityNameArray![self.myIndex].you
            userInteractionDisabled()
        }else if viewType == "add" {
            communicationSituationTextField.text = ""
            valueTextView.text = ""
            feelTextView.text = ""
            obstaclesTextView.text = ""
            rememberTextView.text = ""
            themTextView.text = ""
            appreciateTextView.text = ""
            doTextView.text = ""
            youTextView.text = ""
        }else if viewType == "edit" {
            communicationSituationTextField.text = activityNameArray![self.myIndex].situationTitle
            valueTextView.text = activityNameArray![self.myIndex].value
            feelTextView.text = activityNameArray![self.myIndex].feel
            obstaclesTextView.text = activityNameArray![self.myIndex].obstacle
            rememberTextView.text = activityNameArray![self.myIndex].remember
            themTextView.text = activityNameArray![self.myIndex].them
            appreciateTextView.text = activityNameArray![self.myIndex].appreciate
            doTextView.text =  activityNameArray![self.myIndex].doitem
            youTextView.text =  activityNameArray![self.myIndex].you
        }
    }
    
    //MARK: - user interaction Disabled
    func userInteractionDisabled() {
        communicationSituationTextField.isUserInteractionEnabled = false
        valueTextView.isEditable = false
        feelTextView.isEditable = false
        obstaclesTextView.isEditable = false
        rememberTextView.isEditable = false
        themTextView.isEditable = false
        appreciateTextView.isEditable = false
        doTextView.isEditable = false
        youTextView.isEditable = false
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
    
}
