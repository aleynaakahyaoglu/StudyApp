//
//  UpdateViewController.swift
//  Egitim
//
//  Created by Aleyna on 14.04.2022.
//

import UIKit
import Firebase
import FirebaseDatabase

class UpdateViewController: UIViewController {
    
    @IBOutlet weak var adTextfield: UITextField!
    @IBOutlet weak var soyadTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var telefonTextfield: UITextField!
    @IBOutlet weak var sirketTextfield: UITextField!
    @IBOutlet weak var saveButon: UIButton!
    @IBOutlet weak var trashButton: UIBarButtonItem!
    @IBOutlet weak var backbuttonO: UIBarButtonItem!
    
    
    var Kullanici : [Kullanici]?
    let dataBaseRef = Database.database().reference()
    let uid = Auth.auth().currentUser?.uid
    
    var id : String = ""
 
override func viewDidLoad() {
    super.viewDidLoad()
    print(id)
    

    saveButon.layer.cornerRadius = saveButon.frame.size.height/5
    

    UpdateViewController.load()
    
}
    func load(){
        
        
      //  Database.database().reference().child("Kullanici").child(self.uid!).observeSingleEvent(of: .value, with: { snapshot in
            
        
        Database.database().reference().child("Kullanıcı").observe(.value) {
            (snapshot) in
           
        if self.Kullanici == nil{
            self.Kullanici = []
        }else{
            self.Kullanici?.removeAll()
        }
     
            let deger = snapshot.value as? NSDictionary
            print(deger as Any)
  
            self.adTextfield.placeholder = deger? ["ad"] as? String
            self.soyadTextfield.placeholder = deger? ["soyad"] as? String
            self.sirketTextfield.placeholder = deger? ["sirket"] as? String
            self.telefonTextfield.placeholder = deger? ["telefon"] as? String
            self.emailTextfield.placeholder = deger? ["email"] as? String
      
            //self.Kullanici?.append(h)
            
            print(self.Kullanici as Any)
            print(self.uid as Any)
            //self.Kullanici?.reloadData()
           
        }

        }
    /*func load(){
        
        
        Database.database().reference().child("Kullanici").child(self.uid!).observeSingleEvent(of: .value, with: { snapshot in

            
        if self.Update == nil{
            self.Update = []
        }else{
            self.Update?.removeAll()
        }
     
            let deger = snapshot.value as? NSDictionary
            print(deger as Any)

            self.adTextfield.placeholder = deger?["ad"] as? String
            self.soyadTextfield.placeholder = deger? ["soyad"] as? String
            self.sirketTextfield.placeholder = deger? ["sirket"] as? String
            self.telefonTextfield.placeholder = deger? ["telefon"] as? String
            self.emailTextfield.placeholder = deger? ["email"] as? String
      
            //self.Kullanici?.append(b)
            
            print(self.Update as Any)
            print(self.uid as Any)
            UpdateViewController.load()
           
        }

        )
        
    }*/
 
    @IBAction func saveButon(_ sender: Any) {
    
    for i in 0...4 {
    
    switch "" {
    case adTextfield.text :
        adTextfield.text = adTextfield.placeholder
    case soyadTextfield.text :
        soyadTextfield.text = soyadTextfield.placeholder
    case sirketTextfield.text:
        sirketTextfield.text = sirketTextfield.placeholder
    case emailTextfield.text :
        emailTextfield.text = emailTextfield.placeholder
    case telefonTextfield.text :
        telefonTextfield.text = telefonTextfield.placeholder
    default :
        print ("girdi")

    }
    
        let b = Egitim.Kullanici()
    b.ad = adTextfield.placeholder
    b.soyad = soyadTextfield.placeholder
    b.email = emailTextfield.placeholder
    b.telefon = telefonTextfield.placeholder
    b.sirket = sirketTextfield.placeholder
   
   


    let list = [
        "ad": b.ad,
        "soyad" : b.soyad,
        "email" : b.email,
        "telefon" : b.telefon,
        "sirket" : b.sirket,
    ] 



        
        let dataBaseRef = Database.database().reference()
        dataBaseRef.child("Kullanici").child(uid!).setValue(list)
        
      callAlert()

    }
        func callAlert () {
            let alert = UIAlertController(title: "MESAJ", message: "KAYDEDİLDİ", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "TAMAM", style: .default, handler: { action in
                switch action.style{
                case .default :
                self.performSegue(withIdentifier: sabitler.userUnwind, sender: self)
                    
                    case .cancel:
                    print("cancel")
                    
                    case .destructive:
                    print("destructive")
                    
                }
            }))
            self.present(alert, animated: true, completion: nil)
           
        }


    }
    @IBAction func trashButtonAction(_ sender: UIBarButtonItem) {
        
        
        let Kullanici = Auth.auth().currentUser
        
        /*Kullanici?.delete() {
            error in
            if let*/
        print(id)
        Database.database().reference(withPath:"Kullanici").child(id).setValue(nil)
        print("action")

        UpdateViewController.load()
        callAlert()
   
    }
    @IBAction func backButtonO(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier: sabitler.userUnwind, sender: self)
        
    }
    func callAlert () {
        let alert = UIAlertController(title: "MESAJ", message: "BU İŞLEM GERİ ALINAMAZ.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "TAMAM", style: .default, handler: { action in
       
        }))
        self.present(alert, animated: true, completion: nil)
       
    }
 
    
}
        


    


