//
//  ViewController.swift
//  Planner
//
//  Created by Duale on 5/7/20.
//  Copyright © 2020 Duale. All rights reserved.
//

import UIKit

class PlannerViewController: UITableViewController {
    var array = ["Duale" , "Mahat" , "Abdullahi" , "Adan" , "Bahdon" , "Mussa" , "Abikar" , "Adan" , "Bahdon"]
    
    /* USER DEFAULTS */
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        
         /* USER DEFAULTS SET THIS ARRAY TO THE ARRAY IN OUR PLANNER   */
        if let arrays  = defaults.array(forKey: "PlanningLists") as? [String] {
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
            self.array.append(texfield.text!)
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
        cell.textLabel?.text = array[indexPath.row]
        return cell
    }
    
    
   
}

extension PlannerViewController  {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView.cellForRow(at: indexPath)?.accessoryType ==  .checkmark  {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        } else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

