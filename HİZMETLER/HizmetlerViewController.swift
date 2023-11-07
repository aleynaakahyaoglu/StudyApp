//
//  HizmetlerViewController.swift
//  Egitim
//
//  Created by Aleyna on 15.03.2022.
//

import UIKit
import FirebaseDatabase

protocol EditButtonActionDelegate: AnyObject{
    func press(_ tag: Int)
    func deletePress (_ tag : Int)
}
class HizmetlerViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource, EditButtonActionDelegate  {
   
 
    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet weak var hTableView: UITableView!
    @IBOutlet weak var ekleButton: UIButton!
    @IBOutlet weak var EkleTextfield: UITextField!
    @IBOutlet weak var AddButton: UIBarButtonItem!
    @IBOutlet weak var Stack: UIStackView!
    
    var IID: Int?
    var docURL : [String] = []
    
    
    var HizmetListesi : [Hizmetler]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hTableView.register(UINib(nibName: cell.hücreAdi, bundle: nil), forCellReuseIdentifier:cell.hücreNibAdi )
        self.hTableView.delegate = self
        self.hTableView.dataSource = self
      
            
        self.load()
        
        menuButton.target = self.revealViewController()
        menuButton.action = #selector(SWRevealViewController.revealToggle(_:))
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.revealViewController().rearViewRevealWidth = 280
    }
    
    
    @IBAction func ekleButton(_ sender: UIButton) {
        if EkleTextfield.text != "" {
            
            self.HizmetKaydet ()
            self.load()
            hTableView.reloadData()
        }else{
            callAlert()
            
        }
    
    }
    
    
    @IBAction func AddButton(_ sender: Any) {
        
        ekleButton.setTitle("Ekle", for: .normal)
        Stack.isHidden = false
        EkleTextfield.placeholder = ""
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if HizmetListesi?.count != nil {
            return HizmetListesi!.count
        }
        else{
            return 0
        }
}


    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //
    let cell = hTableView.dequeueReusableCell(withIdentifier: cell.hücreNibAdi , for: indexPath) as! HizmetlerCell
    
    cell.editButtonActionDelegate = self

    cell.editIcon.tag = indexPath.row
    cell.deleteIcon.tag = indexPath.row
    if HizmetListesi?.count != nil {
        cell.label.text = HizmetListesi![indexPath.row].name

    }
    return cell
    
}
    
    
  func HizmetKaydet ()
    {
     if ekleButton.currentTitle == "Ekle"{
        
      let h = Hizmetler()
         var childID = 0
         if HizmetListesi!.count != 0 {
             
            childID = HizmetListesi![HizmetListesi!.count-1].id!+1
            
             
         }else{
             childID = 1
             
         }

         let d = [
           "name" : EkleTextfield.text,
           "id" : childID ,
           "docURL" : []
         ] as [String : Any]
         
       
         var ref = Database.database().reference()
            ref.child("Hizmetler").child("\(childID)").setValue(d)
          Stack.isHidden = true
          EkleTextfield.text = ""
     }else{
        
            
          let h = Hizmetler()

          var d = [
            "name" : EkleTextfield.text,
            "id" : IID!
          
          ] as [String : Any]
          
        
          var ref = Database.database().reference()
             ref.child("Hizmetler").child("\(IID!)").setValue(d)
              EkleTextfield.text = ""
              Stack.isHidden = true

     }

  }
    
        func load(){
            
            Database.database().reference().child("Hizmetler").observe(.value) {
                (snapshot) in
                
                var h: Hizmetler
            if self.HizmetListesi == nil{
                self.HizmetListesi = []
            }else{
                self.HizmetListesi?.removeAll()
            }
         
            for ks in snapshot.children{
                let deger = (ks as! DataSnapshot).value as? NSDictionary
                print(deger)
                h = Hizmetler()
                h.name = deger!["name"] as? String
                h.id = deger! ["id"] as? Int
                h.documents = (deger! ["documents"] as? [IDs       ])!
                
                
              
                self.HizmetListesi?.append(h)
                
                print(self.HizmetListesi)
                self.hTableView.reloadData()
                
            }

        }
     
        }
    
    
    func press (_ tag :Int){
        
        
        
        
        EkleTextfield.text = ""
        EkleTextfield.placeholder = HizmetListesi![tag].name
        Stack.isHidden = false
        //ekleButton.isHidden = true
        ekleButton.setTitle("Kaydet", for: .normal)
       // EkleTextfield.isHidden = true
    
        
        IID = HizmetListesi![tag].id!
        print(IID)
        
   
    }
    
    
    func deletePress(_ tag: Int) {
        
        let id = HizmetListesi![tag].id!
        var ref = Database.database().reference()
        ref.child("Hizmetler").child("\(id)").setValue(nil)
        Stack.isHidden = true
        self.load()
        hTableView.reloadData()
        
    }
    
    
    func callAlert () {
        let alert = UIAlertController(title: "MESAJ", message: "BOŞ BIRAKILAMAZ", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "TAMAM", style: .default, handler: { action in
       
        }))
        self.present(alert, animated: true, completion: nil)
       
    }


    }
