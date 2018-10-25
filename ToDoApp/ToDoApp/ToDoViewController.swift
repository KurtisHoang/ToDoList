//
//  ViewController.swift
//  ToDoApp
//
//  Created by Kurtis Hoang on 10/22/18.
//  Copyright © 2018 Kurtis Hoang. All rights reserved.
//

import UIKit

class ToDoViewController: UITableViewController {

    var toDoList : [String] = ["Work", "School", "Homework"]
    var selected: String?
    
    override func viewDidLoad() {
        title = "To Do List"
        
        if let savedToDoList = UserDefaults.standard.object(forKey: "toDoList") {
            toDoList = savedToDoList as! [String]
        }
    }
    
    //tells us how many rows per section
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return toDoList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let toDo = toDoList[indexPath.row]
        
        //create a new cell that is a ToDoCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell") as! ToDoCell
        cell.textLabel?.text = toDo
        cell.todo = toDo
        
        return cell
    }
    
    /*
    //removing a row
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete
        {
            self.toDoList.remove(at: indexPath.row)
            self.hasCompleted.remove(at: indexPath.row)
            UserDefaults.standard.set(toDoList, forKey: "toDoList")
            UserDefaults.standard.set(hasCompleted, forKey: "hasCompleted")
            self.tableView.reloadData()
            
        }
    }
     */
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]?
    {
        let editButton = UITableViewRowAction(style: .normal, title: "Edit") { (rowAction, indexPath) in
            let alert = UIAlertController(title: "Edit", message: "Edit current task", preferredStyle: .alert)
            
            let editButton = UIAlertAction(title: "Edit", style: .default)
            {
                [unowned self] action in
                
                guard let textField = alert.textFields?.first,
                    let nameToSave = textField.text else {
                        return
                }
                
                self.editTask(name: nameToSave, index: indexPath.row)
                self.tableView.reloadData()
            }
            
            let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            
            alert.addTextField()
            alert.addAction(editButton)
            alert.addAction(cancelButton)
            self.present(alert, animated: true, completion: nil)
        }
        editButton.backgroundColor = UIColor.orange
        
        let cancelButton = UITableViewRowAction(style: .normal, title: "Cancel") { (rowAction, indexPath) in
            //print("cancel clicked")
        }
        cancelButton.backgroundColor = UIColor.darkGray
        
        let deleteButton = UITableViewRowAction(style: .normal, title: "Delete") { (rowAction, indexPath) in
            self.toDoList.remove(at: indexPath.row)
            UserDefaults.standard.set(self.toDoList, forKey: "toDoList")
            tableView.reloadData()
        }
        
        deleteButton.backgroundColor = UIColor.red
        
        return[editButton, cancelButton, deleteButton]
    }
    
    func editTask(name: String, index: Int)
    {
        toDoList[index] = name
        UserDefaults.standard.set(toDoList, forKey: "toDoList")
    }

    /*
    //change height of cells
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(200.0)
    }
     */
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(toDoList[indexPath.row])
        
        if tableView.cellForRow(at: indexPath)?.accessoryType == UITableViewCell.AccessoryType.none {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
        }
        
        selected = toDoList[indexPath.row]
        performSegue(withIdentifier: "toDoTransition", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDoTransition"
        {
            if let destination = segue.destination as? DisplayToDoViewController {
                destination.toDo = selected
            }
        }
        
    }
    
    @IBAction func NewTaskButtonPressed(_ sender: Any) {
        let alert = UIAlertController(title: "new task", message: "add a new task", preferredStyle: .alert)
        
        let addButton = UIAlertAction(title: "Add", style: .default)
        {
            [unowned self] action in
            
            guard let textField = alert.textFields?.first,
                let nameToSave = textField.text else {
                    return
            }
            
            self.addTask(name: nameToSave)
            self.tableView.reloadData()
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addTextField()
        alert.addAction(addButton)
        alert.addAction(cancelButton)
        self.present(alert, animated: true, completion: nil)
    
    }
 
    func addTask(name: String)
    {
        toDoList.append(name)
        UserDefaults.standard.set(toDoList, forKey: "toDoList")
    }
}

/*
 if cell.Switch.isOn {
 /*var range = NSRange.init(location: 0, length: toDoList[indexPath.row].count)
 cell.textLabel?.attributedText?.attribute(.strikethroughStyle, at: 0, effectiveRange: &range)*/
 tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.checkmark
 } else {
 tableView.cellForRow(at: indexPath)?.accessoryType = UITableViewCell.AccessoryType.none
 }
 */
