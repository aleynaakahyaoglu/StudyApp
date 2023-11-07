//
//  Assign.swift
//  Egitim
//
//  Created by Aleyna on 20.04.2022.
//

import UIKit
import Firebase
import FirebaseDatabase

class AssignCell: UITableViewCell {

    @IBOutlet weak var mailLabel: UILabel!
    @IBOutlet weak var sirketLabel: UILabel!
    @IBOutlet weak var hizmetLabel: UILabel!
    
    
       let dataBaseRef = Database.database().reference()


       override func awakeFromNib(){
           super.awakeFromNib()

       }

       override func setSelected(_ selected: Bool, animated: Bool) {
           super.setSelected(selected, animated: animated)

       }
}
       

