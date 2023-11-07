//
//  AssignCell.swift
//  Egitim
//
//  Created by Aleyna on 21.04.2022.
//

import UIKit
import FirebaseDatabase

class AssignCell: UITableViewCell {

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var communLabel: UILabel!
    @IBOutlet weak var assignLabel: UILabel!
    
    
    let dataBaseRef = Database.database().reference()
    //var assignDelegate :AssignDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
