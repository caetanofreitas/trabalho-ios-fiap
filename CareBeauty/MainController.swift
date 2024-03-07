//
//  MainController.swift
//  CareBeauty
//
//  Created by Caetano Freitas on 17/09/23.
//

import UIKit

class MainController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ListView") as? CareTableViewController else {
            return
        }
        self.present(vc, animated: true)
    }

}
