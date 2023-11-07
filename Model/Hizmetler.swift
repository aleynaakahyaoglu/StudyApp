//
//  Hizmetler.swift
//  Egitim
//
//  Created by Aleyna on 6.04.2022.
//

import Foundation


struct Hizmetler {
    
    var name : String?
    var id : Int?
    var documents :[IDs?]?

}
struct  HizmetlerDocuments{
    var docID: [IDs]
    
}
struct IDs{
    var docID: Int
    var docName: String?
    var type: String?
    var url: String?
}
struct cell{
   
    static let hücreAdi = "HizmetlerCell"
    static let hücreNibAdi = "satir"

}



