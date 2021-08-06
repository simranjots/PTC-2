////
////  historyViewController.swift
////  PTC APP
////
////  Created by Gurlagan Bhullar on 2020-03-10.
////  Copyright © 2020 Gurlagan Bhullar. All rights reserved.
////
//
//import UIKit
//import CoreData
//
//class historyViewController:ToDoParent {
//   var Videos: [video] = []
//   // var tempVideo : [video] = []
//    var videos: [ToDo] = []
//    
//     var titleText: String?
//    @IBOutlet weak var addVideoTestField: UITextField!
//    @IBOutlet weak var tableView: UITableView!
//    override func viewWillAppear(_ animated: Bool) {
//           super.viewWillAppear(animated)
//           reloaddata()
//         }
//     func reloaddata(){
//         let request : NSFetchRequest<ToDo> = ToDo.fetchRequest()
//        let sort = NSSortDescriptor(key: "title", ascending: true)
//        let sort2 = NSSortDescriptor(key: "appreciate", ascending: true)
//        
//         request.sortDescriptors = [sort]
//         self.tableView.reloadData()
//     //
//         }
//       
//    override func viewDidLoad() {
//        super.viewDidLoad()
//       // Videos = createArray()
//        tableView.delegate = self as! UITableViewDelegate
//        tableView.dataSource = self as! UITableViewDataSource
//        tableView.tableFooterView = UIView(frame: CGRect.zero)
//       
//    
//        tableView.layoutMargins = UIEdgeInsets.zero
//        tableView.separatorInset = UIEdgeInsets.zero
//        
//        context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
//              
//              // load todo list data
//              if loadData(){
//                  tableView.reloadData()
//              }
//        if let context = self.context{
//                        
//                        let todo = ToDo(context: context)
//                       
//
//                            do{
//                                try context.save()
//                                self.tableView.reloadData()
//                                print(todo)
//                            }catch{
//                                fatalError("Error storing data")
//                            }
//                       // }
//                    }
//    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "MasterToDetail"{
//            
//            let destVC = segue.destination as! DetailViewController
//            destVC.passingValue = titleText
//            
//        }
//    }
//  
//
//}
//extension historyViewController {
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return todoList.count
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoCell", for: indexPath) as! videoCell
//        cell.historyDataLabel.text = todoList[indexPath.item].title
//        return cell
//    }
//    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        titleText = todoList[indexPath.row].title
//        
//        performSegue(withIdentifier: "MasterToDetail", sender: titleText)
//        print(todoList[indexPath.item].title)
//    }
//      func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//    
//              if editingStyle == .delete {
//                  todoList.remove(at: indexPath.row)
//    
//                  tableView.beginUpdates()
//                  tableView.deleteRows(at: [indexPath], with: .automatic)
//                  tableView.endUpdates()
//              }
//          }
//
//    
//
//}
