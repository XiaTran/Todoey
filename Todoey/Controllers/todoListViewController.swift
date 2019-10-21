//
//  TodoListViewController.swift
//  Todoey
//
//  Created by Xia Tran on 2019/10/18.
//  Copyright © 2019 Xia Tran. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    let defaults = UserDefaults.standard


    override func viewDidLoad() {
        super.viewDidLoad()

        let newItem = Item()
        newItem.title = "task 1"
        itemArray.append(newItem)

        let newItem2 = Item()
        newItem2.title = "task 2"
        itemArray.append(newItem2)

        if let items = defaults.array(forKey: "TodoListArray") as? [Item] {
            itemArray = items
        }
    }

    //MARK - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoItemCell", for: indexPath)

        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title

         cell.accessoryType = item.done ? .checkmark : .none

        return cell
    }

    //MARK - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        //If it's true, it'll equal to false. if it's false, it'll equal to true. Same code as below.
        //        if itemArray[indexPath.row].done == false {
        //            itemArray[indexPath.row].done = true
        //        } else {
        //            itemArray[indexPath.row].done = false
        //        }
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done

        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)
    }

    //MARK - Add New Items
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {

        var textField = UITextField()

        let alert = UIAlertController(title: "Add new Todoey Item", message: "", preferredStyle: .alert)

        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What will happen when user clicks button on UIAlert
            let newItem = Item()
            guard let text = textField.text else { return }
            newItem.title = text
            self.itemArray.append(newItem)

            //Save item in the array to the userDefaults
            self.defaults.set(self.itemArray, forKey: "TodoListArray")

            self.tableView.reloadData()

        }

        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item"
            textField = alertTextField
        }

        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }



}
