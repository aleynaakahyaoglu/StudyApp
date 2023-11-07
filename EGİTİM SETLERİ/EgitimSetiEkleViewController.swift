//
//  EgitimSetiEkleViewController.swift
//  Egitim
//
//  Created by Aleyna on 25.04.2022.
//

import SwiftUI
import UIKit
import Firebase
import FirebaseDatabase
import FirebaseStorage
import UniformTypeIdentifiers
import MobileCoreServices

class EgitimSetiEkleViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource, DocumentDelegate{


    var documentPicker: DocumentPicker!
        
        var documents = [Document]()
        
        var fileURL: URL?
    
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var assignPickerView: UIPickerView!
    @IBOutlet weak var addAssignButton: UIButton!
    
    let dataBaseRef = Database.database().reference()
    let uid = Auth.auth().currentUser?.uid
    var id: String = ""
    var HizmetlerZ : [Hizmetler]?
    var Hizmetler : [String] = []
    var docURLArray : [String] = []
    var pickedHizmet : String = ""
    var pickedRow : Int?
     
    override func viewDidLoad() {
        super.viewDidLoad()
        
        documentPicker = DocumentPicker(presentationController: self, delegate: self)

        assignPickerView.delegate = self
        assignPickerView.dataSource = self
        

        loadHizmetler()
        
        assignPickerView.layer.cornerRadius = assignPickerView.frame.size.height / 5
        addAssignButton.layer.cornerRadius = addAssignButton.frame.size.height / 5
        
     
    }
    
    
    func didPickDocuments(documents: [Document]?) {
        print("DID PICK DOCUMENTS")
            documents?.forEach {
                self.documents.append($0)
            }
        }
    func keepDocURL(documentURL: URL?) {
        fileURL = documentURL!
    }
    
    func didPickDocument(document: Document?) {
            print("THE FILE URL ISSSSSSSS",  document!.fileURL)
            if let pickedDoc = document {
                fileURL = pickedDoc.fileURL
                print("THE FILE URL ISSSSSSSS", fileURL)
             
                let alert = UIAlertController(title: "", message: "Seçilen dosyayı kaydetmek istiyor musunuz?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Evet", style: .default, handler: { action in
                    self.uploadToCloud(fileURL:self.fileURL!)
                }))
                alert.addAction(UIAlertAction(title: "Hayır", style: .default, handler: { action in
               
                }))
                self.present(alert, animated: true, completion: nil)
                
                //let data = try Data(contentsOf: fileURL)
                /// do what you want with the file URL
            }
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return Hizmetler.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
         return Hizmetler[row]
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        pickedHizmet = Hizmetler[row]
        pickedRow = row
    }

    @IBAction func addAssignButton(_ sender: Any) {
       
        print("segue in")
  
        documentPicker.present(from: view)
        callAlert(title:"MESAJ" , message: "İŞLEM GERÇEKLEŞTİRİLDİ." ,anstitle: "TAMAM")
        
        //self.performSegue(withIdentifier:sabitler.trainingUnwind, sender: self)
        print("segue out")
        
    
    }
    func callAlert (title:String , message: String ,anstitle: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: anstitle, style: .default, handler: { action in
       
        }))
        self.present(alert, animated: true, completion: nil)
       
    }

    func loadHizmetler(){
        
        Database.database().reference().child("Hizmetler").observe(.value) {
            (snapshot) in
            
            var h: Hizmetler
     
        for ks in snapshot.children{
            let deger = (ks as! DataSnapshot).value as? NSDictionary
            print(deger)
            h = Egitim.Hizmetler()
            let hizmetAdi = deger!["name"] as? String
            let hizmetID = deger! ["documents"] as? [HizmetlerDocuments]
            self.HizmetlerZ?.append(h)
            self.Hizmetler.append(hizmetAdi!)
            
        }
            self.assignPickerView.reloadAllComponents()
        }
             
    }
 

    @IBAction func arrowButton(_ sender: Any) {
        print("segue giriş")
        self.performSegue(withIdentifier:sabitler.trainingUnwind, sender: self)
        
    }
    func uploadToCloud(fileURL: URL) {
        let bucket = Storage.storage().reference()
        let hizmetAdı = pickedHizmet
        let videoRef = bucket.child(hizmetAdı).child(fileURL.deletingPathExtension().lastPathComponent)
                
                let metadata = StorageMetadata()
                
                var data : Data = Data()
                
                do
                {
                    data = try Data(contentsOf: fileURL)
                }
                catch
                {
                    print(error.localizedDescription)
                    return
                }
                
        videoRef.putData(data, metadata: nil, completion: {
                    _, error in
                    guard error == nil else{
                        print("Failed to upload")
                        return
                    }
                    
            Storage.storage().reference().child(hizmetAdı).child(fileURL.deletingPathExtension().lastPathComponent).downloadURL(completion: { [self]
                        url, error in
                        guard let url = url, error == nil else{
                            return
                        }
               
                print(HizmetlerZ![pickedRow!])
                print(HizmetlerZ![pickedRow!].documents?[(HizmetlerZ![pickedRow!].documents?.count)! - 1]   )
                
                
                var urlString = url.absoluteString
                
                let hizmetID = (((HizmetlerZ![pickedRow!].documents?[(HizmetlerZ![pickedRow!].documents?.count)! - 1]?.docID)!) + 1)
                
                                                                  
                var k = DocIds()
                k.docID = hizmetID
                k.url = urlString
                k.type = ""
                k.docName = (fileURL.deletingPathExtension().lastPathComponent)
                
                
                let d = [
              
                    "docID" : k.docID,
                    "url" : k.url,
                    "docName" : k.docName,
                    "type" : k.type
                ] as [String : Any]
                
                                         print(urlString)
               
                        self.docURLArray.append(urlString)
                                        let dataBaseRef = Database.database().reference()
                dataBaseRef.child("Hizmetler").child("\(HizmetlerZ![HizmetlerZ!.count - 1].id! + 1 )").child("documents").child("\(hizmetID)").setValue(self.docURLArray)
                      
                        
                    })
            
                })
   
    }
    @IBAction func kaydetButton(_ sender: Any) {
  
        if fileURL == nil {
            callAlert(title:"UYARI" , message: "Bir dosya seçiniz" ,anstitle: "TAMAM")
            
        }
        else{
            print("THE FILE URL ISSSSSSSS",  self.fileURL!)
             
                let alert = UIAlertController(title: "", message: "Seçilen dosyayı kaydetmek istiyor musunuz?", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Evet", style: .default, handler: { action in
                    self.uploadToCloud(fileURL: self.fileURL!)
                }))
                alert.addAction(UIAlertAction(title: "Hayır", style: .default, handler: { action in
               
                }))
                self.present(alert, animated: true, completion: nil)
                
            
        }
    }
    
 

}

    




