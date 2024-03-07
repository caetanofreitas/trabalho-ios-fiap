//
//  UIViewController+CoreData.swift
//  CareBeauty
//
//  Created by Caetano Freitas on 17/09/23.
//

import Foundation
import UIKit
import CoreData

extension UIViewController {
    var context: NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
