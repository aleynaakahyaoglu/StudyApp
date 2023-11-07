//
//  KullaniciHizmetleriViewController.swift
//  Egitim
//
//  Created by Aleyna on 15.03.2022.
//

import UIKit
import Firebase
import FirebaseDatabase


class KullaniciHizmetleriViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var userTableview: UITableView!
    @IBOutlet weak var menuButton: UIBarButtonItem!

    var ModelAssign : [ModelAssign]?
    var Kullanici : [Kullanici]?
    var dataBaseRef = Database.database().reference()

     override func viewDidLoad() {
         super.viewDidLoad()
     
        
         
         self.userTableview.register(UINib(nibName: assignCell.aHücreAdi, bundle: nil), forCellReuseIdentifier: assignCell.aHücreNibAdi)
         self.userTableview.dataSource = self
         self.userTableview.delegate = self
           
         load()
      
         
     
         menuButton.target = self.revealViewController()
         menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
         self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
         self.revealViewController().rearViewRevealWidth = 280
        
     }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if ModelAssign?.count != nil {
            print("girdi")
            return ModelAssign!.count
        }
        else{
            print("çıktı")
            return 0
        }
}


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("tablo oluşturuldu.")
    //
        let assignCell = userTableview.dequeueReusableCell(withIdentifier: assignCell.aHücreNibAdi , for: indexPath) as! AssignCell
        //Cell.editButton.tag = indexPath.row
        
         //assignCell.AssignDelegate = self
        assignCell.emailLabel.text =  ModelAssign?[indexPath.row].email
        assignCell.communLabel.text =  ModelAssign![indexPath.row].sirket
        assignCell.assignLabel.text = ModelAssign![indexPath.row].hizmet
        
    if ModelAssign?.count != nil {
        //AssignCell.emailLabel.text = ModelKullanici?[indexPath.row].email
        print("default") }
        return assignCell
         
}
     
    func load(){
        print("load içinde")
        
        Database.database().reference().child("Kullanici").observe(.value) {
            (snapshot) in
            
            print("olduuu")
            
            var k: ModelAssign
        if self.ModelAssign == nil{
            self.ModelAssign = []
        }else{
            self.ModelAssign?.removeAll()
        }
     
        for ks in snapshot.children{
            let deger = (ks as! DataSnapshot).value as? NSDictionary
            print(deger)
            k = Egitim.ModelAssign()
            k.sirket = deger! ["sirket"] as? String
            k.email = deger! ["email"] as? String
            k.hizmet = deger! ["hizmet"] as? String
        
             
            if k.hizmet != "" {
                self.ModelAssign?.append(k)
            }
    
            print("self.ModelAssign")
     
      
        }
            self.userTableview.reloadData()

    }
 
    }


}
