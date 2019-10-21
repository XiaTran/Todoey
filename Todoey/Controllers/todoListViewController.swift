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

    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")

    override func viewDidLoad() {
        super.viewDidLoad()

            print(dataFilePath)

        self.loadItems()
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
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        self.saveItems()

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

            self.saveItems()

        }

        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new Item"
            textField = alertTextField
        }

        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }

    private func saveItems() {
        let encoder = PropertyListEncoder()
        guard let dataFilePath = self.dataFilePath else { return }

        do {
            let data = try encoder.encode(itemArray)
            try data.write(to: dataFilePath)
        } catch {
            print("Error encoding item array, \(error)")
        }

        self.tableView.reloadData()
    }

    private func loadItems() {
        guard let dataFilePath = self.dataFilePath else { return }
        let decoder = PropertyListDecoder()

        do {
        let data = try Data(contentsOf: dataFilePath)
            itemArray = try decoder.decode([Item].self, from: data)
        } catch {
            print("Error decoding item Array, \(error)")
        }
    }



}
