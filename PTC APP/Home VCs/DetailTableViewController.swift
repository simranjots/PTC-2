//
//  DetailTableViewController.swift
//  PTC APP
//
//  Created by Simranjot Singh on 2022-02-26.
//  Copyright © 2022 Gurlagan Bhullar. All rights reserved.
//

import UIKit
import RealmSwift

class DetailTableViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    //MARK: - Variable
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var DetailTableView: UITableView!
    let realm = try! Realm()
    var value = ""
    var foldername = ""
    var index = 0
    var currentUser : CurrentUser!
    var userObject: userModel!
    var name : FolderData!
    var activityNameArray : Results<SituationData>?
   
    override func viewWillAppear(_ animated: Bool) {
        currentUser = CurrentUser()
        userObject = currentUser.checkLoggedIn()
        print("aaa\(name.folderName)")
        print("aaa\(foldername)")
        activityNameArray = name.situationData.filter("folderName = %@",name.folderName as Any )
        DetailTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    @IBAction func addActivityButtonTapped(_ sender: UIBarButtonItem) {
        value = "add"
        performSegue(withIdentifier: Constants.Segues.homeToSituationSegue, sender: self)
    }

    // MARK: - Table view data source

     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return activityNameArray?.count ?? 0
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                    let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.homeScreenMainTableViewCell, for: indexPath) as! HomeVCMainTableViewCell
                    cell.acitivityNameLabel.text = activityNameArray?[indexPath.row].situationTitle
                    if activityNameArray?[indexPath.row].prefix == true {
                        cell.prefixLabel.text = "Updated on :"
                    }
                    cell.dateLabel.text = activityNameArray?[indexPath.row].date
                    cell.timeLabel.text = activityNameArray?[indexPath.row].time
                    return cell
    }

     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            
            tableView.deselectRow(at: indexPath, animated: true)
            
                value = "show"
                foldername = activityNameArray![indexPath.row].folderName
                index = indexPath.row
                performSegue(withIdentifier: Constants.Segues.homeToSituationSegue, sender: self)
        }
        
     func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
            
                return true

        }
        
     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            
            if(editingStyle == .delete){
                
                let title = self.activityNameArray![indexPath.row]
                let alert = UIAlertController(title: "Warning", message: "Do you want to delete \(title.folderName)?", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: { (action:UIAlertAction) -> Void in
                    if let situationData = self.activityNameArray?[indexPath.row]{
                        do {
                            try self.realm.write {
                                self.realm.delete(situationData)
                            }
                        } catch {
                            print("Error saving done status \(error)")
                        }
                    }
                    self.DetailTableView.reloadData()
                    
                }))
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
                present(alert, animated: true, completion: nil)
            }
        }
        
     func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
            let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, handler) in
                self.value = "edit"
                self.foldername = self.activityNameArray![indexPath.row].folderName
                self.index = indexPath.row
                self.performSegue(withIdentifier: Constants.Segues.homeToSituationSegue, sender: self)
            }
            editAction.backgroundColor = .lightGray
            let configuration = UISwipeActionsConfiguration(actions: [editAction])
            return configuration
        }
        
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
            if segue.destination is PTCWorksheetViewController {
                let vc = segue.destination as? PTCWorksheetViewController
                vc?.viewType = value
                vc?.FolderName = foldername
                vc?.folderobject = self.name
                vc?.myIndex = index
                vc?.selectedUser = userObject
            }
        }
        func save(folderdata: FolderData)  {
            
            if let currentU = self.userObject {
            do {
                try realm.write {
                    currentU.folderData.append(folderdata)
                   // realm.add(situationData)
                }
            }catch {
                print("Error saving situation Data\(error)")
            }
            }
        }
    }
