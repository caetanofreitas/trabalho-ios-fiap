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
    var managedObjectContext: NSManagedObjectContext!

    override func viewDidLoad() {
        super.viewDidLoad()
        loadCares()
    }
    
    @IBAction func handleLogout() {
        self.dismiss(animated: true)
    }
    
    private func loadCares() {
        let fetchRequest: NSFetchRequest<Care> = Care.fetchRequest()
        
        let sortDescriptor = NSSortDescriptor(key: "care_time", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        fetchedList = NSFetchedResultsController(fetchRequest: fetchRequest,
        managedObjectContext: context,
        sectionNameKeyPath: nil, cacheName: nil)
        managedObjectContext = context
        
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
        cell.delegate = self
        cell.indexPath = indexPath
        return cell
    }
}

extension CareTableViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.reloadData()
    }
}

extension CareTableViewController: CareTableViewCellDelegate {
    func deleteItem(at indexPath: IndexPath) {
        do {
            let object = fetchedList.object(at: indexPath)
            managedObjectContext.delete(object)
            try managedObjectContext.save()
            removeAlert(id: object.description)
        } catch {
            print("Erro ao excluir objeto: \(error)")
        }
    }
}

private func removeAlert(id: String) {
    UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
}
