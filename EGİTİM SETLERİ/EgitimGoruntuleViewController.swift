//
//  EgitimGoruntuleViewController.swift
//  Egitim
//
//  Created by Aleyna on 25.04.2022.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage

class EgitimGoruntuleViewController: UIViewController{
    
    @IBOutlet weak var showTableView: UITableView!
    @IBOutlet weak var addFile: UIBarButtonItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    var storage = Storage.storage()
    var storageRef = Storage.storage().reference()
    var Dokumanlar : [Dokumanlar] = []
    let uid = Auth.auth().currentUser?.uid
    var id: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // self.showTableView.delegate = self
        //self.showTableView.dataSource = self
        //self.showTableView.register(UINib(nibName: kullaniciCell.kHücreAdi, bundle: nil), forCellReuseIdentifier:kullaniciCell.kHücreNibAdi)

       
    }
  
    @IBAction func addFile(_ sender: Any) {
        self.performSegue(withIdentifier: sabitler.showToFolder, sender: self)
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.performSegue(withIdentifier: sabitler.showUnwind, sender: self)
    }
    @IBAction func fileUnwind (_ seg: UIStoryboardSegue) {
        
    }


}
