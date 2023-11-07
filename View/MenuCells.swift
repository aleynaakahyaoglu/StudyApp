//
//  MenuCells.swift
//  Egitim
//
//  Created by Aleyna on 21.03.2022.
//

import UIKit

class MenuCells: UITableViewCell {
    
    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    @IBOutlet weak var cellView: UIView!
    
   /* var optionName: MenuCells
    var optionImage: UIImage
*/
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        cellView.layer.cornerRadius = cellView.frame.size.height / 5
        cellLabel.layer.cornerRadius = cellLabel.frame.size.height / 5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
