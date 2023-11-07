//
//  AdminCell.swift
//  Egitim
//
//  Created by Aleyna on 13.04.2022.
//
import UIKit
import FirebaseDatabase

class AdminCell: UITableViewCell {
    


    @IBOutlet weak var alabel: UILabel!
    @IBOutlet weak var aeditButton: UIButton!
    
    let dataBaseRef = Database.database().reference()
    var AeditButtonDelegate : AeditButtonDelegate?


    override func awakeFromNib(){
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
@IBAction func editButtton(_ sender: UIButton) {
       
    print (sender.tag)
   
    AeditButtonDelegate?.editPress(sender.tag)
        
    }
}
