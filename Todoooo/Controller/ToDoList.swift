//
//  ViewController.swift
//  Todoooo
//
//  Created by Hyder on 3/12/18.
//  Copyright © 2018 Ema Hyder. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
var itemArray = [Item]()

 let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let newItem = Item()
        newItem.name = "Complete Udemy"
        itemArray.append(newItem)
        
        let newItem4 = Item()
        newItem4.name = "Complete Udacity"
        itemArray.append(newItem4)
        
        let newItem2 = Item()
        newItem2.name = "Start Job hunting"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.name = "Stop being broke"
        itemArray.append(newItem3)
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
            itemArray = items
        }
  
    }

  //MAKR - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = itemArray[indexPath.row].done
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row].name
        
        
        cell.accessoryType = item ? .checkmark : .none
        
        return cell
    }
    
   
    
    
    //Mark Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      itemArray[indexPath.row].done = !itemArray[indexPath.row].done
       
      tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }

 //MARK -  Add new button
    
    @IBAction func addButtonPressed(_ sender: Any) {
    var textField = UITextField()
        let alert = UIAlertController(title: "Add New ToDoo Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
         
        let newItem = Item()
        newItem.name = textField.text!
            self.itemArray.append(newItem)
          self.defaults.set(self.itemArray, forKey: "ToDoListArray")
        self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "Create new item"
            textField = alertTextfield
            
        }
       alert.addAction(action)
       present(alert, animated: true, completion: nil)
    }
    
}

