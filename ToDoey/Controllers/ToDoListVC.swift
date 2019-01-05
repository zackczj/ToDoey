//
//  ViewController.swift
//  ToDoey
//
//  Created by Zack Chng on 31/12/18.
//  Copyright © 2018 Zack. All rights reserved.
//

import UIKit

class ToDoListVC: UITableViewController {

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        let newItem1 = Item()
        newItem1.title = "Find Mike"
        itemArray.append(newItem1)
        
        let newItem2 = Item()
        newItem2.title = "Save the world"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Buy eggos"
        itemArray.append(newItem3)
        

        

        
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item] {
           itemArray = items
       }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //Ternary Operator
        cell.accessoryType = item.done ? .checkmark : .none
        
//      Ternary Operator replacing below code
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//                cell.accessoryType = .none
//            }
        
        return cell
        
    }
    
    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        print("CellForRowAtIndexPath Called")
        
    //MARK - Checkmark method
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
       
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add to do", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (alert) in
            // What will happen once user clicks add item button on UIAlert
        
            let newItem = Item()
            newItem.title = textField.text!
            
        self.itemArray.append(newItem)
            print("\(textField.text!) Added")
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            self.tableView.reloadData()
        }
        
        // Add features in alert controller
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Drink water"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
        
    }
    
    
}

