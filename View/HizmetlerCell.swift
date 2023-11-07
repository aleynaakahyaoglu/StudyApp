//
//  HizmetlerCell.swift
//  Egitim
//
//  Created by Aleyna on 15.03.2022.
//
import UIKit
import FirebaseDatabase

class HizmetlerCell: UITableViewCell {
    

    @IBOutlet weak var satir: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var editIcon: UIButton!
    @IBOutlet weak var deleteIcon: UIButton!

    
 
    let dataBaseRef = Database.database().reference()
    
    var editButtonActionDelegate : EditButtonActionDelegate?
    
    var folderDelegate : FolderDelegate?


    override func awakeFromNib(){
        super.awakeFromNib()

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
  

    }
    
@IBAction func editAction(_ sender: UIButton) {
    
    
    print (sender.tag)
    if ((editButtonActionDelegate) != nil) {
        print("edittButtonDelegate e girdi")
    
        editButtonActionDelegate?.press(sender.tag)
        
    }else{
        print ("folderdelegate e girdi.")
        folderDelegate?.goFolder(sender.tag)
        
    }
}
    @IBAction func deleteAction(_ sender: UIButton) {
        
        if deleteIcon.currentTitle == "folder.fill" {
            folderDelegate?.goFolder(sender.tag)
           
        }else{
            editButtonActionDelegate?.deletePress(sender.tag)
        }
        
       
        
        
        /*do {
            
            ""
        }catch let error as NSError {
            print (error.localizedDescription)
        }
    }*/
    
    }

    
   
    
}
    
