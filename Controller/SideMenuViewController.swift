//
//  SideMenuViewController.swift
//  Egitim
//
//  Created by Aleyna on 15.03.2022.
//

import UIKit
import Firebase
import FirebaseAuth

class SideMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
       
      
    @IBOutlet weak var menuTableView: UITableView!
    @IBOutlet weak var anasayfaImage: UIImageView!
    
    var tiklaButton: String = ""

          var secenekler = ["Anasayfa","Hizmetler","Kullanıcılar","Kullanıcı Hizmetleri", "Egitim Setleri", "Çıkış"]
          
    var segues = ["menuToAnasayfa",sabitler.hizmetlerSegue ,sabitler.kullanicilarSegue, sabitler.kullaniciHizmetleriSegue,"egitimSetleri",sabitler.logOutSegue] //
      
          var ikon = ["arrow.backward.square","lasso.and.sparkles","lasso","suit.club","scribble.variable","seal.fill"]
          override func viewDidLoad() {
              super.viewDidLoad()
              print(tiklaButton , sabitler.ButtonTitle.hizmetler)

               switch tiklaButton {
       case sabitler.ButtonTitle.hizmetler:
                                  performSegue(withIdentifier:segues[1], sender: self)
                   case sabitler.ButtonTitle.kullanicilar:
                                  performSegue(withIdentifier: segues[2], sender: self)
                   case sabitler.ButtonTitle.kullaniciHizmetleri:
                                  performSegue(withIdentifier: segues[3], sender: self)
                   case sabitler.ButtonTitle.egitimSetleri:
                                  performSegue(withIdentifier: segues[4], sender: self)
                  case sabitler.ButtonTitle.cikis:
                                  performSegue(withIdentifier: segues [5], sender: self)
                   default : print("qawesdfgh")
                                  print(tiklaButton)
               }
            
              anasayfaImage.layer.cornerRadius = 40
              anasayfaImage.layer.borderColor = UIColor.red.cgColor
              anasayfaImage.layer.borderWidth = 1.0
              anasayfaImage.clipsToBounds = true
              
              menuTableView.register(UINib(nibName: sabitler.hücreNibAdi, bundle: nil), forCellReuseIdentifier: sabitler.dequeueReusableCell )
              menuTableView.delegate = self
              menuTableView.dataSource = self
              
              
              // Do any additional setup after loading the view.
          }
          func tableView(in tableView: UITableView) -> Int {
              return 1
              
          }
          func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
              return secenekler.count
          }
          
          
          func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
              let cell = tableView.dequeueReusableCell(withIdentifier: sabitler.dequeueReusableCell , for: indexPath) as! MenuCells
              cell.cellImage.image = UIImage(systemName:  ikon[indexPath.row])
              cell.cellLabel.text = secenekler[indexPath.row]
              return cell
             
          }
        
          func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
              if indexPath.row == 5 {
                  do{
                  try Auth.auth().signOut()
                      self.performSegue(withIdentifier: segues[indexPath.row], sender: self)
                      
                  }catch{
                  print("Error while signing out!")
              }
                  
              }else{
                  performSegue(withIdentifier:segues[indexPath.row], sender: self)
              }
             
          }
    
}
    


