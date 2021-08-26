//
//  Extenstion.swift
//  PTC APP
//
//  Created by Simranjot Singh Bagga on 2021-08-06.
//  Copyright © 2021 Gurlagan Bhullar. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    
    func shortDateFormat() -> Date?{
        
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let myString = formatter.string(from: self) // string purpose I add here
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = "dd-MM-yyyy"
        // again convert your date to string
        let myStringafd = formatter.string(from: yourDate!)
        
        let finalDate = formatter.date(from: myStringafd)
        //        print(myStringafd)
        // Do any additional setup after loading the view.
        return finalDate
        
    }
    func shortdateToString() -> String?{
        
        let formatter = DateFormatter()
        
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let myString = formatter.string(from: self) // string purpose I add here
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = "MMM d, yyyy"
        // again convert your date to string
        let myStringafd = formatter.string(from: yourDate!)
        
        //        let finalDate = formatter.date(from: myStringafd)
        //        print(myStringafd)
        // Do any additional setup after loading the view.
        return myStringafd
        
    }
    
    
    
    
    func longDateToString() -> String?{
        
        let formatter = DateFormatter()
        
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let myString = formatter.string(from: self) // string purpose I add here
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = "dd-MM-yyyy"
        // again convert your date to string
        let myStringafd = formatter.string(from: yourDate!)
        
        //        let finalDate = formatter.date(from: myStringafd)
        //        print(myStringafd)
        // Do any additional setup after loading the view.
        return myStringafd
        
    }
    
    func originalFormat() -> Date {
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let myString = formatter.string(from: self) // string purpose I add here
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        return yourDate!
    }
    func currentTime() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mm a"
        let time = dateFormatter.string(from: Date())
        return time
        
    }
    
    
    
}

extension String{
    
    func stringToDate() -> Date {
        
        let fmt = DateFormatter()
        fmt.dateFormat = "dd/MM/yyyy"
        return fmt.date(from: self)!
        
    }
    
    var isValidEmail: Bool{
        
        let emailRegex = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,3}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", argumentArray: [emailRegex])
        
        return emailTest.evaluate(with: self)
        //        return  true
        
    }
    var isValidPassword: Bool{
        
        let passRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}"
        let passTest = NSPredicate(format: "SELF MATCHES %@", argumentArray: [passRegex])
        
        return passTest.evaluate(with: self)
        
        //        return true
    }
    
}
extension UIViewController {
    
    func showToast(message : String, duration: Double, height: Int) {
        let overlayView = UIView()
        let backView = UIView()
        let lbl = UILabel()
        
        backView.frame = CGRect(x: 0, y: 0, width: view.frame.width , height: view.frame.height)
        overlayView.backgroundColor = .white
        overlayView.alpha = 0.0
        overlayView.layer.cornerRadius = 10;
        overlayView.clipsToBounds  =  true
        view.addSubview(backView)
        
        overlayView.frame = CGRect(x: 0, y: 0, width: Int(view.frame.width) - 40, height: 70 - height)
        overlayView.center = CGPoint(x: view.bounds.width / 2, y: view.bounds.height - 150)
        overlayView.backgroundColor = .black
        overlayView.alpha = 0.0
        overlayView.layer.cornerRadius = 10;
        overlayView.clipsToBounds  =  true
        
        lbl.frame = CGRect(x: 0, y: 0, width: overlayView.frame.width, height: 70)
        lbl.numberOfLines = 0
        lbl.textColor = UIColor.white
        lbl.textAlignment = .center;
        lbl.font.withSize(12.0)
        lbl.text = message
        lbl.clipsToBounds  =  true
        lbl.numberOfLines = 0
        lbl.center = CGPoint(x: overlayView.bounds.width / 2, y: overlayView.bounds.height / 2)
        overlayView.addSubview(lbl)
        view.addSubview(overlayView)
        
        UIView.animate(withDuration: 1, animations: {
            overlayView.alpha = 1
        }) { (true) in
            
            UIView.animate(withDuration: duration, animations: {
                overlayView.alpha = 1
            }) { (true) in
                UIView.animate(withDuration: duration, animations: {
                    overlayView.alpha = 0
                }) { (true) in
                    UIView.animate(withDuration: 1, animations: {
                        DispatchQueue.main.async(execute: {
                            overlayView.alpha = 0
                            lbl.removeFromSuperview()
                            overlayView.removeFromSuperview()
                            backView.removeFromSuperview()
                        })
                    })
                }
            }
        }
    }
    
    
    func showAlert(title:String, message: String, buttonTitle: String) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: buttonTitle, style: .cancel, handler: nil))
       
        self.present(alert, animated: true, completion: nil)
        
    }
    func showAlertforQuestionMark(vc: UIPopoverPresentationControllerDelegate,title:String, message: [String], buttonTitle: String,buttonType: UIButton) {
        
        // get a reference to the view controller for the popover
                let popController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PopoverContentController") as? NewPasteOptionViewController
         
                // set the presentation style
        popController!.modalPresentationStyle = UIModalPresentationStyle.popover

                // set up the popover presentation controller
        popController?.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.any
        popController?.popoverPresentationController?.delegate = vc
        popController?.popoverPresentationController?.sourceView = buttonType // button
        popController?.popoverPresentationController?.sourceRect = buttonType.bounds
     
        popController?.message = message
        popController?.labelName = title
                // present the popover
        self.present(popController!, animated: true, completion: nil)
        
    }
    
    func createDoneToolBar(textField: UITextField){
        
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
//        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(addTodayViewController.dismissKeyboard))
//
        //toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        textField.inputAccessoryView = toolBar
        
    }
    
    @objc func dismissKeyboard() {
        
        view.endEditing(true)
    }
    
}
