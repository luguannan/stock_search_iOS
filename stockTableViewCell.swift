//
//  stockTableViewCell.swift
//  stockMarketSearch
//
//  Created by Guannan Lu on 11/29/17.
//  Copyright © 2017 Guannan Lu. All rights reserved.
//

import UIKit

class stockTableViewCell: UITableViewCell {

    @IBOutlet weak var stockSymbol: UILabel!
    @IBOutlet weak var stockValue: UILabel!
    @IBOutlet weak var UpDown: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
