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
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let defaults = UserDefaults.standard
    
    // Singleton -- Accessing Document Directory to Store data in App Sandbox - via a PATH
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        
//        // Default Examples
        let newItem1 = Item(context: context)
        newItem1.title = "Find Mike"
        itemArray.append(newItem1)
//
//        loadItems()
        
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
    // ! switches Boolean form
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        tableView.reloadData()
        
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //MARK - Add new items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
       
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add to do", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add", style: .default) { (alert) in
            // What will happen once user clicks add item button on UIAlert
        
           
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            
        self.itemArray.append(newItem)
            print("\(textField.text!) Added")
            
            self.saveItems()

            
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
    
    func saveItems() {
        

        do {
           try context.save()
        } catch {
            print ("Error saving context, \(error)")
        }
        
    }
    
//    func loadItems() {
//        if let data = try? Data(contentsOf: dataFilePath!) {
//            let decoder = PropertyListDecoder()
//            do {
//            itemArray = try decoder.decode([Item].self, from: data)
//            } catch {
//                print ("Error decoding, \(error)")
//            }
//        }
//    }
//

    
}

