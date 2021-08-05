//
//  HomeViewController.swift
//  PTC APP
//
//  Created by Jaldeep Patel on 2021-08-04.
//  Copyright © 2021 Gurlagan Bhullar. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var sideMenuTableView: UITableView!
    @IBOutlet var sideMenuView: UIView!
    
    let menuItems = ["Home", "Profile", "Use Instructions", "About Author", "Privacy Policy", "Contact Us", "Sign Out"]
    let menuIcons = ["home", "profile", "instructions", "about-author", "privacy-policy", "contact-us", "sign-out"]
    var isSideViewOpened: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Hide Menubar on ViewDidLoad
        sideMenuView.isHidden = true
        sideMenuTableView.backgroundColor = UIColor.systemBackground
        isSideViewOpened = false
        
        //Add shadow to Menubar
        Utilities.addShadowAndBorderToView(sideMenuView)
        sideMenuView.layer.borderWidth = 0
        
    }

    
    @IBAction func sideMenuButtonTapped(_ sender: UIBarButtonItem) {
        
        sideMenuView.isHidden = false
        sideMenuTableView.isHidden = false
        self.view.bringSubviewToFront(sideMenuView)
        
        if !isSideViewOpened {
            isSideViewOpened = true
            sideMenuView.frame = CGRect(x: 0, y: 88, width: 0, height: 350)
            sideMenuTableView.frame = CGRect(x: 0, y: 0, width: 0, height: 350)
            
            UIView.animate(withDuration: 0.7) {
                self.sideMenuView.frame = CGRect(x: 0, y: 88, width: 250, height: 350)
                self.sideMenuTableView.frame = CGRect(x: 0, y: 0, width: 250, height: 350)
            }
        } else {
            sideMenuView.isHidden = true
            sideMenuTableView.isHidden = true
            isSideViewOpened = false

            sideMenuView.frame = CGRect(x: 0, y: 88, width: 250, height: 350)
            sideMenuTableView.frame = CGRect(x: 0, y: 0, width: 250 , height: 350)

            UIView.animate(withDuration: 0.7) {
                self.sideMenuView.frame = CGRect(x: 0, y: 88, width: 0, height: 350)
                self.sideMenuTableView.frame = CGRect(x: 0, y: 0, width: 250, height: 350)
            }
        }
    }
    
    
    @IBAction func addActivityButtonTapped(_ sender: UIBarButtonItem) {
    
    }
    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.homeScreenMenuBarCell, for: indexPath) as! SideMenuTableViewCell
        
        cell.menuLabel.text = menuItems[indexPath.row]
        cell.menuIconImageView.image = UIImage(named: menuIcons[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
                
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
    }
}
