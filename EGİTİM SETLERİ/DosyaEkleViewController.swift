//
//  DosyaEkleViewController.swift
//  Egitim
//
//  Created by Aleyna on 25.04.2022.
//

import UIKit
import SwiftUI
import Photos
import Firebase
import FirebaseStorage
import MobileCoreServices
import SwiftUI

class DosyaEkleViewController: UIViewController,  UINavigationControllerDelegate, UIImagePickerControllerDelegate{ //DocumentDelegate {
   // func didPickDocuments(documents: [Document]?) {
       
    //}
    
 
    
  
// UIDocumentPickerViewController,  {
   
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var addFileButton: UIButton!
    
    @IBOutlet weak var addPhotosButton: UIButton!
    
    var documentPicker : DocumentPicker!
    var documents = [Document]()
    
    var imagePickerController = UIImagePickerController()
   // var documentPickerController = UIDocumentPickerViewController ()
    var url = ""
    
    var storage = Storage.storage()
    var storageRef = Storage.storage().reference()
    
    //var imagesRef = storageRef.child("Gorseller")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // documentPicker = DocumentPicker(presentationController:self , delegate:self)
        //documentPickerController.delegate = self
        imagePickerController.delegate = self
        
        checkPermissions()
        
       addFileButton.layer.cornerRadius = addFileButton.frame.size.height / 5
        addFileButton.layer.borderColor = UIColor.red.cgColor
        addFileButton.layer.borderWidth = 1.0
        addFileButton.clipsToBounds = true
        addPhotosButton.layer.cornerRadius = addPhotosButton.frame.size.height / 5
        addPhotosButton.layer.borderColor = UIColor.red.cgColor
        addPhotosButton.layer.borderWidth = 1.0
        addPhotosButton.clipsToBounds = true
        
   
        
       
        // Do any additional setup after loading the view.
    }
  
    @IBAction func addPhotosButton(_ sender: Any) {
        
        
        documentPicker.present(from: view)
        
        //self.documentPickerController.sourceType = .files
        //self.present(self.documentPickerController, animated: true, completion: nil)
      
    }
    
    @IBAction func backButton(_ sender: Any) {
        self.performSegue(withIdentifier: sabitler.fileUnwind, sender: self)
    }
    
    @IBAction func addFileButton(_ sender: Any) {
        
        
        self.imagePickerController.sourceType = .photoLibrary
        self.present(self.imagePickerController, animated: true, completion: nil)
        
    }
    
    func checkPermissions () {
        if PHPhotoLibrary.authorizationStatus() != PHAuthorizationStatus.authorized {
            PHPhotoLibrary.requestAuthorization({ (status:PHAuthorizationStatus) ->Void in
                ()
            })
        }
        if PHPhotoLibrary.authorizationStatus() == PHAuthorizationStatus.authorized {
            
        }else{
            PHPhotoLibrary.requestAuthorization(requestAuthorizationHandler)
        }
 

    }
    func requestAuthorizationHandler (status:PHAuthorizationStatus) {
        if PHPhotoLibrary.authorizationStatus () == PHAuthorizationStatus.authorized{
            print("photo falnnnn")
        }else {
            print("else photo")
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let url = info[UIImagePickerController.InfoKey.imageURL]as? URL{
        print(url)
        uploadToCloud(fileURL:url)
    }
    imagePickerController.dismiss(animated:true, completion:nil)
    
}
func uploadToCloud (fileURL: URL) {
    let storage = Storage.storage()
    
    let data = Data()
    
    let StorageRef  = storage.reference()
    
    let localeFule = fileURL
    
    let photoRef = StorageRef.child("UploadPhotoOne")
    
    let uploadTask = photoRef.putFile(from: localeFule, metadata: nil) { (metadata, err) in
        guard let metadata = metadata else {
            print (err?.localizedDescription)
            return
        }
        print ("Photo Upload")
    
    }
    
}

}




 
