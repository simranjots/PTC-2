//
//  ToDoParent.swift
//  To Do list
//
//  Created by Gurlagan Bhullar on 2019-04-02.
//  Copyright © 2019 Gurlagan Bhullar. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import MapKit

class ToDoParent: UIViewController, CLLocationManagerDelegate {
    
    // Items list to store todos
    public var todoList: [ToDo] = []
    public func loadData()->Bool{
        let request:NSFetchRequest<ToDo> = ToDo.fetchRequest()
        print("his is req")
        do{
            if let context = context{
                 print("this is context")
                todoList = try context.fetch(request)
                return true
            }
        }catch{
            print("Error fetching data")
        }
        return false
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      
      //1
//      guard let appDelegate =
//        UIApplication.shared.delegate as? AppDelegate else {
//          return
//      }
//
//      let managedContext =
//        appDelegate.persistentContainer.viewContext
//
      //2
      let fetchRequest =
        NSFetchRequest<NSManagedObject>(entityName: "ToDo ")
        print(fetchRequest)
      
      //3
     
    }



    
    @IBOutlet weak var myTableView: UITableView!
    // Core data context
    public var context: NSManagedObjectContext?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//clearCoreData()
        print(loadData())
        context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
               
       print(todoList)
        print("aaaaaaaaaaaaaaa")
    }
    
    // Load data from  coredata
}
extension ToDoParent: UITableViewDelegate, UITableViewDataSource{
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ToDoItemCell
        cell.title.text = todoList[indexPath.item].title
        cell.subtitle.text = todoList[indexPath.item].date
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailSegueId", sender: indexPath.row)
    }
    
    
    func clearCoreData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ToDo")
        
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try managedContext.fetch(fetchRequest)
            
            for managedObject in results {
                if let managedObjectData = managedObject as? NSManagedObject {
                    managedContext.delete(managedObjectData)
                }
            }
        } catch {
            print(error)
        }
    }
    
    
    
}


