//
//  HizmetAtaViewController.swift
//  Egitim
//
//  Created by Aleyna on 17.03.2022.
//
import UIKit
import Firebase
import FirebaseDatabase


class HizmetAtaViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource{


    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var picker2View: UIPickerView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var assignServiceButton: UIButton!
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var hizmetlerLabel: UILabel!
    @IBOutlet weak var assignBackButton: UIBarButtonItem!
    
   
    let dataBaseRef = Database.database().reference()
    let uid = Auth.auth().currentUser?.uid
    var id: String = ""
    var Kullanici : [String] = []
    var KullaniciID : [String] = []
    var Hizmetler : [String] = []
    
    var Kullanıcı: String?
    var Hizmet: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.delegate = self
        pickerView.dataSource = self
        picker2View.delegate = self
        picker2View.dataSource = self
        
        load()
        loadHizmetler()
        
        pickerView.layer.cornerRadius = pickerView.frame.size.height / 5
        
        picker2View.layer.cornerRadius = picker2View.frame.size.height / 5
        
        assignServiceButton.layer.cornerRadius = assignServiceButton.frame.size.height / 5
     
    }
    func numberOfComponents(in picker: UIPickerView) -> Int {
        return 1
    }
   
    func pickerView(_ picker: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if picker == picker2View {
            print("if")
            return (Kullanici.count)
       
            
        }else{
            print("else")
            return Hizmetler.count
            
        }
       
    }
   func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       print("pview oluşturuldu")
       if pickerView == picker2View {
         
           return (Kullanici[row])
        
       }else{
           return (Hizmetler[row])
           
       }
       
   }
   func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
       if pickerView == picker2View {
         
        Kullanıcı = (KullaniciID[row])
        
       }else{
        Hizmet = (Hizmetler[row])
           
       }
       
       print(" kullanıcılar girdi")
   }
    
    
    @IBAction func assignServiceButtonAction(_ sender: Any) {
        
         
        
        HizmetAta()
        callAlert()
        
    
    }
    func HizmetAta(){
        var ref = Database.database().reference()
        guard let hizmet = Hizmet else {
            return
        }

        ref.child("Kullanici").child(Kullanıcı!).child("hizmet").setValue(hizmet)
    }
    
    func callAlert () {
        let alert = UIAlertController(title: "MESAJ", message: "İŞLEM GERÇEKLEŞTİRİLDİ.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "TAMAM", style: .default, handler: { action in
         
            self.performSegue(withIdentifier: sabitler.waitUnwind, sender: self)
       
        }))
        self.present(alert, animated: true, completion: nil)
       
    }
    
    func load(){
        
        Database.database().reference().child("Kullanici").observe(.value) {
            (snapshot) in
            
            var h: Kullanici
     
        for ks in snapshot.children{
            let deger = (ks as! DataSnapshot).value as? NSDictionary
            print(deger)
            h = Egitim.Kullanici()
            let email = deger!["email"] as? String
            let id = deger! ["id"] as? String
            self.KullaniciID.append(id!)
            self.Kullanici.append(email!)
            
            print("load in")
            
            print(self.Kullanici)
            
        }
        
            self.picker2View.reloadAllComponents()
            
        }
             
    }
        func loadHizmetler(){
            
            Database.database().reference().child("Hizmetler").observe(.value) {
                (snapshot) in
                
                var z: Hizmetler
         
            for ks in snapshot.children{
                let deger = (ks as! DataSnapshot).value as? NSDictionary
                print(deger)
                z = Egitim.Hizmetler()
                let name = deger!["name"] as? String
                self.Hizmetler.append(name!)
                print("name girdi")
                
            }
                self.pickerView.reloadAllComponents()
            }
                 
        }
    @IBAction func assignBackButton(_ sender: Any) {
        
        self.performSegue(withIdentifier: sabitler.assignBackUnwind, sender: self)
    }
    
  
    
    
    

}


