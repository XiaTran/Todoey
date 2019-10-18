//
//  TodoListViewController.swift
//  Todoey
//
//  Created by Xia Tran on 2019/10/18.
//  Copyright © 2019 Xia Tran. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    let itemArray = ["task 1", "taks 2", "task 3"]

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    //Mark - TableView Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoItemCell", for: indexPath)

        cell.textLabel?.text = itemArray[indexPath.row]
        return cell
    }

    //Mark - TableView Delegate Methods
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(itemArray[indexPath.row])

        if tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }

        tableView.deselectRow(at: indexPath, animated: true)
    }

}

