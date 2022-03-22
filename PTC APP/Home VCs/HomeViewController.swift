//
//  HomeViewController.swift
//  PTC APP
//
//  Created by Jaldeep Patel on 2021-08-04.
//  Copyright © 2021 Gurlagan Bhullar. All rights reserved.
//

import UIKit
import RealmSwift
import Firebase

class HomeViewController: UIViewController {
    
    //MARK: - Variable
    let realm = try! Realm()
    var value = ""
    var name = ""
    var index = 0
    var currentUser : CurrentUser!
    var userObject: userModel!
    
    //MARK: - MainView Outlets
    @IBOutlet var mainTableView: UITableView!
    @IBOutlet var mainView: UIView!
    @IBOutlet var profileView: UIView!
    @IBOutlet var profileImageView: UIImageView!
    @IBOutlet var emailLabel: UILabel!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var profileEditButtonOutlet: UIButton!
    @IBOutlet var separatorView: UIView!
        //MARK: - MainView  Data
    var activityNameArray : Results<SituationData>?
    
    //MARK: - Menubar Outlets
    @IBOutlet var menubarTableView: UITableView!
    @IBOutlet var menubarView: UIView!
    
    
    //MARK: - Menubar Items and Icons
    let menuItems = ["Home", "Guidelines", "About The Author", "Privacy Policy", "Contact Us", "Sign Out"]
    let menuIcons = ["home", "guidelines", "about-author", "privacy-policy", "contact-us", "sign-out"]
    var isSideViewOpened: Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        currentUser = CurrentUser()
        userObject = currentUser.checkLoggedIn()
        activityNameArray = userObject.situationData.filter("user = %@",userObject.email as Any )
        mainTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupElementsOnViewDidLoad()
    }

    @IBAction func sideMenuButtonTapped(_ sender: UIBarButtonItem) {
        
        menubarView.isHidden = false
        menubarTableView.isHidden = false
        self.view.bringSubviewToFront(menubarView)
        navigationItem.largeTitleDisplayMode = .never
        
        if !isSideViewOpened {
            isSideViewOpened = true
            menubarView.frame = CGRect(x: 0, y: 88, width: 0, height: 838)
            menubarTableView.frame = CGRect(x: 0, y: 0, width: 0, height: 838)
            profileView.frame = CGRect(x: 0, y: 0, width: 0, height: 150)
            profileImageView.frame = CGRect(x: 20, y: 10, width: 0, height: 80)
            nameLabel.frame = CGRect(x: 0, y: 0, width: 0, height: 30)
            emailLabel.frame = CGRect(x: 0, y: 30, width: 0, height: 30)
            profileEditButtonOutlet.frame = CGRect(x: 82, y: 70, width: 0, height: 20)
            separatorView.frame = CGRect(x: 20, y: 98.67, width: 0, height: 0.33)
            
            UIView.animate(withDuration: 0.5) {
                self.menubarView.frame = CGRect(x: 0, y: 88, width: 320, height: 838)
                self.menubarTableView.frame = CGRect(x: 0, y: 0, width: 320, height: 838)
                self.profileView.frame = CGRect(x: 0, y: 0, width: 320, height: 150)
                self.profileImageView.frame = CGRect(x: 20, y: 10, width: 80, height: 80)
                self.nameLabel.frame = CGRect(x: 0, y: 0, width: 210, height: 30)
                self.emailLabel.frame = CGRect(x: 0, y: 30, width: 210, height: 30)
                self.profileEditButtonOutlet.frame = CGRect(x: 82, y: 70, width: 20, height: 20)
                self.separatorView.frame = CGRect(x: 20, y: 98.67, width: 280, height: 0.33)
                
            }
            mainTableView.isUserInteractionEnabled = false
        } else {
            menubarView.isHidden = true
            menubarTableView.isHidden = true
            isSideViewOpened = false
            self.navigationItem.largeTitleDisplayMode = .automatic
            mainTableView.isUserInteractionEnabled = true
        }
        
        let data = UIImage(named: "profileImage")?.jpegData(compressionQuality: 1.0)
        profileImageView.image = UIImage(data: (userObject.image ?? data)!)
        emailLabel.text = userObject.email
        nameLabel.text = userObject.name
    }
    
    
    @IBAction func addActivityButtonTapped(_ sender: UIBarButtonItem) {
        menubarView.isHidden = true
        menubarTableView.isHidden = true
        isSideViewOpened = false
        mainTableView.isUserInteractionEnabled = true
        self.navigationItem.largeTitleDisplayMode = .always
        value = "add"
        performSegue(withIdentifier: Constants.Segues.homeToSituationSegue, sender: self)
    }
    
    @IBAction func profileEditButtonTapped(_ sender: UIButton) {
        performSegue(withIdentifier: Constants.Segues.homeToProfileSegue, sender: self)
    }
    
    @objc func gestureFired(_ gesture: UITapGestureRecognizer) {
        performSegue(withIdentifier: Constants.Segues.homeToProfileSegue, sender: self)
    }
    
    @objc func gestureFired1(_ gesture: UITapGestureRecognizer) {
        
        if let swipedView = gesture.view {
            swipedView.isHidden = true
            self.navigationItem.largeTitleDisplayMode = .automatic
            mainTableView.isUserInteractionEnabled = true
            isSideViewOpened = false
        }
    }
    
    func setupElementsOnViewDidLoad() {
        
        //Hide Menubar on ViewDidLoad
        menubarView.isHidden = true
        menubarTableView.backgroundColor = UIColor.systemBackground
        isSideViewOpened = false
        
        //Add shadow to Menubar
        Utilities.addShadowAndBorderToView(menubarView)
        menubarView.layer.borderWidth = 0
        profileImageView.layer.cornerRadius = 40
        profileImageView.layer.borderWidth = 2
        profileImageView.layer.borderColor = Utilities.brandRedColor.cgColor
        
        //Add tapgesture to ProfileImage View
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(gestureFired(_:)))
        gestureRecognizer.numberOfTapsRequired = 1
        gestureRecognizer.numberOfTouchesRequired = 1
        profileImageView.addGestureRecognizer(gestureRecognizer)
        profileImageView.isUserInteractionEnabled = true
        
        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(gestureFired1(_:)))
        swipeGestureRecognizer.numberOfTouchesRequired = 1
        swipeGestureRecognizer.direction = .left
        menubarView.addGestureRecognizer(swipeGestureRecognizer)
        menubarView.isUserInteractionEnabled = true
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        var numberOfRow = 0
        
        switch tableView {
        case mainTableView:
            if activityNameArray?.count == 0 {
                mainTableView.setEmptyView(title: "You don't have any Worksheet.", message: "Tap the '➕' icon to add your first PTC Worksheet.", messageImage: UIImage(named: "add-1")!)
            } else {
                mainTableView.restore()
            }
            numberOfRow = activityNameArray?.count ?? 0
            
        case menubarTableView:
            numberOfRow = menuItems.count
        default:
            print("Something's wrong!")
        }
        
        return numberOfRow
    }
      
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell()
        
        switch tableView {
        case mainTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.homeScreenMainTableViewCell, for: indexPath) as! HomeVCMainTableViewCell
            cell.acitivityNameLabel.text = activityNameArray?[indexPath.row].situationTitle
            if activityNameArray?[indexPath.row].prefix == true {
                cell.prefixLabel.text = "Updated on :"
            }
            cell.dateLabel.text = activityNameArray?[indexPath.row].date
            cell.timeLabel.text = activityNameArray?[indexPath.row].time
            return cell
        case menubarTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.homeScreenMenuBarCell, for: indexPath) as! SideMenuTableViewCell
            cell.menuLabel.text = menuItems[indexPath.row]
            cell.menuIconImageView.image = UIImage(named: menuIcons[indexPath.row])
            return cell
        default:
            print("Something's wrong!")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch tableView {
        
        case mainTableView:
            value = "show"
            name = activityNameArray![indexPath.row].situationTitle
            index = indexPath.row
            performSegue(withIdentifier: Constants.Segues.homeToSituationSegue, sender: self)
            
        case menubarTableView:
            switch menuItems[indexPath.row] {
        
            case "Home":
                menubarView.isHidden = true
                menubarTableView.isHidden = true
                isSideViewOpened = false
                mainTableView.isUserInteractionEnabled = true
                self.navigationItem.largeTitleDisplayMode = .always
                
                break
                
            case "Guidelines":
                performSegue(withIdentifier: Constants.Segues.homeToUseInstructionsSegue, sender: self)
                break
                
            case "About The Author":
                performSegue(withIdentifier: Constants.Segues.homeToAboutAuthor, sender: self)
                break
                
            case "Privacy Policy":
                performSegue(withIdentifier: Constants.Segues.homeToPrivacyPolicySegue, sender: self)
                break
                
            case "Contact Us":
                performSegue(withIdentifier: Constants.Segues.homeToContactUsSegue, sender: self)
                break
                
            case "Sign Out":
                if (userObject != nil) {
    
                    let resultFlag = currentUser.updateLoginStatus(status: false, email: (userObject?.email)!)
    
                    if (resultFlag == 0) {
                        let firebaseAuth = Auth.auth()
                        do {
                          try firebaseAuth.signOut()
                        } catch let signOutError as NSError {
                          print ("Error signing out: %@", signOutError)
                        }
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "newlogin") as! UINavigationController
                        self.present(vc, animated: true, completion: nil)
    
                    } else {
                        showAlert(title: "Error!", message: "Failed to update login status.", buttonTitle: "Try Again")
                    }
                } else {
                    showAlert(title: "Error!", message: "There's problem in loging out.", buttonTitle: "Try Again")
                }
                break
                
            default:
                print("Screen is not available.")
                break
            }
        default:
            print("Something's wrong!")
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        switch tableView {
        case mainTableView:
            return true
        case menubarTableView:
           return false
        default:
            print("Something's wrong!")
        }
        return false
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if(editingStyle == .delete){
            
            let title = self.activityNameArray![indexPath.row]
            let alert = UIAlertController(title: "Warning", message: "Do you want to delete \(title.situationTitle)?", preferredStyle: .alert)
            
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
                self.mainTableView.reloadData()
                
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let editAction = UIContextualAction(style: .normal, title: "Edit") { (action, view, handler) in
            self.value = "edit"
            self.name = self.activityNameArray![indexPath.row].situationTitle
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
            vc?.situationName = name
            vc?.myIndex = index
            vc?.selectedUser = userObject
        }
    }
}



