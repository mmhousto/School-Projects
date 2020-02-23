//
//  TableViewController.swift
//  A3_P1_Houston_Morgan
//
//  Created by Morgan Houston on 10/1/19.
//  Copyright © 2019 Morgan Houston. All rights reserved.
//

import Foundation
import UIKit


class TableViewController: UITableViewController {
    //array of laps
    var lapStats: [String] = []
    @IBOutlet weak var lapStatsTableView: UITableView!
    
    @IBAction func myUnwindAction(segue: UIStoryboardSegue) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        //sets height for header to 35
        return 35.0
    }
    
    override func viewWillAppear(_ animated: Bool) { super.viewWillAppear(true)
        // Hide the navigation bar and toolbar.
        //        self.navigationController?.setNavigationBarHidden( true, animated: true)
        self.navigationController?.setNavigationBarHidden(false,animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let destination = segue.destination as! SecondViewController
//
//        if segue.identifier == "toStats" {
//            if let indexPath = self.lapStatsTableView.indexPathForSelectedRow {
//                destination.laps = [lapStats[indexPath.row]]
//            }
//        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0 {
            return 3
        } else {
        return lapStats.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section != 0 {
        let lapCell = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "Lap Stats")
            for i in 0...lapStats.count-1 {
        lapCell.textLabel?.text = "Lap \(i+1)"
        lapCell.detailTextLabel?.text =  lapStats[i]
            }
        
        return lapCell
        }else {
            let fastLap = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "Fastest")
//            let slowLap = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "Slowest")
//            let avgLap = UITableViewCell(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "Average")
            
            //Configure the cell...
            fastLap.textLabel?.text = "Fastest Lap"
            fastLap.detailTextLabel?.text = lapStats.min()

            return fastLap
        }
    }

}
