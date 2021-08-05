//
//  HomeViewController.swift
//  PTC APP
//
//  Created by Jaldeep Patel on 2021-08-04.
//  Copyright © 2021 Gurlagan Bhullar. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    //MARK: - MainView Outlets
    
    @IBOutlet var mainTableView: UITableView!
    @IBOutlet var mainView: UIView!
    
    //MARK: - MainView Dummy Data
    let activityNameArray = ["Interview", "Seminar", "Internal Meeting", "Client Meeting", "Webinar"]
    let activityDate = ["Aug 5, 2021", "Aug 6, 2021", "Aug 7, 2021", "Aug 8, 2021", "Aug 9, 2021"]
    
    
    //MARK: - Menubar Outlets
    @IBOutlet var menubarTableView: UITableView!
    @IBOutlet var menubarView: UIView!
    
    //MARK: - Menubar Items and Icons
    let menuItems = ["Home", "Profile", "Use Instructions", "About Author", "Privacy Policy", "Contact Us", "Sign Out"]
    let menuIcons = ["home", "profile", "instructions", "about-author", "privacy-policy", "contact-us", "sign-out"]
    var isSideViewOpened: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Hide Menubar on ViewDidLoad
        menubarView.isHidden = true
        menubarTableView.backgroundColor = UIColor.systemBackground
        isSideViewOpened = false
        
        //Add shadow to Menubar
        Utilities.addShadowAndBorderToView(menubarView)
        menubarView.layer.borderWidth = 0
        
    }

    
    @IBAction func sideMenuButtonTapped(_ sender: UIBarButtonItem) {
        
        menubarView.isHidden = false
        menubarTableView.isHidden = false
        self.view.bringSubviewToFront(menubarView)
        
        if !isSideViewOpened {
            isSideViewOpened = true
            menubarView.frame = CGRect(x: 0, y: 88, width: 0, height: 350)
            menubarTableView.frame = CGRect(x: 0, y: 0, width: 0, height: 350)
            
            UIView.animate(withDuration: 0.7) {
                self.menubarView.frame = CGRect(x: 0, y: 88, width: 250, height: 350)
                self.menubarTableView.frame = CGRect(x: 0, y: 0, width: 250, height: 350)
            }
        } else {
            menubarView.isHidden = true
            menubarTableView.isHidden = true
            isSideViewOpened = false

            menubarView.frame = CGRect(x: 0, y: 88, width: 250, height: 350)
            menubarTableView.frame = CGRect(x: 0, y: 0, width: 250 , height: 350)

            UIView.animate(withDuration: 0.7) {
                self.menubarView.frame = CGRect(x: 0, y: 88, width: 0, height: 350)
                self.menubarTableView.frame = CGRect(x: 0, y: 0, width: 250, height: 350)
            }
        }
    }
    
    @IBAction func addActivityButtonTapped(_ sender: UIBarButtonItem) {
    
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
            numberOfRow = activityNameArray.count
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
            cell.acitivityNameLabel.text = activityNameArray[indexPath.row]
            cell.dateLabel.text = activityDate[indexPath.row]
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
            print("MainTableView's cells are Tapped")
        
        case menubarTableView:
            switch menuItems[indexPath.row] {
        
            case "Home":
                let homeVC = self.storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as! HomeViewController
                self.navigationController?.pushViewController(homeVC, animated: true)
                break
                
            case "Profile":
                performSegue(withIdentifier: Constants.Segues.homeToProfileSegue, sender: self)
                break
                
            case "Use Instructions":
                performSegue(withIdentifier: Constants.Segues.homeToUseInstructionsSegue, sender: self)
                break
                
            case "About Author":
                performSegue(withIdentifier: Constants.Segues.homeToAboutAuthor, sender: self)
                break
                
            case "Privacy Policy":
                performSegue(withIdentifier: Constants.Segues.homeToPrivacyPolicySegue, sender: self)
                break
                
            case "Contact Us":
                performSegue(withIdentifier: Constants.Segues.homeToContactUsSegue, sender: self)
                break
                
            case "Sign Out":
                print("Sign Out")
    //            if (userObject != nil) {
    //
    //                let resultFlag = currentUser.updateLoginStatus(status: false, email: (userObject?.email)!)
    //
    //                if (resultFlag == 0) {
    //                    let firebaseAuth = Auth.auth()
    //                    do {
    //                      try firebaseAuth.signOut()
    //                    } catch let signOutError as NSError {
    //                      print ("Error signing out: %@", signOutError)
    //                    }
    //                    let storyboard = UIStoryboard(name: "Login", bundle: nil)
    //                    let vc = storyboard.instantiateViewController(withIdentifier: "newLoginOptions") as! UINavigationController
    //                    self.present(vc, animated: true, completion: nil)
    //
    //                } else {
    //                    showAlert(title: "Error!", message: "Failed to update login status.", buttonTitle: "Try Again")
    //                }
    //            } else {
    //                showAlert(title: "Error!", message: "There's problem in loging out.", buttonTitle: "Try Again")
    //            }
                break
                
            default:
                print("Screen is not available.")
                break
            }
        default:
            print("Something's wrong!")
        }
    }
}
