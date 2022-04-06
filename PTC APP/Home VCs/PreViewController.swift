//
//  PreViewController.swift
//  PTC APP
//
//  Created by Simranjot Singh on 2022-04-05.
//  Copyright © 2022 Gurlagan Bhullar. All rights reserved.
//

import UIKit
import WebKit
import RealmSwift

class PreViewController: UIViewController {

    @IBOutlet weak var preview: WKWebView!
    @IBOutlet weak var pdfBtn: UIBarButtonItem!
    let realm = try! Realm()
    var worksheetComposer: WorksheetComposer!
    var folderobject: FolderData?
    var activityNameArray : Results<SituationData>?
    var FolderName: String = ""
    var myIndex = 0
    var HTMLContent: String!
    var data : SituationData!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        data = folderobject!.situationData[myIndex]
        createInvoiceAsHTML()
    }
    
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func pdfBtnPressed(_ sender: Any) {

        print()
         //worksheetComposer.exportHTMLContentToPDF(HTMLContent: HTMLContent, comunicationStituation: data.situationTitle, FolderName: FolderName)
    }
    func print(){
        let pInfo :UIPrintInfo =  UIPrintInfo.printInfo()
            pInfo.outputType = UIPrintInfo.OutputType.general
            pInfo.jobName = data.situationTitle //page title defined elsewhere
            pInfo.orientation = UIPrintInfo.Orientation.portrait
            
            let printController = UIPrintInteractionController.shared
            printController.printInfo = pInfo
        
            printController.printFormatter = preview.viewPrintFormatter()
            printController.present(animated: true, completionHandler: nil)
    }
    
    
    
    func createInvoiceAsHTML() {
        worksheetComposer = WorksheetComposer()
        activityNameArray = realm.objects(SituationData.self)
            if let workSheetHTML = worksheetComposer.renderInvoice(communicationSituation: data.situationTitle, date: "\(folderobject?.situationData[myIndex].date ?? "" ) | " + "\( activityNameArray![self.myIndex].time)", them1: data.them1, them2: data.them2, them3: data.them3, appreciate1: data.appreciate1, appreciate2: data.appreciate2, appreciate3: data.appreciate3, remember1: data.remember1, remember2: data.remember2, remember3: data.remember3, obstacles1: data.obstacle1, obstacles2: data.obstacle2, obstacles3: data.obstacle3, feel1: data.feel1, feel2: data.feel2, feel3: data.feel3, value1: data.value1, value2: data.value2, value3: data.value3, do1: data.doitem1, do2: data.doitem2, do3: data.doitem3, you1: data.you1, you2: data.you2, you3: data.you3) {
         
                preview.loadHTMLString(workSheetHTML, baseURL: NSURL(string: worksheetComposer.pathToWorksheetHTMLTemplate!) as URL?)
                       HTMLContent = workSheetHTML
            }
        
        
      
    }
   

}
