//
//  CareTableViewController.swift
//  CareBeauty
//
//  Created by Caetano Freitas on 17/09/23.
//

import UIKit
import CoreData

class CareTableViewController: UITableViewController {
    
    var fetchedList: NSFetchedResultsController<Care>!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCares()
    }
    
    private func loadCares() {
        let fetchRequest: NSFetchRequest<Care> = Care.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "care_time", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedList = NSFetchedResultsController(fetchRequest: fetchRequest,
        managedObjectContext: context,
        sectionNameKeyPath: nil, cacheName: nil)
        
        fetchedList.delegate = self
        do {
            try fetchedList.performFetch()
        } catch {
            print(error.localizedDescription)
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedList.fetchedObjects?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CareTableViewCell
        
        let care = fetchedList.object(at: indexPath)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yy HH:mm"
        
        cell.LblTime?.text = dateFormatter.string(from: care.care_time!)
        cell.LblDescription?.text = "- \(care.care_description!)"
        return cell
    }
}

extension CareTableViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}
