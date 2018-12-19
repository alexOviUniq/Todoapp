//
//  ViewController.swift
//  Todoapp
//
//  Created by alex oviedo on 13/12/2018.
//  Copyright © 2018 alex oviedo. All rights reserved.
//

import UIKit
import RealmSwift

class TodoListViewController: UITableViewController {

    var items : Results<Item>?
    let realm = try! Realm()
    
    var selectedCategory : Category?{
        didSet{
            loadItems()
        }
    }
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date = Date()
        let formatter = DateFormatter()
        
        print(date)
        print(formatter)
    }
    
    //MARK - Table Datasource Methodsa
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return items?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = items?[indexPath.row] {
            
            cell.textLabel?.text = item.title
            
            //cell.tintColor = UIColor.init(red: 69.0, green: 204.0, blue: 119.0, alpha: 1.0)
            cell.tintColor = UIColor.black

            cell.accessoryType = item.done ? .checkmark : .none
            
        } else {
            cell.textLabel?.text = "No Items Added"
        }
        
       
       
        return cell
    }
    
    //MARK - TableView Delegate Methods
    
  
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        if let item = items?[indexPath.row] {
            
            do {
                try realm.write {
                    item.done = !item.done
                }
            } catch {
                 print("Error saving done status \(error)")
            }
        }
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todo item", message: "", preferredStyle: .alert)
        
        
        let action = UIAlertAction(title: "Add item", style: .default) { (action) in
      
            if let currentCategory = self.selectedCategory {
                do {
                    try self.realm.write {
                        
                        let newItem = Item()
                        newItem.dateCreated = Date()
                        newItem.title = textField.text!
                        currentCategory.items.append(newItem)
                    }
                } catch {
                     print("Error saving item \(error)")
                }
               
            }
            
            self.tableView.reloadData()
            
            
            //self.saveItems(item: newItem)
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField =  alertTextField
            
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    
    
    //MARK - MOdel Manipulation Methods
    func loadItems() {

       items = selectedCategory?.items.sorted(byKeyPath: "title", ascending: true)
        
       tableView.reloadData()

    }
    
    
}

//MARK - SearchBar Methods

extension TodoListViewController: UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        items = items?.filter("title CONTAINS[cd] %@", searchBar.text!).sorted(byKeyPath: "dateCreated", ascending: true)
        
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
