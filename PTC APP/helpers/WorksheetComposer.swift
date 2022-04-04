//
//  WorksheetComposer.swift
//  PTC APP
//
//  Created by Jaldeep Patel on 2022-03-28.
//  Copyright © 2022 Gurlagan Bhullar. All rights reserved.
//

import UIKit

class WorksheetComposer: NSObject {

     let pathToWorksheetHTMLTemplate = Bundle.main.path(forResource: "PTC_Worksheet-2", ofType: "html")
    
     let logo = Bundle.main.path(forResource: "PTC_Logo1", ofType: "jpg")
     let titleImage = Bundle.main.path(forResource: "PTC-cover", ofType: "jpg")
       
   
       let communicationSituation: String! = ""
       let date: String! = ""
       let them1: String! = ""
       let them2: String! = ""
       let them3: String! = ""
       let appreciate1: String! = ""
       let appreciate2: String! = ""
       let appreciate3: String! = ""
       let remember1: String! = ""
       let remember2: String! = ""
       let remember3: String! = ""
       let obstacles1: String! = ""
       let obstacles2: String! = ""
       let obstacles3: String! = ""
       let feel1: String! = ""
       let feel2: String! = ""
       let feel3: String! = ""
       let value1: String! = ""
       let value2: String! = ""
       let value3: String! = ""
       let do1: String! = ""
       let do2: String! = ""
       let do3: String! = ""
       let you1: String! = ""
       let you2: String! = ""
       let you3: String! = ""
    
    override init() {
        super.init()
        
    }
   
 
    func renderInvoice(communicationSituation: String,
    date: String,them1: String,them2: String,them3: String,appreciate1: String,appreciate2: String,appreciate3: String,remember1: String,remember2: String,remember3: String,obstacles1: String,obstacles2: String,obstacles3: String,feel1: String,feel2: String,feel3: String,value1: String,value2: String,value3: String,do1: String,do2: String,do3: String,you1: String,you2: String,you3: String) -> String! {
        
        
        do {
            // Load the invoice HTML template code into a String variable.
            var HTMLContent = try String(contentsOfFile: pathToWorksheetHTMLTemplate!)
     
            // Replace all the placeholders with real values except for the items.
            // The logo image.
            //HTMLContent = HTMLContent.stringByReplacingOccurrencesOfString("#LOGO_IMAGE#", withString: logoImageURL)
             //  Logo
            HTMLContent = HTMLContent.replacingOccurrences(of: "#LOGO_IMG#", with:  "/Users/jaldeep_patel/Documents/PTC/HTMLTemplate/PTC_Logo1.jpg")
            HTMLContent = HTMLContent.replacingOccurrences(of: "#TITLE_IMG#", with: titleImage ?? "")
            // communicationSituation Name.
            HTMLContent = HTMLContent.replacingOccurrences(of: "#COMMUNICATION_SITUATION#", with: communicationSituation)
     
            // Invoice date.
            HTMLContent = HTMLContent.replacingOccurrences(of: "#DATE#", with: date)
     
            // Due date (we leave it blank by default).
            HTMLContent = HTMLContent.replacingOccurrences(of: "#THEM_1#", with: them1)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#THEM_2#", with: them2)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#THEM_3#", with: them3)
     
            // Sender info.
            HTMLContent = HTMLContent.replacingOccurrences(of: "#APPRECIATE_1#", with: appreciate1)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#APPRECIATE_2#", with: appreciate2)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#APPRECIATE_3#", with: appreciate3)
            
            // Sender info.
            HTMLContent = HTMLContent.replacingOccurrences(of: "#OBSTACLES_1#", with: obstacles1)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#OBSTACLES_2#", with: obstacles2)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#OBSTACLES_3#", with: obstacles3)
            
            // Sender info.
            HTMLContent = HTMLContent.replacingOccurrences(of: "#REMEMBER_1#", with: remember1)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#REMEMBER_2#", with: remember2)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#REMEMBER_3#", with: remember3)
            
            // Sender info.
            HTMLContent = HTMLContent.replacingOccurrences(of: "#VALUE_1#", with: value1)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#VALUE_2#", with: value2)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#VALUE_3#", with: value3)
            
            // Sender info.
            HTMLContent = HTMLContent.replacingOccurrences(of: "#FEEL_1#", with: feel1)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#FEEL_2#", with: feel2)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#FEEL_3#", with: feel3)
            
            // Sender info.
            HTMLContent = HTMLContent.replacingOccurrences(of: "#YOU_1#", with: you1)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#YOU_2#", with: you2)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#YOU_3#", with: you3)
            
            // Sender info.
            HTMLContent = HTMLContent.replacingOccurrences(of: "#DO_1#", with: do1)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#DO_2#", with: do2)
            HTMLContent = HTMLContent.replacingOccurrences(of: "#DO_3#", with: do3)
     
            
            return HTMLContent
     
        }
        catch {
            print("Unable to open and use HTML template files.")
        }
        
        return nil
     
    }

    func exportHTMLContentToPDF(HTMLContent: String,comunicationStituation: String,FolderName: String) {
        let printPageRenderer = CustomPrintPageRenderer()
     
        let printFormatter = UIMarkupTextPrintFormatter(markupText: HTMLContent)
        printPageRenderer.addPrintFormatter(printFormatter, startingAtPageAt: 0)
     
        let pdfData = drawPDFUsingPrintPageRenderer(printPageRenderer: printPageRenderer)
     
        let pdfFilename = "\(AppDelegate.getAppDelegate().getDocDir())/\("\(FolderName)")/\("\(comunicationStituation)").pdf"
        pdfData?.write(toFile: pdfFilename, atomically: true)
     
        print(pdfFilename)
    }
  
    
    
    func drawPDFUsingPrintPageRenderer(printPageRenderer: UIPrintPageRenderer) -> NSData! {
        let data = NSMutableData()
     
        UIGraphicsBeginPDFContextToData(data, CGRect.zero, nil)
     
        UIGraphicsBeginPDFPage()
     
        printPageRenderer.drawPage(at: 0, in: UIGraphicsGetPDFContextBounds())
     
        UIGraphicsEndPDFContext()
     
        return data
    }
    
}

