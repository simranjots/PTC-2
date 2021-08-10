//
//  historySitution.swift
//  PTC APP
//
//  Created by Gurlagan Bhullar on 2020-02-17.
//  Copyright © 2020 Gurlagan Bhullar. All rights reserved.
//
//
//import Foundation
//import UIKit
//import CoreData
//class historySitution : UIViewController{
//      var titleText: String?
//    //var data : String = ""
//
//
//    @IBOutlet weak var tableView: UITableView!
//    override func viewDidLoad() {
//
//       retrieveData()
//        //deleteData()
//        // clearCoreData()
//    }
//
//   func retrieveData() {
//
//           //As we know that container is set up in the AppDelegates so we need to refer that container.
//           guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
//
//           //We need to create a context from this container
//           let managedContext = appDelegate.persistentContainer.viewContext
//            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDo")
//           do {
//               let result = try managedContext.fetch(fetchRequest)
//            for data in result as! [NSManagedObject] {
//                   print(data.value(forKey: "date") as! String)
//               //  let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ToDoItemCell
//                // cell.title.text = ""
//
////                print(data.value(forKey: "them") as! String)
////
//               }
//
//           } catch {
//
//               print("Failed")
//           }
//       }
//       func reloaddata(){
//        let request : NSFetchRequest<ToDo> = ToDo.fetchRequest()
//        let sort = NSSortDescriptor(key: "title", ascending: true)
//
//        self.tableView.reloadData()
//        }
//
//    func clearCoreData() {
//          let appDelegate = UIApplication.shared.delegate as! AppDelegate
//          let managedContext = appDelegate.persistentContainer.viewContext
//
//          let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDo")
//
//          fetchRequest.returnsObjectsAsFaults = false
//
//          do {
//              let results = try managedContext.fetch(fetchRequest)
//
//              for managedObject in results {
//                  if let managedObjectData = managedObject as? NSManagedObject {
//                      managedContext.delete(managedObjectData)
//                   // print("okay done")
//                  }
//              }
//          } catch {
//              print(error)
//          }
//      }
//
//}
