//
//  ViewController.swift
//  Todoooo
//
//  Created by Hyder on 3/12/18.
//  Copyright © 2018 Ema Hyder. All rights reserved.
//

import UIKit
import RealmSwift

class ToDoListViewController: UITableViewController {

    var realm = try! Realm()
    var toDoItems : Results<Item>?
    
    var selectedCategory : Category? {
        didSet {
            loadItems()
        }
    }
    
 


    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))

       
   
        

  
    }

  //MAKR - Tableview Datasource Methods
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoItems?.count ?? 1
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
 
        if let item = toDoItems?[indexPath.row] {
            cell.textLabel?.text = item.name
            
            cell.accessoryType = item.done ? .checkmark : .none
        } else {
            cell.textLabel?.text = "No Items Added"
        }
        
        
        return cell
    }
    
   
    
    
    //Mark Tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let item = toDoItems?[indexPath.row] {
            do {
            try realm.write {
                item.done = !item.done
            }
            } catch {
                print("Error updatind data \(error)")
            }
        }
        tableView.reloadData()
        

      
        tableView.deselectRow(at: indexPath, animated: true)
    }

 //MARK -  Add new button
    
    @IBAction func addButtonPressed(_ sender: Any) {
    var textField = UITextField()
        let alert = UIAlertController(title: "Add New ToDoo Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
         // what will happen once the user clicks the Add Item button on our UI

            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                    let newItem = Item()
                    
                    newItem.name = textField.text!
                    newItem.dateCreated = Date()
                    currentCategory.items.append(newItem)
                
                    }
                } catch {
                    print(error)
                }
            self.tableView.reloadData()
            
            }
            
           
        
        }
        
        alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "Create new item"
            textField = alertTextfield
            
        }
       alert.addAction(action)
       present(alert, animated: true, completion: nil)
    }

    
    func loadItems() {
    toDoItems = selectedCategory?.items.sorted(byKeyPath: "name", ascending: true)
        

        tableView.reloadData()
    }

  
    
   
}


extension ToDoListViewController : UISearchBarDelegate {
 func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
toDoItems = toDoItems?.filter("name CONTAINS[cd] %@", searchBar.text).sorted(byKeyPath: "dateCreated", ascending: true)

tableView.reloadData()
    
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        if searchBar.text?.count == 0 {
            loadItems()

            DispatchQueue.main.async {
               searchBar.resignFirstResponder()
            }

        }
    }

}

