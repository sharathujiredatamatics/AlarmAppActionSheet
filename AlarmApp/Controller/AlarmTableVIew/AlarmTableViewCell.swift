//
//  AlarmTableViewCell.swift
//  AlarmApp
//
//  Created by Sharath on 19/03/21.
//  Copyright © 2021 Datamatics. All rights reserved.
//

import UIKit

class AlarmTableViewCell: UITableViewCell {
    @IBOutlet weak var alarmTime: UILabel!
    @IBOutlet weak var alarmType: UILabel!
    @IBOutlet weak var alarmState: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
