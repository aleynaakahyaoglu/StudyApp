//
//  EgitimSetiViewController.swift
//  Egitim
//
//  Created by Aleyna on 15.03.2022.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth



protocol FolderDelegate: AnyObject {
    func goFolder(_ tag : Int)
}
class EgitimSetiViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, FolderDelegate{
    
    
    
    
    func goFolder(_ tag: Int) {
        print("gofolder", tag)
        self.performSegue(withIdentifier: sabitler.setToShowPage, sender: self)
    }
    
 

    @IBOutlet weak var trainingSetTableView: UITableView!
    @IBOutlet weak var trainingAddButton: UIBarButtonItem!
    @IBOutlet weak var menuButton: UIBarButtonItem!
    
    

    var HizmetListesi : [Hizmetler]?
    let dataBaseRef = Database.database().reference()
    let uid = Auth.auth().currentUser?.uid
    var id: String = ""
    
   override func viewDidLoad() {
        super.viewDidLoad()
       
       
       menuButton.target = self.revealViewController()
       menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
       self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
       self.revealViewController().rearViewRevealWidth = 280
       
       self.trainingSetTableView.register(UINib(nibName:cell.hücreAdi , bundle: nil), forCellReuseIdentifier: cell.hücreNibAdi)
       self.trainingSetTableView.dataSource = self
       self.trainingSetTableView.delegate = self
       
       
       self.load()
       
   
}
    func load(){
    
    Database.database().reference().child("Hizmetler").observe(.value) {
        (snapshot) in
        
        var h: Hizmetler
    if self.HizmetListesi == nil{
        self.HizmetListesi = []
    }else{
        self.HizmetListesi?.removeAll()
    }
 
    for ks in snapshot.children{
        let deger = (ks as! DataSnapshot).value as? NSDictionary
        print(deger)
        h = Hizmetler()
        h.name = deger!["name"] as? String
        h.id = deger! ["id"] as? Int
        
        self.HizmetListesi?.append(h)
        
        print(self.HizmetListesi)
        self.trainingSetTableView.reloadData()
       
    }

}

}

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print ("if e girecek")
        if HizmetListesi?.count != nil {
            print("girdi")
            return HizmetListesi!.count
        }
        else{
           
            print("efeef")
            return 0
        }
}
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = trainingSetTableView.dequeueReusableCell(withIdentifier: cell.hücreNibAdi , for: indexPath) as! HizmetlerCell
        
        cell.folderDelegate = self

        cell.editIcon.tag = indexPath.row
        cell.deleteIcon.tag = indexPath.row
        
        cell.deleteIcon.setImage(UIImage(systemName: "folder.fill"), for:.normal)
        cell.editIcon.isHidden = true

        if HizmetListesi?.count != nil {
            cell.label.text = HizmetListesi![indexPath.row].name

        }
        return cell
        
    }
    
    
    
    @IBAction func trainigAddButton(_ sender: Any) {
        
        self.performSegue(withIdentifier: sabitler.lessonsToTrainig, sender: self)
    }
    @IBAction func trainingUnwind( _ seg: UIStoryboardSegue) {
        
    }
    @IBAction func showUnwind( _ seg: UIStoryboardSegue) {
        
    }
    
    @IBAction func folderUnwind ( _ se : UIStoryboardSegue){
        
    }
    
    
    
    
    //return cell
    
}

    

    





