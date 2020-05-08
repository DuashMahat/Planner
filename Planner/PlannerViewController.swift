//
//  ViewController.swift
//  Planner
//
//  Created by Duale on 5/7/20.
//  Copyright © 2020 Duale. All rights reserved.
//

import UIKit

class PlannerViewController: UITableViewController {
    let array = ["Duale" , "Mahat" , "Abdullahi" , "Adan" , "Bahdon" , "Mussa" , "Abikar" , "Adan" , "Bahdon"]
    override func viewDidLoad() {
        super.viewDidLoad()
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

