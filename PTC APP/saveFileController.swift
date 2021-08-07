import Foundation
import UIKit
import CoreData
import RealmSwift


class saveFileController : UIViewController{
    //For Design
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
    
    
    // Variable
    let realm = try! Realm()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Your Situation"
        UIsetup()
    }

    
    @IBAction func saveButtonAction(_ sender: Any) {
           
            let title = situtionTextField.text
            print(title!)
            // Nil todos can't be added
            if let title = title{
              writeData(title: title)
            }
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
    func writeData(title: String)  {
        let todo = SituationData()
        todo.situationTitle = title
        todo.date = dateTextField.text!
        todo.value = valueTextField.text!
        todo.feel = feelTextField.text!
        todo.obstacle = obstacleTextField.text!
        todo.remember = rememberTextField.text!
        todo.them = ThemTextField.text!
        todo.appreciate = appreCIateTextField.text!
        todo.doitem = doTextField.text!
        todo.you = youTextField.text!
        save(situationData: todo)
    }
    
    func save(situationData: SituationData)  {
        do {
            try realm.write {
                realm.add(situationData)
            }
        }catch {
            print("Error saving situation Data\(error)")
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
    
    func UIsetup() {
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
    }
}
