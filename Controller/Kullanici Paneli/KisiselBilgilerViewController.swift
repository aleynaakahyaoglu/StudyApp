//
//  KisiselBilgilerViewController.swift
//  Egitim
//
//  Created by Aleyna on 17.03.2022.
//

import UIKit
import Firebase
import FirebaseDatabase

class KisiselBilgilerViewController: UIViewController{

 
    @IBOutlet weak var arrowButtonO: UIBarButtonItem!
    @IBOutlet weak var adTextfield: UITextField!
    @IBOutlet weak var soyadTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var telefonTextfield: UITextField!
    @IBOutlet weak var sirketTextfield: UITextField!
    @IBOutlet weak var degisiklikButon: UIButton!
    @IBOutlet weak var egitimlerimButton: UIBarButtonItem!
    
    
    var Kullanici : [Kullanici]?
    let dataBaseRef = Database.database().reference()
    let uid = Auth.auth().currentUser?.uid
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        degisiklikButon.layer.cornerRadius = degisiklikButon.frame.size.height/5
        
    
        load()
        
    }
    

    @IBAction func editButon(_ sender: UIButton) {
        
        switch sender.tag{
        case 0 :
            adTextfield.isUserInteractionEnabled = true
        case 1 :
            soyadTextfield.isUserInteractionEnabled = true
        case 2:
            emailTextfield.isUserInteractionEnabled = true
        case 3:
        
            telefonTextfield.isUserInteractionEnabled = true
        case 4:
            sirketTextfield.isUserInteractionEnabled = true
        default : print ("textfield enabled test")
        
        }

       
    
 
    }
    @IBAction func egitimlerimButton(_ sender: UIBarButtonItem) {
        self.performSegue(withIdentifier:sabitler.unwindEgitim, sender: self)
    }
    
    
    @IBAction func kaydetButon(_ sender: UIButton) {
        
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
            print ("hkjlk")

        }
        
    }
        
        let k = Egitim.Kullanici()
        k.ad = adTextfield.text
        k.soyad = soyadTextfield.text
        k.sirket = sirketTextfield.text
        k.telefon = telefonTextfield.text
        k.email = emailTextfield.text
        k.id = ""
        k.hizmet = ""

        
        let list = [
            "ad": k.ad,
            "soyad" : k.soyad,
            "sirket" : k.sirket,
            "telefon" : k.telefon,
            "email" : k.email,
            "id" : k.id,
            "hizmet" : k.hizmet,
        ]
        
      
        
        let dataBaseRef = Database.database().reference()
        dataBaseRef.child("Kullanici").child(uid!).setValue(list)
     
    callAlert()
    performSegue(withIdentifier: "bilgilerimToEgitim", sender: self)
      
        
    }
    
    func callAlert () {
        let alert = UIAlertController(title: "MESAJ", message: "KAYDEDİLDİ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "TAMAM", style: .default, handler: { action in
           
        }))
        self.present(alert, animated: true, completion: nil)
       
    }
    
        func load(){
            
            
            Database.database().reference().child("Kullanici").child(self.uid!).observeSingleEvent(of: .value, with: { snapshot in

               
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

            )}
    @IBAction func arrowButtonO(_ sender: UIButton) {
        performSegue(withIdentifier: "arrowUnwind", sender: self)
    }
}
     
            

            
        
        

