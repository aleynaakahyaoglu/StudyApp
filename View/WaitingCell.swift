//
//  WaitingCell.swift
//  Egitim
//
//  Created by Aleyna on 21.04.2022.
//

import UIKit
import Firebase
import FirebaseDatabase

class WaitingCell: UITableViewCell {
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var sirketLabel: UILabel!
    
    let dataBaseRef = Database.database().reference()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
