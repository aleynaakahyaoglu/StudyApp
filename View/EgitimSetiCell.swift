//
//  EgitimSetiCell.swift
//  Egitim
//
//  Created by Aleyna on 25.04.2022.
//

import UIKit
import Firebase
import FirebaseDatabase

class EgitimSetiCell: UITableViewCell {

    @IBOutlet weak var hlabel: UILabel!
    @IBOutlet weak var fileButton: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        let dataBaseRef = Database.database().reference()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