//	Extension for TableView to add EmptyView when there's no data

extension UITableView {
        
    func setEmptyView(title: String, message: String, messageImage: UIImage) {
        
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        
        let messageImageView = UIImageView()
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        
        messageImageView.backgroundColor = .clear
        
        messageImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textColor = UIColor(named: "BrandColor")
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 20)
        
        messageLabel.textColor = UIColor(named: "BrandBlueColor")
        messageLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 15)
        
        emptyView.addSubview(messageImageView)
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)

        
        NSLayoutConstraint.activate([
            messageImageView.topAnchor.constraint(equalTo: emptyView.safeAreaLayoutGuide.topAnchor, constant: 200),
            messageImageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor),
            messageImageView.heightAnchor.constraint(equalToConstant: 100),
            messageImageView.widthAnchor.constraint(equalToConstant: 100)
        ])
        

        messageImageView.tintColor = UIColor(named: "BrandRedColor")
        
        titleLabel.topAnchor.constraint(equalTo: messageImageView.bottomAnchor, constant: 5).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
                
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        messageLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true

        messageImageView.image = messageImage
        titleLabel.text = title
        messageLabel.text = message
        titleLabel.numberOfLines = 0
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        UIView.animate(withDuration: 1, animations: {
                 
                 messageImageView.transform = CGAffineTransform(rotationAngle: .pi / 10)
             }, completion: { (finish) in
                 UIView.animate(withDuration: 1, animations: {
                     messageImageView.transform = CGAffineTransform(rotationAngle: -1 * (.pi / 10))
                 }, completion: { (finishh) in
                     UIView.animate(withDuration: 1, animations: {
                         messageImageView.transform = CGAffineTransform.identity
                     })
                 })
                 
             })
        
        self.backgroundView = emptyView
        separatorStyle = .none
        
    }
    
    
    func restore() {
        self.backgroundView = nil
    }
}


