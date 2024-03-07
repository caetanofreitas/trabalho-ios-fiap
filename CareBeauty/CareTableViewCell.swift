//
//  CareTableViewCell.swift
//  CareBeauty
//
//  Created by Caetano Freitas on 17/09/23.
//

import UIKit

protocol CareTableViewCellDelegate: AnyObject {
    func deleteItem(at indexPath: IndexPath)
}

class CareTableViewCell: UITableViewCell {

    weak var delegate: CareTableViewCellDelegate?
    
    var indexPath: IndexPath?
    
    @IBOutlet weak var LblTime: UILabel!
    @IBOutlet weak var LblDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBOutlet weak var deleteButton: UIButton!
    @IBAction func deleteCelll(_ sender: UIButton) {
        guard let indexPath = indexPath else {
            return
        }
        delegate?.deleteItem(at: indexPath)
    }
}
