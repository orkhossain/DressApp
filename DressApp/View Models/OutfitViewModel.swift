//
//  ViewModel.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 09/11/2021.
//

import Foundation
import Firebase
import CloudKit
import FirebaseFirestoreSwift


class OutfitViewModel: ObservableObject {
    
    @Published var list : [Outfit] = []
    @Published var categoryList : [Outfit] = []
    @Published var favouriteList : [Outfit] = []
    
    private var user = "\(String(describing:Auth.auth().currentUser!.email))"
    private var db = Firestore.firestore()
    
    
    
    
    func createOutfit
    (Description: String,Item: String,Event: String,Gender: String,Favourite: Bool,Season: String, userID: String)
    {
        db.collection("\(String(describing:Auth.auth().currentUser!.email))").addDocument(data: ["Description":Description, "Item":Item,"Event": Event, "Gender":Gender, "Favourite":Favourite,"Season": Season, "userID":userID])
        
    }
    

    
//    func getOutfit(){
//        db.collection(user)
//            .addSnapshotListener{ (querySnapshot, error) in
//                
//                guard let documents = querySnapshot?.documents else {
//                    print("No items")
//                    return
//                }
//                
//                self.list = documents.map { (QueryDocumentSnapshot) -> Outfits in
//                    
//                    let data = QueryDocumentSnapshot.data()
//                    let id = QueryDocumentSnapshot.documentID
//                    
//                    let Description = data["Description"] as? String ?? ""
//                    let Item = data["Item"] as? [Clothing] ?? nil
//                    let Event = data["Event"] as? String ?? ""
//                    let Gender = data["Gender"] as? String ?? ""
//                    let Season = data["Season"] as? String ?? ""
//                    let Favourite = data["Favourite"] as? Bool ?? false
//                    
//                    let Outfit = Outfit(id: id,Description: Description, Item: [Clothing], Event: Event, Gender: Gender, Season: Season, Favourite: Favourite)
//                    return Outfit
//                }
//                
//            }
//    }
//    
//    
//    func getSpecificItem(Category: String){
//        db.collection(user).whereField("Item", isEqualTo: Category)
//            .addSnapshotListener{ (querySnapshot, error) in
//                
//                guard let documents = querySnapshot?.documents else {
//                    print("No items")
//                    return
//                }
//                
//                self.categoryList = documents.map { (QueryDocumentSnapshot) -> Outfits in
//                    
//                    let data = QueryDocumentSnapshot.data()
//                    let id = QueryDocumentSnapshot.documentID
//                    
//                    let Description = data["Description"] as? String ?? ""
//                    let Item = data["Item"] as? [Clothing] ?? nil
//                    let Event = data["Event"] as? String ?? ""
//                    let Gender = data["Gender"] as? String ?? ""
//                    let Season = data["Season"] as? String ?? ""
//                    let Favourite = data["Favourite"] as? Bool ?? false
//                    
//                    let Outfit = Outfit(id: id,Description: Description, Item: [Clothing], Event: Event, Gender: Gender, Season: Season, Favourite: Favourite)
//                    return Outfit
//                }
//                
//            }
//    }
//    
//    
//    func getFavourite(){
//        db.collection(user).whereField("Favourite", isEqualTo: true)
//            .addSnapshotListener{ (querySnapshot, error) in
//                
//                guard let documents = querySnapshot?.documents else {
//                    print("No items")
//                    return
//                }
//                
//                self.favouriteList = documents.map { (QueryDocumentSnapshot) -> Outfits in
//                    
//                    let data = QueryDocumentSnapshot.data()
//                    let id = QueryDocumentSnapshot.documentID
//                    
//                    let Description = data["Description"] as? String ?? ""
//                    let Item = data["Item"] as? [Clothing] ?? nil
//                    let Event = data["Event"] as? String ?? ""
//                    let Gender = data["Gender"] as? String ?? ""
//                    let Season = data["Season"] as? String ?? ""
//                    let Favourite = data["Favourite"] as? Bool ?? false
//                    
//                    let Outfit = Outfit(id: id,Description: Description, Item: [Clothing], Event: Event, Gender: Gender, Season: Season, Favourite: Favourite)
//                    return Outfit
//                }
//                
//            }
//    }
//    
//    
//    func setFavourite(item: Outfit){
//        
//        if(item.Favourite == false) {
//            db.collection(user).document(item.id).setData(["Favourite": true],merge: true)
//            { error in
//                if error == nil {
//                    self.getFavourite()
//                }
//            }
//        }
//        else
//        {
//            db.collection(user).document(item.id).setData(["Favourite": false],merge: true)
//            { error in
//                if error == nil {
//                    self.getFavourite()
//                }
//            }
//            
//            
//        }
//        
//    }
    
//    func deleteData(OutfitToDelete: Outfit){
//        db.collection(user).document(OutfitToDelete.id).delete { error in
//
//            if error == nil {
//                self.list.removeAll() { Outfit in
//                    return OutfitToDelete.id == Outfits.id
//                }
//            }
//        }
//
//    }
    
}



