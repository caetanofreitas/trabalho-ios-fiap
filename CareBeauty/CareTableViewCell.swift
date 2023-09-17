//
//  CareTableViewCell.swift
//  CareBeauty
//
//  Created by Caetano Freitas on 17/09/23.
//

import UIKit

class CareTableViewCell: UITableViewCell {

    @IBOutlet weak var LblTime: UILabel!
    @IBOutlet weak var LblDescription: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
