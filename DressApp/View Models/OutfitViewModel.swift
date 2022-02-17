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
import FirebaseFirestore



class OutfitViewModel: ObservableObject {
    
    @Published var list : [Outfit] = []
    //    @Published var ClothingList : [Outfit] = []
    @Published var favouriteList : [Outfit] = []
    
    
    private var user = "\(String(describing:Auth.auth().currentUser!.email))"
    private var db = Firestore.firestore()
    
    
    
    
    func createOutfit (Clothing: [String],Event: String,Gender: String,Favourite: Bool,Season: String)
    {
        db.collection("\(String(describing:Auth.auth().currentUser!.email))").addDocument(data: ["Object":"Outfit", "Outfit": Clothing,"Event": Event, "Gender":Gender, "Favourite":Favourite,"Season": Season, "userID": Auth.auth().currentUser!.uid])
        
    }
    
    
    
    func getOutfits(){
        db.collection(user).whereField("Object", isEqualTo: "Outfit")
            .addSnapshotListener{ (querySnapshot, error) in
                
                guard let documents = querySnapshot?.documents else {
                    print("No Outfits")
                    return
                }
                
                self.list = documents.map { (QueryDocumentSnapshot) -> Outfit in
                    
                    let data = QueryDocumentSnapshot.data()
                    let id = QueryDocumentSnapshot.documentID
                    
                    let Clothing = data["Outfit"] as? [String] ?? []
                    let Event = data["Event"] as? String ?? ""
                    let Gender = data["Gender"] as? String ?? ""
                    let Season = data["Season"] as? String ?? ""
                    let Favourite = data["Favourite"] as? Bool ?? false
                    
                    let Outfit = Outfit(id: id, Clothing: Clothing, Event: Event, Gender: Gender, Season: Season, Favourite: Favourite)
                    return Outfit
                }
                
            }
    }
    
    
    
    func getSpecificOutfit(Outfit: String, completion: @escaping (
        Clothing?)->()) {
        db.collection(user).document(Outfit).getDocument { (document, error) in
            if let document = document, document.exists {
                
                let data = document.data()
                let Description = data?["Description"] as? String ?? ""
                let Item = data?["Item"] as? String ?? ""
                let Object = data?["Object"] as? String ?? ""
                let Colour = data?["Colour"] as? String ?? ""
                let Event = data?["Event"] as? String ?? ""
                let Weather = data?["Weather"] as? String ?? ""
                let Gender = data?["Gender"] as? String ?? ""
                let Season = data?["Season"] as? String ?? ""
                let Favourite = data?["Favourite"] as? Bool ?? false

                completion(Clothing(id: Outfit, Object: Object, Description: Description, Item: Item, Colour: Colour, Event: Event, Weather: Weather, Gender: Gender, Season: Season, Favourite: Favourite))
            }
            else {
                print("Document does not exist")
            }
            
        }

        

        
        
        
        
    }
    
    
    
    func getFavourite(){
        db.collection(user).whereField("Object", isEqualTo: "Outfit").whereField("Favourite", isEqualTo: true)
            .addSnapshotListener{ (querySnapshot, error) in
                
                guard let documents = querySnapshot?.documents else {
                    print("No Outfits")
                    return
                }
                
                self.favouriteList = documents.map { (QueryDocumentSnapshot) -> Outfit in
                    
                    let data = QueryDocumentSnapshot.data()
                    let id = QueryDocumentSnapshot.documentID
                    
                    let Clothing = data["Outfit"] as? [String] ?? []
                    let Event = data["Event"] as? String ?? ""
                    let Gender = data["Gender"] as? String ?? ""
                    let Season = data["Season"] as? String ?? ""
                    let Favourite = data["Favourite"] as? Bool ?? false
                    
                    let Outfit = Outfit(id: id, Clothing: Clothing, Event: Event, Gender: Gender, Season: Season, Favourite: Favourite)
                    return Outfit
                }
                
            }
    }
    //
    //
    func setFavourite(Outfit: Outfit){
        
        if(Outfit.Favourite == false) {
            db.collection(user).document(Outfit.id).setData(["Favourite": true],merge: true)
            { error in
                if error == nil {
                    self.getFavourite()
                }
            }
        }
        else
        {
            db.collection(user).document(Outfit.id).setData(["Favourite": false],merge: true)
            { error in
                if error == nil {
                    self.getFavourite()
                }
            }
            
            
        }
        
    }
    
    func deleteData(OutfitToDelete: Outfit){
        db.collection(user).document(OutfitToDelete.id).delete { error in
            
            if error == nil {
                self.list.removeAll() { Outfit in
                    return OutfitToDelete.id == Outfit.id
                }
            }
        }
        
    }
    
}



