//
//  KullanicilarViewController.swift
//  Egitim
//
//  Created by Aleyna on 15.03.2022.
//

import UIKit
import Firebase
import FirebaseDatabase


protocol EditButtonDelegate: AnyObject{
    func editPress (_ tag : Int)

}
class KullanicilarViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource, EditButtonDelegate {
    
    func editPress(_ tag: Int) {
        id = (ModelKullanici![tag].id!)
        print(ModelKullanici![tag].id)
        performSegue(withIdentifier: sabitler.kullaniciToUpdate, sender: self)

       print("edit press in")
    }

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var kTableView: UITableView!
    
    var ModelKullanici : [ModelKullanici]?
    var Kullanici : [Kullanici]?

    let dataBaseRef = Database.database().reference()
    let uid = Auth.auth().currentUser?.uid
    var id: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.kTableView.delegate = self
        self.kTableView.dataSource = self
        self.kTableView.register(UINib(nibName: kullaniciCell.kHücreAdi, bundle: nil), forCellReuseIdentifier:kullaniciCell.kHücreNibAdi)
    
        
                 menuButton.target = self.revealViewController()
                 menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
                 self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
                 self.revealViewController().rearViewRevealWidth = 280
     
        self.load()

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ModelKullanici?.count != nil {
            print("girdi")
            return ModelKullanici!.count
        }
        else{
            print("efeef")
            return 0
        }
}


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //
        let kullaniciCell = kTableView.dequeueReusableCell(withIdentifier: kullaniciCell.kHücreNibAdi , for: indexPath) as! KullaniciCell
        kullaniciCell.editButton.tag = indexPath.row
        
        kullaniciCell.editButtonDelegate = self

        print("in")
        
    if ModelKullanici?.count != nil {
        kullaniciCell.llabel.text = ModelKullanici![indexPath.row].ad

    }
    return kullaniciCell
    
}

    
    func load(){
        
        Database.database().reference().child("Kullanici").observe(.value) {
            (snapshot) in
            
            var k: ModelKullanici
        if self.ModelKullanici == nil{
            self.ModelKullanici = []
        }else{
            self.ModelKullanici?.removeAll()
        }
     
        for ks in snapshot.children{
            let deger = (ks as! DataSnapshot).value as? NSDictionary
            print(deger)
            k = Egitim.ModelKullanici()
            k.ad = deger!["ad"] as? String
            k.soyad = deger! ["soyad"] as? String
            k.sirket = deger! ["sirket"] as? String
            k.telefon = deger! ["telefon"] as? String
            k.email = deger! ["email"] as? String
            k.kullaniciTuru = deger! ["kullaniciTuru"] as? String
            k.hizmet = deger!["hizmet"] as? String
            k.id = deger! ["id"] as? String
        
            
            
            if k.kullaniciTuru == "Kullanıcı"{
            self.ModelKullanici?.append(k)
            }
            print(self.ModelKullanici)
            self.kTableView.reloadData()
            
            
        }

    }
 
    }

    @IBAction func EkleIslemi( _ seg: UIStoryboardSegue) {
        
    }
    @IBAction func unwindxSegue( _ seg: UIStoryboardSegue) {
        
    }
    @IBAction func userUnwind( _ seg: UIStoryboardSegue) {
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is UpdateViewController {
            let destination = segue.destination  as? UpdateViewController
            destination?.id = id
            print(id)
  
            
        }
    
    }
    
}






