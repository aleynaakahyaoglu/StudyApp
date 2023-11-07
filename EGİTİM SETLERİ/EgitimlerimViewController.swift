//
//  EgitimlerimViewController.swift
//  Egitim
//
//  Created by Aleyna on 17.03.2022.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth



class EgitimlerimViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

   
    @IBOutlet weak var particularButton: UIBarButtonItem!
    @IBOutlet weak var lessonsTableView: UITableView!
    @IBOutlet weak var arrowButtton: UIBarButtonItem!
    @IBOutlet weak var TelephoneButton: UIButton!
    @IBOutlet weak var NameLabel: UILabel!

    let dataBaseRef = Database.database().reference()
    let uid = Auth.auth().currentUser?.uid
    var id: String = ""
    var IID: Int?
    var HizmetListesi : [Hizmetler]?

    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.loadKullanicilar()
       
            self.load()
            
            
            self.lessonsTableView.register(UINib(nibName:cell.hücreAdi , bundle: nil), forCellReuseIdentifier: cell.hücreNibAdi)
            self.lessonsTableView.dataSource = self
            self.lessonsTableView.delegate = self
            
            
            TelephoneButton.layer.cornerRadius = TelephoneButton.frame.size.height / 5

    }

    
    @IBAction func particularButton(_ sender: Any) {
        performSegue(withIdentifier: "egitimlerimToBilgilerim", sender: nil)
    }
    
    
    @IBAction func cikisButton(_ sender: Any) {
        
        do{
        try Auth.auth().signOut()
            self.performSegue(withIdentifier:sabitler.logoutUnwind, sender: self)
    }catch{
        print("Error while signing out!")
    }

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

    }
        self.lessonsTableView.reloadData()
}

}
        func loadKullanicilar() {
            
            
            Database.database().reference().child("Kullanici").child(self.uid!).observeSingleEvent(of: .value, with: { snapshot in

                let deger = snapshot.value as? NSDictionary
                print(deger as Any)
      
                self.NameLabel.text = deger? ["hizmet"] as? String
          
            }

            )}

    
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
        let cell = lessonsTableView.dequeueReusableCell(withIdentifier: cell.hücreNibAdi , for: indexPath) as! HizmetlerCell
        
        //cell.folderDelegate = self

        cell.editIcon.tag = indexPath.row
        cell.deleteIcon.tag = indexPath.row
        
        
        cell.editIcon.isHidden = true
        cell.editIcon.setImage(UIImage(systemName: "folder.fill"), for:.normal)
        cell.deleteIcon.isHidden = true

        if HizmetListesi?.count != nil {
            cell.label.text = HizmetListesi![indexPath.row].name

        }
        return cell
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    @IBAction func TelephoneButton(_ sender: AnyObject) {
       // let url: NSURL = NSURL (string: "tel://02324355454")!
        //UIApplication.shared.openURL(url as URL)
        
        if let url = URL(string: "tel://\(+902324355454)") {
            UIApplication.shared.openURL(url)
        }
    }
    
    
    @IBAction func bilgilerimToEgitim( _ seg: UIStoryboardSegue){
    }
    @IBAction func unwindEgitim( _ seg: UIStoryboardSegue){
        
    }
        
    }


