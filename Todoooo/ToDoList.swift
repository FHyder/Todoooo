//
//  ViewController.swift
//  Todoooo
//
//  Created by Hyder on 3/12/18.
//  Copyright © 2018 Ema Hyder. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
var itemArray = ["Learn Code", "Complete Udemy Projects", "Complete Udacity Projects", "Apply for Jobs", "Make money"]

 let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let items = defaults.array(forKey: "ToDoListArray") as? [String] {
            itemArray = items
        }
        // Do any additional setup after loading the view, typically from a nib.
    }

  //MAKR - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
        
    }
    
    
    //Mark Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
        if  tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
      
        tableView.deselectRow(at: indexPath, animated: true)
    }

 //MARK -  Add new button
    
    @IBAction func addButtonPressed(_ sender: Any) {
    var textField = UITextField()
        let alert = UIAlertController(title: "Add New ToDoo Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
          self.itemArray.append(textField.text!)
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

