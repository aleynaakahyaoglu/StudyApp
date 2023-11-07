//
//  AdminlerViewController.swift
//  Egitim
//
//  Created by Aleyna on 17.03.2022.
//
import UIKit
import Firebase
import FirebaseDatabase
import DropDown

protocol AeditButtonDelegate: AnyObject{
    func editPress (_ tag : Int)

}
class AdminlerViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource, AeditButtonDelegate {
    func editPress(_ tag: Int) {
        performSegue(withIdentifier: sabitler.adminToUpdate, sender: self)
       print("edit press in")
    }

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var aTableView: UITableView!
    
    
    var ModelAdmin : [ModelAdmin]?
    var Kullanici : [Kullanici]?

    let dataBaseRef = Database.database().reference()
    let uid = Auth.auth().currentUser?.uid
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.aTableView.register(UINib(nibName: adminCell.aHücreAdi, bundle: nil), forCellReuseIdentifier: adminCell.aHücreNibAdi )
        self.aTableView.delegate = self
        self.aTableView.dataSource = self
        
                 menuButton.target = self.revealViewController()
                 menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
                 self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
                 self.revealViewController().rearViewRevealWidth = 280
        
        
        self.load()
        
        
      
      

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ModelAdmin?.count != nil {
            return ModelAdmin!.count
        }
        else{
            return 0
        }
}


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //
    let adminnCell = aTableView.dequeueReusableCell(withIdentifier: adminCell.aHücreNibAdi , for: indexPath) as! AdminCell
        adminnCell.aeditButton.tag = indexPath.row
        adminnCell.AeditButtonDelegate = self
        
    if ModelAdmin?.count != nil {
        adminnCell.alabel.text = ModelAdmin![indexPath.row].ad

    }
    return adminnCell
    
}
    func load(){
        
        Database.database().reference().child("Kullanici").observe(.value) {
            (snapshot) in
            
            var a: ModelAdmin
        if self.ModelAdmin == nil{
            self.ModelAdmin = []
        }else{
            self.ModelAdmin?.removeAll()
        }
     
        for ks in snapshot.children{
            let deger = (ks as! DataSnapshot).value as? NSDictionary
            print(deger)
            a = Egitim.ModelAdmin()
            a.ad = deger!["ad"] as? String
            a.soyad = deger! ["soyad"] as? String
            a.sirket = deger! ["sirket"] as? String
            a.telefon = deger! ["telefon"] as? String
            a.email = deger! ["email"] as? String
            a.hizmet = deger! ["hizmet"] as? String
            a.kullaniciTuru = deger! ["kullaniciTuru"] as? String
        
            
            if a.kullaniciTuru == "Admin"{
            self.ModelAdmin?.append(a)
            }
            print(self.ModelAdmin)
            self.aTableView.reloadData()
           
        }

    }
 
    }
    @IBAction func adminUnwind( _ seg: UIStoryboardSegue) {
        
    }
    
    
}


