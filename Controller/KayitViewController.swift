//
//  KayitViewController.swift
//  Egitim
//
//  Created by Aleyna on 16.03.2022.
//

import UIKit
import Firebase
import IQKeyboardManagerSwift


class KayitViewController: UIViewController {

    @IBOutlet weak var adTextfield: UITextField!
    @IBOutlet weak var soyadTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var telefonTextfield: UITextField!
    @IBOutlet weak var sirketTxtfield: UITextField!
    @IBOutlet weak var sifreTextfield: UITextField!
    @IBOutlet weak var kayitButon: UIButton!
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kayitButon.layer.cornerRadius = kayitButon.frame.size.height / 5
    }
    
    @IBAction func KayitIslemi(_ sender: UIStoryboardSegue) {
        
        if let email=emailTextfield.text, let sifre = sifreTextfield.text{
         Auth.auth().createUser(withEmail: email, password: sifre ) { authResault, error in
                 if let e = error {
                 print(e)
                 }else{
                     self.HizmetKaydet ()
                     self.callAlert ()
                 }
             }
         }
      }
    func callAlert () {
        let alert = UIAlertController(title: "MESAJ", message: "KAYDEDİLDİ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "TAMAM", style: .default, handler: { action in
            switch action.style{
            case .default:
                self.performSegue(withIdentifier:sabitler.logoutUnwind, sender: self)
                
                case .cancel:
                print("cancel")
                
                case .destructive:
                print("destructive")
                
            }
        }))
        self.present(alert, animated: true, completion: nil)
       
    }
    
    func HizmetKaydet ()
    {
        let k = Kullanici()
        k.ad = adTextfield.text
        k.soyad = soyadTextfield.text
        k.sirket = sirketTxtfield.text
        k.telefon = telefonTextfield.text
        k.email = emailTextfield.text
        k.kullaniciTuru = ""
        k.hizmet = ""
        k.id = ""

        let d = [
            "ad": k.ad,
            "soyad" : k.soyad,
            "sirket" : k.sirket,
            "telefon" : k.telefon,
            "email" : k.email,
            "kullaniciTuru" : k.kullaniciTuru,
            "hizmet" : k.hizmet ,
            "id" : Auth.auth().currentUser!.uid
        ]
        
        var ref = Database.database().reference()
        ref.child("Kullanici").child( Auth.auth().currentUser!.uid).setValue(d)
    }
    @IBAction func geriButonu(_ sender: Any) {
        self.performSegue(withIdentifier:sabitler.logoutUnwind, sender: self)
       
    }

}
