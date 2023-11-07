//
//  EgitimCell.swift
//  Egitim
//
//  Created by Aleyna on 29.03.2022.
//

import UIKit
import FirebaseDatabase

class EgitimCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        var dataBaseRef = Database.database().reference()
      
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

