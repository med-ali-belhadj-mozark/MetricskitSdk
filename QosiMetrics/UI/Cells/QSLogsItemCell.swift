//
//  QSLogsItemCell.swift
//  QosiMetrics
//
//  Created by Mohamed Ali BELHADJ on 18/01/2023.
//

import UIKit

class QSLogsItemCell: UITableViewCell {

    static let identifier = "QSLogsItemCell"

    @IBOutlet var logItemLabel: UILabel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
