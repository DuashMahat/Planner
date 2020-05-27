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
//    let defaults = UserDefaults.standard
    let filepath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("plans.plist")
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        print(filepath)
         /* USER DEFAULTS SET THIS ARRAY TO THE ARRAY IN OUR PLANNER
            you can also have
               defaults.float
          defaults.string etc 
           
         */
       
//       if let arrays  = defaults.array(forKey: "PlanningLists") as? [Item] {
//         array = arrays
//      }
        
       loadItems()
    }


    @IBAction func addNewPlan(_ sender: UIBarButtonItem) {
        // for you to create an alert :
        // u need an alert
        // then an action
        var texfield = UITextField()
        let alert = UIAlertController(title: "Add New Plan", message: "Add Duale", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Plan", style: .default) { (action) in
            // What happen when the user clicks an alert
            let newItem = Item()
            newItem.title = texfield.text!
            self.array.append(newItem)
             /* USER DEFAULTS SAVING THINGS IN USER DEFAULTS */
//            self.defaults.set(self.array, forKey: "PlanningLists")
//            let encoder = PropertyListEncoder()
//            do {
//                let data =  try encoder.encode(self.array)
//                try data.write(to: self.filepath!)
//            } catch {
//                print ("Error")
//            }
           
            self.saveData()
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
        saveData()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


extension PlannerViewController {
    func saveData() {
        let encoder = PropertyListEncoder()
                   do {
                       let data =  try encoder.encode(array)
                       try data.write(to: filepath!)
                   } catch {
                       print ("Error")
        }
        DispatchQueue.main.async {
                        self.tableView.reloadData()
        }
    }
    
    func loadItems() {
        if let data = try? Data(contentsOf: filepath!) {
            let decoder = PropertyListDecoder()
            do {
              array = try decoder.decode([Item].self, from: data)
            } catch {
                print("Error ")
            }
           
        }
    }
    
}

