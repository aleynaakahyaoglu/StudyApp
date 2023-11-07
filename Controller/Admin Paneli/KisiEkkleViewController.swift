//
//  KisiEkkleViewController.swift
//  Egitim
//
//  Created by Aleyna on 17.03.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase
import IQKeyboardManagerSwift



class KisiEkkleViewController: UIViewController {
    @IBOutlet weak var secimYapButton: UIButton!
    @IBOutlet var colorButtons: [UIButton]!
    @IBOutlet weak var backButon: UIBarButtonItem!
    var secim: String = ""
    
 
  
    @IBOutlet weak var adTextfield: UITextField!
    @IBOutlet weak var soyadTextfield: UITextField!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var telefonTextfield: UITextField!
    @IBOutlet weak var sirketTextfield: UITextField!
    @IBOutlet weak var sifreTextfield: UITextField!
    @IBOutlet weak var ekleButon: UIButton!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adTextfield.layer.cornerRadius = adTextfield.frame.size.height / 5
        soyadTextfield.layer.cornerRadius = soyadTextfield.frame.size.height / 5
        emailTextfield.layer.cornerRadius = emailTextfield.frame.size.height / 5
        telefonTextfield.layer.cornerRadius = telefonTextfield.frame.size.height / 5
        sirketTextfield.layer.cornerRadius = sirketTextfield.frame.size.height / 5
        sifreTextfield.layer.cornerRadius = sifreTextfield.frame.size.height / 5
        ekleButon.layer.cornerRadius = ekleButon.frame.size.height / 5
    }
    
    @IBAction func sad(_ sender: Any) {
    }
    @IBAction func EkleIslemi(_ sender: UIStoryboardSegue) {
       
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
        let alert = UIAlertController(title: "MESAJ", message: "KULLANICI EKLENDİ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "TAMAM", style: .default, handler: { action in
            switch action.style{
            case .default:
                self.performSegue(withIdentifier:sabitler.unwindxSegue, sender: self)
                
                case .cancel:
                print("cancel")
                
                case .destructive:
                print("destructive")
                
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
    

    func showButtonVisibility () {
        colorButtons.forEach{ button in
            UIButton.animate(withDuration: 0.2){
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            }
        }
    }

    @IBAction func secimAction(_ sender: UIButton) {
        showButtonVisibility()
        print ("secim yap bas.")
    }
    @IBAction func colorButtonsAction(_ sender: UIButton) {
        showButtonVisibility()
        self.secim = sender.currentTitle!
        print(self.secim)
        secimYapButton.setTitle(secim, for: .normal)
        
    }
    @IBAction func backButton(_ sender: Any) {
        self.performSegue(withIdentifier:sabitler.unwindxSegue, sender: self)
     
    }
    
    func HizmetKaydet ()
    {
        let k = Kullanici()
        k.ad = adTextfield.text
        k.soyad = soyadTextfield.text
        k.sirket = sirketTextfield.text
        k.telefon = telefonTextfield.text
        k.email = emailTextfield.text
        k.hizmet = ""
        k.kullaniciTuru = secim
        
        let d = [
            "ad": k.ad,
            "soyad" : k.soyad,
            "sirket" : k.sirket,
            "telefon" : k.telefon,
            "hizmet" : k.hizmet,
            "email" : k.email,
            "kullaniciTuru" : k.kullaniciTuru,
            "id" : Auth.auth().currentUser!.uid
        ]
        
        
        var ref = Database.database().reference()
        ref.child("Kullanici").child(Auth.auth().currentUser!.uid).setValue(d)


        
    }
    
}
    

