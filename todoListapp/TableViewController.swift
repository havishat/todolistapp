//
//  TableViewController.swift
//  todoListapp
//
//  Created by havisha tiruvuri on 9/15/17.
//  Copyright © 2017 havisha tiruvuri. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController, todolistdelegate{
    
 var list = [Todolist]()
//    var list = [["book","notes on the book","9/13/2017"],"book","notes on the book","9/13/2017"]]
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext //scrach pad where we can add and delete stuff
    

    @IBOutlet var tableview: UITableView!
    
    
    func fetchAllItems() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Todolist")
        do {
            let result = try managedObjectContext.fetch(request)
            list = result as! [Todolist]
        } catch {
            print("\(error)")
        }
        
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todolistview") as! TableViewCell
        cell.TitleLabel?.text = list[indexPath.row].title
        cell.NotesLabel?.text = list[indexPath.row].notes
        cell.DateLabel?.text = list[indexPath.row].date
        if list[indexPath.row].checklist == false {
        cell.accessoryType = UITableViewCellAccessoryType.none
        } else {
            cell.accessoryType = UITableViewCellAccessoryType.checkmark
        }
        return cell
    }
    
    
    // tableview add
    @IBAction func addButton(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "additem", sender: sender)
    }
    
//    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath:IndexPath) {
//        
//        performSegue(withIdentifier: "additem", sender: indexPath)
//        
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "additem" {
            let controller = segue.destination as! ViewController
            controller.delegate = self
        }
    }
    
    
    
    func add(by: UIViewController, title: String, notes: String, date: String){
        let item = NSEntityDescription.insertNewObject(forEntityName: "Todolist", into: managedObjectContext) as! Todolist
        item.title = title
        item.date = date
        item.notes = notes
        item.checklist = true
        list.append(item)
        do {
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
        tableView.reloadData()
//        dismiss(animated: true, completion: nil)
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //add check mark when the user type the cell
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCellAccessoryType.checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.none
            list[indexPath.row].checklist =  false
        } else {
               tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCellAccessoryType.checkmark
                list[indexPath.row].checklist = true
           }
        do {
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
        
}

    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems()
//        print(x)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    

}



