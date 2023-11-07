//
//  AdminMainViewController.swift
//  Egitim
//
//  Created by Aleyna on 21.03.2022.
//

import UIKit
class AdminMainViewController:  UIViewController {
    

       @IBOutlet weak var menuButton: UIBarButtonItem!
    
       var tiklaButton: String = ""
   
       var secenekler = ["Anasayfa","Hizmetler","Kullanıcılar","Kullanıcı Hizmetleri", "Egitim Setleri", "Çıkış"]
       
       override func viewDidLoad() {
           
           super.viewDidLoad()
         
               menuButton.target = self.revealViewController()
                        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
                        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
                        self.revealViewController().rearViewRevealWidth = 280
           
          
           // Do any additional setup after loading the view.
       }

    
  @IBAction func hizmetlerAction(_ sender: Any) {
      tiklaButton = sabitler.ButtonTitle.hizmetler
      self.performSegue(withIdentifier: "mainToSideMenu", sender: self)
  }
  @IBAction func kullanicilarlerAction(_ sender: Any) {
      tiklaButton = sabitler.ButtonTitle.kullanicilar
      self.performSegue(withIdentifier: "mainToSideMenu", sender: self)
  }
  @IBAction func kullaniciHizmetleriAction(_ sender: Any) {
      tiklaButton = sabitler.ButtonTitle.kullaniciHizmetleri
      self.performSegue(withIdentifier: "mainToSideMenu", sender: self)
  }
  @IBAction func egitimSetleriAction(_ sender: Any) {
      tiklaButton = sabitler.ButtonTitle.egitimSetleri
      self.performSegue(withIdentifier: "mainToSideMenu", sender: self)
  }
    
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.destination is SideMenuViewController {
          let destination = segue.destination  as? SideMenuViewController
          print(tiklaButton)
          destination?.tiklaButton = tiklaButton
          print(destination?.tiklaButton)
          
      }
  
      
  }

    
}

      

          
        


