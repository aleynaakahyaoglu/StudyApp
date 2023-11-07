//
//  AtamaBekleyenlerController.swift
//  Egitim
//
//  Created by Aleyna on 19.04.2022.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


class AtamaBekleyenlerViewController : UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    func tryPress(_ tag: Int) {
        //id = ModelWaiting![tag].id!
        //print(ModelKullanici![tag].id)
        

       print("edit press in")
    }

    
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var assignPageButton: UIBarButtonItem!
    @IBOutlet weak var assignTableView: UITableView!
    
    
    
    var Kullanici : [Kullanici]?
    var ModelWaiting : [ModelWaiting]?
    
    let uid = Auth.auth().currentUser?.uid
    var id: String = ""
    var dataBaseRef = Database.database().reference()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        load()
        
        self.assignTableView.register(UINib(nibName: waitingCell.wcellName, bundle: nil), forCellReuseIdentifier: waitingCell.wcellNibName)
        self.assignTableView.delegate = self
        self.assignTableView.dataSource = self
        
        menuButton.target = self.revealViewController()
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.revealViewController().rearViewRevealWidth = 280
        
        
       
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Kullanici?.count != nil {
            print("girdi")
            return Kullanici!.count
        }
        else{
            print("efeef")
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("tabloya giriş yapıldı.")
        
        let waitingCell = assignTableView.dequeueReusableCell(withIdentifier: waitingCell.wcellNibName , for: indexPath) as! WaitingCell
        print("in")
        
        waitingCell.emailLabel.text =  Kullanici?[indexPath.row].email
        waitingCell.sirketLabel.text = Kullanici?[indexPath.row].sirket
        
   if Kullanici?.count != nil {
    }
    return waitingCell
    }
    
    
    func load(){
        
        print("load1")
        Database.database().reference().child("Kullanici").observe(.value) {
            (snapshot) in
            print("load2")
            
            var k: Kullanici
        if self.Kullanici == nil{
            self.Kullanici = []
        }else{
            self.Kullanici?.removeAll()
        }
     
        for ks in snapshot.children{
            let deger = (ks as! DataSnapshot).value as? NSDictionary
            print(deger)
            k = Egitim.Kullanici()
            k.sirket = deger! ["sirket"] as? String
            k.email = deger! ["email"] as? String
            k.hizmet = deger! ["hizmet"] as? String
          
         
            if k.hizmet == "" {
                self.Kullanici?.append(k)
                
            }
       
            print("self.ModelAssign")
     
      
        }
            self.assignTableView.reloadData()

    }
 
    }

       @IBAction func assignPageButton(_ sender: Any) {
        performSegue(withIdentifier: "assigPageSegue", sender: self)
    
}
    @IBAction func assignToback( _ seg: UIStoryboardSegue)
    {
}
    @IBAction func assignBackUnwind( _ seg : UIStoryboardSegue){
        
    }
    @IBAction func waitUnwind(_ seg: UIStoryboardSegue){
        
    }

}
