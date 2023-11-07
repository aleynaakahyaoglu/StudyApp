//
//  GirisViewController.swift
//  Egitim
//
//  Created by Aleyna on 14.03.2022.
//

import UIKit
import Firebase

class GirisViewController: UIViewController {
    
    @IBOutlet weak var userIcon: UIButton!
    @IBOutlet weak var kayitButonu: UIButton!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var sifreTextfield: UITextField!
    @IBOutlet weak var girisButon: UIButton!
    
  
    @IBAction func UserChangeClick(_ sender: Any) {
        /*label.text = "Admin Girişi"
        userIcon.setImage(UIImage(systemName: "person"), for:.normal)*/
        if (userIcon.currentImage == UIImage(systemName: "person.fill")){ //let label.text = "Admin Girisi"
            userIcon.setImage(UIImage(systemName: "person"), for:.normal)
            label.text = "ADMIN GİRİŞİ"
            kayitButonu.isHidden = false
            kayitButonu.isHidden = true
            
        }else{
            userIcon.setImage(UIImage(systemName: "person.fill"), for:.normal)
            label.text = "KULLANICI GİRİŞİ"
            kayitButonu.isHidden = true
            kayitButonu.isHidden = false
            
        }
        
    }
    @IBAction func girisYapButon(_ sender: UIButton) {
        
        if let email = emailTextfield.text, let sifre = sifreTextfield.text {
            Auth.auth().signIn(withEmail: email, password: sifre) { [self] authResult, error in
                if  emailTextfield.text == ""  || sifreTextfield.text == "" {
                    callAlert(title:"MESAJ", message:" Bu alan boş bırakılamaz.", anstitle: "TAMAM")
                
                    
                    /*if (emailTextfield.text != nil) {
                        callAlert(title:"MESAJ", message:" Email yanlış.", anstitle: "TAMAM")
                    }else{
                        print("yanlıs else")
                        
                    }*/
                }else{
                    print("mail bos")
                }
         
            
                if let e = error {
                    print(e)
                }else{

                    let user = Auth.auth().currentUser!
                        var id = user.uid
                    Database.database().reference().child("Kullanici").child(Auth.auth().currentUser!.uid).observeSingleEvent(of: .value, with: {
                        
                        snapshot in
                       /* if  Auth.auth().currentUser != nil {
                            callAlert(title:"MESAJ", message:" Böyle bir kullanıcı bulunamadı. Lütfen kayıt olun", anstitle: "TAMAM")
                            
                        }else{
                            print("else e girdi.")
                        }*/
                  
                        let deger = snapshot.value as? NSDictionary
                        print(deger as Any)
              
                        var kullanici = deger? ["kullaniciTuru"] as? String
                        var hizmet = deger? ["hizmet"] as? String

                        if kullanici == "Kullanıcı" {
                            if (self.userIcon.currentImage == UIImage(systemName: "person.fill")){
                            print(Auth.auth().currentUser?.uid)
                                
                                if hizmet != ""{
                                    self.performSegue(withIdentifier: sabitler.girisToEgitimlerim, sender: self)
                                }else{
                                    
                                         let alert = UIAlertController(title:" Uyarı", message:"Egitiminiz Bulunmamaktadır", preferredStyle: .alert)
                                         alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: { action in
                                     
                                         }))
                                         self.present(alert, animated: true, completion: nil)}
                              
                            
                            }else{
                                callAlert(title:"MESAJ" , message: "Lütfen profil ikonuna tıklayarak Kullanıcı Girişi üzerinden giriş sağlayın" ,anstitle: "TAMAM")
                                //alert() "Lütfen profil ikonuna tıklayarak Kullanıcı Girişi üzerinden giriş sağlayın."
                            }
                          
                        }else{
                            if (self.userIcon.currentImage == UIImage(systemName: "person")){
                            print(Auth.auth().currentUser?.uid)
                            self.performSegue(withIdentifier: sabitler.girisSegue, sender: self)
                  
                            
                            }else{
                                
                                callAlert(title:"MESAJ" , message: "Lütfen profil ikonuna tıklayarak Admin Girişi üzerinden giriş sağlayın" ,anstitle: "TAMAM")
                                //alert() "Lütfen profil ikonuna tıklayarak Admin Girişi üzerinden giriş sağlayın."
                            }
                       
                        }
                        
    
                    })
                    
                }
    }
                
            }
        
            
        }
    func callAlert (title:String , message: String ,anstitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: anstitle, style: .default, handler: { action in
       
        }))
        self.present(alert, animated: true, completion: nil)
    }
                                                                                                                              
    @IBAction func kayitOlButonu(_ sender: Any) {
        performSegue(withIdentifier: "girisToKayitOl", sender: self)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //otomatik doldurma
        emailTextfield.text = "kahyaogluu@gmail.om"
        sifreTextfield.text = "123456"
        girisButon.layer.cornerRadius = girisButon.frame.size.height / 5
        emailTextfield.layer.cornerRadius = emailTextfield.frame.size.height / 5
        sifreTextfield.layer.cornerRadius = sifreTextfield.frame.size.height / 5
    }
    
    @IBAction func unwindd( _ seg: UIStoryboardSegue) {
        
    }
    @IBAction func logoutUnwind( _ seg: UIStoryboardSegue) {
        
   }
    @IBAction func arrowUnwind( _ seg: UIStoryboardSegue) {
    }
    @IBAction func unwindke(_ seg: UIStoryboard)  {
        
    }


    
    }
