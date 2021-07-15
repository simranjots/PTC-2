//
//  saveFileController.swift
//  PTC APP
//
//  Created by Gurlagan Bhullar on 2020-02-11.
//  Copyright © 2020 Gurlagan Bhullar. All rights reserved.
//

import Foundation
import UIKit
import CoreData


class saveFileController : ToDoParent{
    
    
    //For Design
    var emptyIntArr:[String] = []
    //var quote: Quote?
    // var managedObjectContext: NSManagedObjectContext?
    let defaults = UserDefaults.standard
//    struct Keys {
//        static let firstName  = "firstName"
//        static let lastName          = "lastName"
//    }
    
    //print(emptyIntArr)
    
    @IBOutlet weak var dateDesignLabel: UILabel!
    @IBOutlet weak var communiDesignLabel: UILabel!
    @IBOutlet weak var themDesignLabel: UILabel!
    @IBOutlet weak var appreDesignLabel: UILabel!
    @IBOutlet weak var rememDesignLabel: UILabel!
    @IBOutlet weak var obstaDesignLabel: UILabel!
    @IBOutlet weak var youDesinglabel: UILabel!
    @IBOutlet weak var feelDesignLabel: UILabel!
    @IBOutlet weak var valueDesignLabel: UILabel!
    @IBOutlet weak var doDesignLabel: UILabel!
    
    
    
    
    
    //For Value
    @IBOutlet weak var dateTextField: UITextField!
    @IBOutlet weak var situtionTextField: UITextField!
    @IBOutlet weak var ThemTextField: UITextField!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var appreCIateTextField: UITextField!
    @IBOutlet weak var rememberTextField: UITextField!
    @IBOutlet weak var obstacleTextField: UITextField!
    @IBOutlet weak var feelTextField: UITextField!
    @IBOutlet weak var valueTextField: UITextField!
    @IBOutlet weak var doTextField: UITextField!
    @IBOutlet weak var youTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Your Situation"
        context = (UIApplication.shared.delegate as?AppDelegate)?.persistentContainer.viewContext
        dateDesignLabel.layer.cornerRadius = 10
        dateDesignLabel.layer.masksToBounds = true
        communiDesignLabel.layer.cornerRadius = 10
        communiDesignLabel.layer.masksToBounds = true
        themDesignLabel.layer.cornerRadius = 8
        themDesignLabel.layer.masksToBounds = true
        appreDesignLabel.layer.cornerRadius = 8
        appreDesignLabel.layer.masksToBounds = true
        rememDesignLabel.layer.cornerRadius = 8
        rememDesignLabel.layer.masksToBounds = true
        obstaDesignLabel.layer.cornerRadius = 8
        obstaDesignLabel.layer.masksToBounds = true
        youDesinglabel.layer.cornerRadius = 8
        youDesinglabel.layer.masksToBounds = true
        feelDesignLabel.layer.cornerRadius = 8
        feelDesignLabel.layer.masksToBounds = true
        valueDesignLabel.layer.cornerRadius = 8
        valueDesignLabel.layer.masksToBounds = true
        doDesignLabel.layer.cornerRadius = 8
        doDesignLabel.layer.masksToBounds = true
       // dateTextField. = 2
       // ThemTextField.t.maximumNumberOfLines = 2
    
       
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // get the current text, or use an empty string if that failed
        let currentText = textField.text ?? ""

        // attempt to read the range they are trying to change, or exit if we can't
        guard let stringRange = Range(range, in: currentText) else { return false }

        // add their new text to the existing text
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)

        // make sure the result is under 16 characters
        return updatedText.count <= 16
    }
    
    
    @IBAction func saveButtonAction(_ sender: Any) {
        // showSimpleActionSheet(controller: self)
        
        
        
        if let context = self.context{
            
            let todo = ToDo(context: context)
            let title = situtionTextField.text
            let date = dateTextField.text
            let remember = rememberTextField.text
            let obstacles = obstacleTextField.text
            let apreciate = appreCIateTextField.text
            let them = ThemTextField.text
            let feel = feelTextField.text
            let value = valueTextField.text
            let doValue = doTextField.text
            let you = youTextField.text
            print(title)
            // Nil todos can't be added
            if let title = title{
                todo.title = title
                todo.date = date
                todo.doitem = doValue
                todo.feel = feel
                todo.obstacle = obstacles
                todo.remember = remember
                todo.them = them
                todo.appreciate = apreciate
                todo.value = value
                todo.you = you
                
                //print(todo)
                //  todo.date = date
                
                
                
                
                self.todoList.append(todo)
                func prepare(for segue: UIStoryboardSegue, sender: Any?) {
                    
                    if segue.identifier == "sendData"{
                        let detailVC = segue.destination as? historySitution
                        let row = sender as? Int
                        if let detailVC = detailVC, let row = row{
                            detailVC.titleText = todoList[row].title
                            print("abcdefg")
                        }
                    }
                    
                }
                
                
                
                do{
                    try context.save()
                    print(todoList)
                    //self.tableView.reloadData()
                }catch{
                    fatalError("Error storing data")
                }
                // if let context = self.context{
                
                let todo = ToDo(context: context)
                
                // Nil todos can't be added
                
                // todo.title = title
                //                            todo.date = date
                //
                //                            todo.detail = details
                //                            todo.latitude = latitude
                //                            todo.longitude = longitude
                
                //                            self.todoList.append(todo)
                
                do{
                    try context.save()
                    // self.tableView.reloadData()
                    print(todo)
                }catch{
                    fatalError("Error storing data")
                }
                // }
                //      }
                
            }
        }
        
    }
    func showSimpleActionSheet(controller: UIViewController) {
        let alert = UIAlertController(title: "Title", message: "Please Select an Option", preferredStyle: .actionSheet)
        
        
        alert.addAction(UIAlertAction(title: "Save to the App", style: .default, handler: { (_) in
            print("User click Edit button")
        }))
        
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { (_) in
            print("User click Dismiss button")
        }))
        
        self.present(alert, animated: true, completion: {
            print("completion block")
        })
    }
}
