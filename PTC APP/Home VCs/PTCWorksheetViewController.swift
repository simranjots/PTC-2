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

    @IBOutlet var pdfView: UIView!
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
    var FolderName: String = ""
    var folderobject: FolderData?
    var myIndex = 0
    var activityNameArray : Results<SituationData>?
    var selectedUser: userModel?
  
    //MARK: - Life Cycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        styleElements()
        
      //  createPdfFromView(aView: pdfView, saveToDocumentsWithFileName: "Abc")
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
                if self.folderobject != nil {
                    if folderobject?.situationData[myIndex].situationTitle == title{
                showToast(message: "Communication situation with same name already exist", duration: 2, height: 3)
                    }else{
                        if let title = title{
                            writeData(title: title)
                        }
                    }
                }else{
                    if let title = title{
                        writeData(title: title)
                    }
                }
            }else if viewType == "edit"{
                updateData()
            }else if viewType == "show" {
                let preview = storyboard?.instantiateViewController(withIdentifier: "preview") as! PreViewController
                preview.FolderName = FolderName
                preview.folderobject = folderobject
                preview.myIndex = myIndex
                self.present(preview, animated:true, completion:nil)
                
            }
            navigationController?.popViewController(animated: true)
            }
        }
    
    @IBAction func questionMarkTapped(_ sender: UIButton) {
        
        switch sender.tag {
        
        case 0:
        
            showAlertforQuestionMark(vc: self, title: "Them", message: Instructions.them(), buttonTitle: "Dismiss", buttonType: sender)
             
            break
        case 1:
            showAlertforQuestionMark(vc: self, title: "Appreciate", message: Instructions.appreciate(), buttonTitle: "Dismiss", buttonType: sender)
            break
        case 2:
            showAlertforQuestionMark(vc: self, title: "Remember", message: Instructions.remember(), buttonTitle: "Dismiss", buttonType: sender)
            break
        case 3:
            showAlertforQuestionMark(vc: self, title: "Obstacles", message: Instructions.obstacles(), buttonTitle: "Dismiss", buttonType: sender)
            break
        case 4:
            showAlertforQuestionMark(vc: self, title: "Feel", message: Instructions.feel(), buttonTitle: "Dismiss", buttonType: sender)
            break
        case 5:
            showAlertforQuestionMark(vc: self, title: "Value", message: Instructions.values(), buttonTitle: "Dismiss", buttonType: sender)
            break
        case 6:
            showAlertforQuestionMark(vc: self, title: "Do", message: Instructions.Do(), buttonTitle: "Dismiss", buttonType: sender)
            break
        case 7:
            showAlertforQuestionMark(vc: self, title: "You", message: Instructions.you(), buttonTitle: "Dismiss", buttonType: sender)
            break
            
        default:
            print("Ther is something wrong")
        }
    }

 
    

    func writeData(title: String)  {
        
        let todo = SituationData()
        todo.situationTitle = title
        todo.date = Date().shortdateToString()!
        todo.time = Date().currentTime()
        todo.value1 = valueTextView1.text!
        todo.value2 = valueTextView2.text!
        todo.value3 = valueTextView3.text!
        todo.feel1 = feelTextView1.text!
        todo.feel2 = feelTextView2.text!
        todo.feel3 = feelTextView3.text!
        todo.obstacle1 = obstaclesTextView1.text!
        todo.obstacle2 = obstaclesTextView2.text!
        todo.obstacle3 = obstaclesTextView3.text!
        todo.remember1 = rememberTextView1.text!
        todo.remember2 = rememberTextView2.text!
        todo.remember3 = rememberTextView3.text!
        todo.them1 = themTextView1.text!
        todo.them2 = themTextView2.text!
        todo.them3 = themTextView3.text!
        todo.appreciate1 = appreciateTextView1.text!
        todo.appreciate2 = appreciateTextView2.text!
        todo.appreciate3 = appreciateTextView3.text!
        todo.doitem1 = doTextView1.text!
        todo.doitem2 = doTextView2.text!
        todo.doitem3 = doTextView3.text!
        todo.you1 = youTextView1.text!
        todo.you2 = youTextView2.text!
        todo.you3 = youTextView3.text!
        todo.folderName = FolderName
        save(situationData: todo)
        
    }
    
    func updateData() {
        if let situationData = folderobject?.situationData[myIndex]{
            do {
                try realm.write {
                    situationData.situationTitle = communicationSituationTextField.text!
                    situationData.date =  Date().shortdateToString()!
                    situationData.value1 = valueTextView1.text!
                    situationData.value2 = valueTextView2.text!
                    situationData.value3 = valueTextView3.text!
                    situationData.feel1 = feelTextView1.text!
                    situationData.feel2 = feelTextView2.text!
                    situationData.feel3 = feelTextView3.text!
                    situationData.obstacle1 = obstaclesTextView1.text!
                    situationData.obstacle2 = obstaclesTextView2.text!
                    situationData.obstacle3 = obstaclesTextView3.text!
                    situationData.remember1 = rememberTextView1.text!
                    situationData.remember2 = rememberTextView2.text!
                    situationData.remember3 = rememberTextView3.text!
                    situationData.them1 = themTextView1.text!
                    situationData.them2 = themTextView2.text!
                    situationData.them3 = themTextView3.text!
                    situationData.appreciate1 = appreciateTextView1.text!
                    situationData.appreciate2 = appreciateTextView2.text!
                    situationData.appreciate3 = appreciateTextView3.text!
                    situationData.doitem1 = doTextView1.text!
                    situationData.doitem2 = doTextView2.text!
                    situationData.doitem3 = doTextView3.text!
                    situationData.you1 = youTextView1.text!
                    situationData.you2 = youTextView2.text!
                    situationData.you3 = youTextView3.text!
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
                folderobject?.situationData.append(situationData)
               // realm.add(situationData)
            }
           
        }catch {
            print("Error saving situation Data\(error)")
        }
        }
    }
    
    
    func updateUI(type: String) {
        //| " + "\(Date().currentTime())
        let dt =  "\(Date().shortdateToString() ?? "Aug 6, 2021") "
        
        dateAndTimeLabel.text = dt
        
        activityNameArray = realm.objects(SituationData.self)
       
        
        if viewType == "show" {
            let data = folderobject!.situationData[myIndex]
            saveButton.isEnabled = true
            saveButton.image = UIImage(named: "pdf")
            communicationSituationTextField.text = data.situationTitle
            // | " + "\( activityNameArray![self.myIndex].time)
            dateAndTimeLabel.text =   "\(folderobject?.situationData[myIndex].date ?? "" ) "
            valueTextView1.text = data.value1
            valueTextView2.text = data.value2
            valueTextView3.text = data.value3
            feelTextView1.text = data.feel1
            feelTextView2.text = data.feel2
            feelTextView3.text = data.feel3
            obstaclesTextView1.text = data.obstacle1
            obstaclesTextView2.text = data.obstacle2
            obstaclesTextView3.text = data.obstacle3
            rememberTextView1.text = data.remember1
            rememberTextView2.text = data.remember2
            rememberTextView3.text = data.remember3
            themTextView1.text = data.them1
            themTextView2.text = data.them2
            themTextView3.text = data.them3
            appreciateTextView1.text = data.appreciate1
            appreciateTextView2.text = data.appreciate2
            appreciateTextView3.text = data.appreciate3
            doTextView1.text =  data.doitem1
            doTextView2.text =  data.doitem2
            doTextView3.text =  data.doitem3
            youTextView1.text =  data.you1
            youTextView2.text =  data.you2
            youTextView3.text = data.you3
            userInteractionDisabled()
        }else if viewType == "add" {
            communicationSituationTextField.text = ""
            valueTextView1.text = ""
            valueTextView2.text = ""
            valueTextView3.text = ""
            feelTextView1.text = ""
            feelTextView2.text = ""
            feelTextView3.text = ""
            obstaclesTextView1.text = ""
            obstaclesTextView2.text = ""
            obstaclesTextView3.text = ""
            rememberTextView1.text = ""
            rememberTextView2.text = ""
            rememberTextView3.text = ""
            themTextView1.text = ""
            themTextView2.text = ""
            themTextView3.text = ""
            appreciateTextView1.text = ""
            appreciateTextView2.text = ""
            appreciateTextView3.text = ""
            doTextView1.text = ""
            doTextView2.text = ""
            doTextView3.text = ""
            youTextView1.text = ""
            youTextView2.text = ""
            youTextView3.text = ""
        }else if viewType == "edit" {
            let data = folderobject!.situationData[myIndex]
            communicationSituationTextField.text = data.situationTitle
            valueTextView1.text = data.value1
            valueTextView2.text = data.value2
            valueTextView3.text = data.value3
            feelTextView1.text = data.feel1
            feelTextView2.text = data.feel2
            feelTextView3.text = data.feel3
            obstaclesTextView1.text = data.obstacle1
            obstaclesTextView2.text = data.obstacle2
            obstaclesTextView3.text = data.obstacle3
            rememberTextView1.text = data.remember1
            rememberTextView2.text = data.remember2
            rememberTextView3.text = data.remember3
            themTextView1.text = data.them1
            themTextView2.text = data.them2
            themTextView3.text = data.them3
            appreciateTextView1.text = data.appreciate1
            appreciateTextView2.text = data.appreciate2
            appreciateTextView3.text = data.appreciate3
            doTextView1.text =  data.doitem1
            doTextView2.text =  data.doitem2
            doTextView3.text =  data.doitem3
            youTextView1.text =  data.you1
            youTextView2.text =  data.you2
            youTextView3.text = data.you3
        }
    }
    
    //MARK: - user interaction Disabled
    func userInteractionDisabled() {
        communicationSituationTextField.isUserInteractionEnabled = false
        valueTextView1.isEditable = false
        valueTextView2.isEditable = false
        valueTextView3.isEditable = false
        feelTextView1.isEditable = false
        feelTextView2.isEditable = false
        feelTextView3.isEditable = false
        obstaclesTextView1.isEditable = false
        obstaclesTextView2.isEditable = false
        obstaclesTextView3.isEditable = false
        rememberTextView1.isEditable = false
        rememberTextView2.isEditable = false
        rememberTextView3.isEditable = false
        themTextView1.isEditable = false
        themTextView2.isEditable = false
        themTextView3.isEditable = false
        appreciateTextView1.isEditable = false
        appreciateTextView2.isEditable = false
        appreciateTextView3.isEditable = false
        doTextView1.isEditable = false
        doTextView2.isEditable = false
        doTextView3.isEditable = false
        youTextView1.isEditable = false
        youTextView2.isEditable = false
        youTextView3.isEditable = false
        
        themButton.isHidden = true
        rememberButton.isHidden = true
        obstaclesButton.isHidden = true
        appreciateButton.isHidden = true
        feelButton.isHidden = true
        valueButton.isHidden = true
        doButton.isHidden = true
        youButton.isHidden = true
    }
    
    

    
    func styleElements() {
        
        //Style textfield
        Utilities.addBottomLineToTextField(communicationSituationTextField)
        
        //Style textViews
        Utilities.addBottomLineToTextView(themTextView1)
        Utilities.addBottomLineToTextView(appreciateTextView1)
        Utilities.addBottomLineToTextView(rememberTextView1)
        Utilities.addBottomLineToTextView(obstaclesTextView1)
        Utilities.addBottomLineToTextView(feelTextView1)
        Utilities.addBottomLineToTextView(valueTextView1)
        Utilities.addBottomLineToTextView(doTextView1)
        Utilities.addBottomLineToTextView(youTextView1)
        
        Utilities.addBottomLineToTextView(themTextView2)
        Utilities.addBottomLineToTextView(appreciateTextView2)
        Utilities.addBottomLineToTextView(rememberTextView2)
        Utilities.addBottomLineToTextView(obstaclesTextView2)
        Utilities.addBottomLineToTextView(feelTextView2)
        Utilities.addBottomLineToTextView(valueTextView2)
        Utilities.addBottomLineToTextView(doTextView2)
        Utilities.addBottomLineToTextView(youTextView2)
        
        Utilities.addBottomLineToTextView(themTextView3)
        Utilities.addBottomLineToTextView(appreciateTextView3)
        Utilities.addBottomLineToTextView(rememberTextView3)
        Utilities.addBottomLineToTextView(obstaclesTextView3)
        Utilities.addBottomLineToTextView(feelTextView3)
        Utilities.addBottomLineToTextView(valueTextView3)
        Utilities.addBottomLineToTextView(doTextView3)
        Utilities.addBottomLineToTextView(youTextView3)
        
        //Style Labels
   //     Utilities.styleLabel(communicationSituationLabel)
//        Utilities.styleLabel(themLabel)
//        Utilities.styleLabel(appreciateLabel)
//        Utilities.styleLabel(rememberLabel)
//        Utilities.styleLabel(obstaclesLabel)
//        Utilities.styleLabel(feelLabel)
//        Utilities.styleLabel(valueLabel)
//        Utilities.styleLabel(doLabel)
//        Utilities.styleLabel(youLabel)
        
        //Style Buttons
//        themButton.layer.cornerRadius = 7.0
//        appreciateButton.layer.cornerRadius = 7.0
//        rememberButton.layer.cornerRadius = 7.0
//        obstaclesButton.layer.cornerRadius = 7.0
//        feelButton.layer.cornerRadius = 7.0
//        valueButton.layer.cornerRadius = 7.0
//        doButton.layer.cornerRadius = 7.0
//        youButton.layer.cornerRadius = 7.0
    }
    
}



extension PTCWorksheetViewController: UIPopoverPresentationControllerDelegate {

    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }

    func popoverPresentationControllerDidDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) {

    }

    func popoverPresentationControllerShouldDismissPopover(_ popoverPresentationController: UIPopoverPresentationController) -> Bool {
        return true
    }
    

    
}
