//
//  CategoryViewController.swift
//  Todoooo
//
//  Created by Hyder on 3/21/18.
//  Copyright © 2018 Ema Hyder. All rights reserved.
//

import UIKit
import RealmSwift

class CategoryViewController: UITableViewController {
    let realm = try! Realm()
    
    var categories : Results<Category>?

 
    override func viewDidLoad() {
        super.viewDidLoad()
        loadCategories()

        
    }
////Mark: - tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories?.count ?? 1

    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        cell.textLabel?.text = categories?[indexPath.row].name ?? "No Categories added yet"




        return cell
    }

   //MARK: - tableview Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      performSegue(withIdentifier: "goToItem", sender: self)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        if let indexPath = tableView.indexPathForSelectedRow {
           destinationVC.selectedCategory = categories?[indexPath.row]
        }
    }
    //Mark: tableview Manipulation Methods
    func save(category : Category) {
        do {
            try realm.write {
                realm.add(category)
            }
        } catch {
            print("Error in saving items \(error)")
        }
        self.tableView.reloadData()
    }
    
    func loadCategories() {
        
     categories = realm.objects(Category.self)
        
        tableView.reloadData()
    }
    

    

    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default) { (action) in
            let newCategory = Category()
            newCategory.name = textField.text!
         
            self.save(category: newCategory)
        }
        alert.addTextField { (alertTextfield) in
            alertTextfield.placeholder = "Create new category"
            textField = alertTextfield
            
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
 
    
 
    
    
    
    
    
    
    
    
    
}
