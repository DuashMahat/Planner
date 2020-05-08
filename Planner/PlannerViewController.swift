//
//  ViewController.swift
//  Planner
//
//  Created by Duale on 5/7/20.
//  Copyright © 2020 Duale. All rights reserved.
//

import UIKit

class PlannerViewController: UITableViewController {
    var array : [Item] = []
    
    /* USER DEFAULTS */
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
         /* USER DEFAULTS SET THIS ARRAY TO THE ARRAY IN OUR PLANNER
            you can also have
               defaults.float
          defaults.string etc 
           
         */
        let item1 = Item()
        item1.title = "Duale"
        array.append(item1)
        
        let item2 = Item()
               item2.title = "Bahdon"
               array.append(item2)
        
        let item3 = Item()
               item3.title = "Abdullahi"
               array.append(item3)
        
        let item4 = Item()
               item4.title = "Mahat"
               array.append(item4)
       if let arrays  = defaults.array(forKey: "PlanningLists") as? [Item] {
         array = arrays
      }
    }


    @IBAction func addNewPlan(_ sender: UIBarButtonItem) {
        // for you to create an alert :
        // u need an alert
        // then an action
        var texfield = UITextField()
        let alert = UIAlertController(title: "Add New Plan", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Plan", style: .default) { (action) in
            // What happen when the user clicks an alert
            let newItem = Item()
            newItem.title = texfield.text!
            self.array.append(newItem)
             /* USER DEFAULTS SAVING THINGS IN USER DEFAULTS */
            self.defaults.set(self.array, forKey: "PlanningLists")
            DispatchQueue.main.async {
                 self.tableView.reloadData()
            }
          
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Enter A Plan"
            texfield = alertTextField
        }
        alert.addAction(action)
        present(alert , animated: true , completion: nil)
        
    }
    
}

extension PlannerViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return array.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlanItemCell", for: indexPath)
        print("Cell for row at index path called ")
        let plan = array[indexPath.row]
        cell.textLabel?.text = plan.title
        cell.accessoryType = plan.done ? .checkmark : .none
        if (array[indexPath.row].done == true ) {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        return cell
    }
    
    
   
}

extension PlannerViewController  {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        array[indexPath.row].done = !array[indexPath.row].done
        DispatchQueue.main.async {
            tableView.reloadData()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

