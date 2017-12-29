//
//  favCellTableViewCell.swift
//  stockMarketSearch
//
//  Created by Guannan Lu on 11/30/17.
//  Copyright © 2017 Guannan Lu. All rights reserved.
//

import UIKit

class favCellTableViewCell: UITableViewCell {

    @IBOutlet weak var sym: UILabel!
    @IBOutlet weak var pri: UILabel!
    
    @IBOutlet weak var changes: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
