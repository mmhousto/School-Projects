//
//  TableViewController.swift
//  demo15
//
//  Created by MYLAVARAPU SESHA S on 10/15/19.
//  Copyright © 2019 MYLAVARAPU SESHA S. All rights reserved.
//

import UIKit
import CoreData

class TableViewController: UITableViewController, NSFetchedResultsControllerDelegate {
//    var dataSource: [Course] = []
    var fetchedRC: NSFetchedResultsController<Course>!
    
    var appDelegate: AppDelegate?
    var context: NSManagedObjectContext?
    var fetchRequest: NSFetchRequest<Course>!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        appDelegate = UIApplication.shared.delegate as? AppDelegate
        context = appDelegate?.persistentContainer.viewContext
        fetchRequest = Course.fetchRequest()
        
        //sorts the table view cells
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(keyPath: \Course.deptAbbr, ascending: true),
            NSSortDescriptor(keyPath: \Course.courseNum, ascending: true)
        ]
        fetchedRC = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context!, sectionNameKeyPath: nil, cacheName: nil)
        fetchedRC.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Fetch the database contents.
        
//        fetchRequest.sortDescriptors = [
//            NSSortDescriptor(keyPath: \Course.deptAbbr, ascending: true)
//        ]
//
//       fetchRequest.predicate = NSPredicate(format: "deptAbbr AND courseNum")
//
//        do {
//            var records: [Course] = try context!.fetch(fetchRequest)
//
//            if !records.isEmpty {
////                records[0].title = "Mobile Computing"
//                context!.delete(records[0])
//                try context!.save()
//            }
//        }
//
//        catch let error as NSError {
//            print("Fetch of specified record failed: \(error)")
//        }
        fetchRequest.predicate = nil
        
        do {
//            dataSource = try context?.fetch(fetchRequest) ?? []
            try fetchedRC.performFetch()
        }
        catch let error as NSError {
            //alerts error
            let alertController = UIAlertController(title: "Duplicate", message: "Course entered is duplicate, will not be added to table view!", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            self.present(alertController, animated: true, completion: nil)
            print("Cannot load data: \(error)")
        }
        
        fetchRequest.predicate = nil
    }
    
    @IBAction func unwindFromSave(segue: UIStoryboardSegue) {
        // Get the segue source.
        guard let source = segue.source as? ViewController else {
            print("Cannot get segue source.")
            return
        }
        // Create a new course record.
        let course = Course(context: context!)
        // Set the attributes in the new course record.
        course.deptAbbr = source.deptAbbrResult
        course.courseNum = source.courseNumResult
        course.title = source.courseTitleResult
        
        //array that holds all the results
        var resultsArr: [Course] = []
        do {

            // Update the data store with the managed context.
            try context!.save()
            resultsArr = try (context!.fetch(fetchRequest))
        }
        catch let error as NSError {
            //alerts error if duplicate
            let alertController = UIAlertController(title: "Duplicate", message: "Course entered is duplicate, will not be added to table view!", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
            self.present(alertController, animated: true, completion: nil)
            //alert user duplicate
            print("cannot save data: \(error)")
        }
        
        //if more than 1 object in array
        if resultsArr.count > 0 {
            for x in resultsArr {
                //goes through array and checks for duplicates
                if ((x.deptAbbr == source.deptAbbrResult)&&(x.courseNum == source.courseNumResult)) {
                    //deletes context duplicate and sends alert
                    context?.delete(x)
//                    let alertController = UIAlertController(title: "Duplicate", message: "Course entered is duplicate, will not be added to table view!", preferredStyle: .alert)
//                    alertController.addAction(UIAlertAction(title: "Dismiss", style: .default))
//                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch(type) {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break;
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break;
        case .update:
            break;
        case .move:
            break;
        @unknown default:
            fatalError()
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return fetchedRC.fetchedObjects?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "My Cell", for: indexPath)

        // Configure the cell...
        // Display the cell label and subtitle.
        cell.textLabel?.text = fetchedRC.object(at: indexPath).deptAbbr! + String(fetchedRC.object(at: indexPath).courseNum)
        cell.detailTextLabel?.text = fetchedRC.object(at: indexPath).title
        
        return cell
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
