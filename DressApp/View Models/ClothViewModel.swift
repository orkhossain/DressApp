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
import SwiftUI


class ClothViewModel: ObservableObject {
    
    @Published var list : [Clothing] = []
    @Published var categoryList : [Clothing] = []
    @Published var favouriteList : [Clothing] = []
    @ObservedObject var OutfitModel = OutfitViewModel()
    
    private var user = "\(String(describing:Auth.auth().currentUser!.email))"
    private var db = Firestore.firestore()
    

    @State public var symbols = ["Top","Bottom","Shoes","Outerlayer","Accesories"]
    @State public var Top = ["T-shirt","Dress-Shirt","Flannel-Shirt","Shirt", "Sweater","Turtleneck","Hawaiian-Shirt","Polo","Blazer","Suit-Blazer","Waistcoat","Dress","Long-Dress","Hoodie","Tuxedo"]
    @State public var Bottom = ["Trousers","Jeans","Shorts","Cargo","Chino","Vest"]
    @State public var Outerlayer = ["Coat","Leather-Jacket","Parka","Puffer","Trenchcoat","Bomber-Jacket","Denim- Jacket","Overshirt","Cardigan"]
    @State public var Shoes = [ "Sneakers","Chelsea-Boots","Laced-Boots","Formal-Shoes"]
    @State public var Accessories = ["Belt","Tie","Cap","Scarf","Bow-Tie","Handbag"]
    @State public var colours = ["Black","White","Blue","Red","Sky Blue","Pink","Cachi","Golden","Mint","Mustard","Violet","Coral","Cream","Beige","Burgundy","Green","Brown","Orange","Purple","Gray"]
    
    
    
    
    
    func addItem
    (Description: String,Object: String, Item: String,Colour: String,Weather: String,Event: String,Gender: String,Favourite: Bool,Season: String, ImagePath: String)
    {
        
        db.collection("\(String(describing:Auth.auth().currentUser!.email))").addDocument(data: ["Description":Description,"Object": "Clothing", "Item":Item,"Colour": Colour, "Weather":Weather,"Event": Event, "Gender":Gender, "Favourite":Favourite,"Season": Season, "user": user, "ImagePath": ImagePath])

        
    }
    


    
    func getClothing(){
        db.collection(user).whereField("Object", isEqualTo: "Clothing")
            .addSnapshotListener{ (querySnapshot, error) in
                
                guard let documents = querySnapshot?.documents else {
                    print("No items")
                    return
                }
                
                DispatchQueue.main.async {
                
                self.list = documents.map { (QueryDocumentSnapshot) -> Clothing in
                                        
                    
                    let data = QueryDocumentSnapshot.data()
                    let id = QueryDocumentSnapshot.documentID
                    
                    let Description = data["Description"] as? String ?? ""
                    let Item = data["Item"] as? String ?? ""
                    let Object = data["Object"] as? String ?? ""
                    let Colour = data["Colour"] as? String ?? ""
                    let Event = data["Event"] as? String ?? ""
                    let Weather = data["Weather"] as? String ?? ""
                    let Gender = data["Gender"] as? String ?? ""
                    let Season = data["Season"] as? String ?? ""
                    let Favourite = data["Favourite"] as? Bool ?? false
                    let Image = data["ImagePath"] as? String ?? ""
                    
                    let Clothing = Clothing(id: id, Object: Object, Description: Description, Item: Item, Colour: Colour, Event: Event, Weather: Weather, Gender: Gender, Season: Season, Favourite: Favourite,Image: Image)
                    return Clothing
                    
                }
                }
            }
    }
    
    
    func getSpecificItem(Category: String){
        db.collection(user).whereField("Item", isEqualTo: Category)
            .addSnapshotListener{ (querySnapshot, error) in
                
                guard let documents = querySnapshot?.documents else {
                    print("No items")
                    return
                }
                
                self.categoryList = documents.map { (QueryDocumentSnapshot) -> Clothing in
                    
                    let data = QueryDocumentSnapshot.data()
                    let id = QueryDocumentSnapshot.documentID
                    
                    let Description = data["Description"] as? String ?? ""
                    let Item = data["Item"] as? String ?? ""
                    let Object = data["Object"] as? String ?? ""
                    let Colour = data["Colour"] as? String ?? ""
                    let Event = data["Event"] as? String ?? ""
                    let Weather = data["Weather"] as? String ?? ""
                    let Gender = data["Gender"] as? String ?? ""
                    let Season = data["Season"] as? String ?? ""
                    let Favourite = data["Favourite"] as? Bool ?? false
                    let Image = data["ImagePath"] as? String ?? ""
                    
                    let Clothing = Clothing(id: id, Object: Object, Description: Description, Item: Item, Colour: Colour, Event: Event, Weather: Weather, Gender: Gender, Season: Season, Favourite: Favourite, Image: Image)
                    
                    return Clothing

                }
                
            }
    }
    
    
    func getFavourite(){
        db.collection(user).whereField("Object", isEqualTo: "Clothing").whereField("Favourite", isEqualTo: true)
            .addSnapshotListener{ (querySnapshot, error) in
                
                guard let documents = querySnapshot?.documents else {
                    print("No items")
                    return
                }
                
                DispatchQueue.main.async {
                    self.favouriteList = documents.map { (QueryDocumentSnapshot) -> Clothing in
                        
                        let data = QueryDocumentSnapshot.data()
                        let id = QueryDocumentSnapshot.documentID
                        
                        let Description = data["Description"] as? String ?? ""
                        let Item = data["Item"] as? String ?? ""
                        let Object = data["Object"] as? String ?? ""
                        let Colour = data["Colour"] as? String ?? ""
                        let Event = data["Event"] as? String ?? ""
                        let Weather = data["Weather"] as? String ?? ""
                        let Gender = data["Gender"] as? String ?? ""
                        let Season = data["Season"] as? String ?? ""
                        let Favourite = data["Favourite"] as? Bool ?? false
                        let Image = data["ImagePath"] as? String ?? ""
                        
                        let Clothing = Clothing(id: id, Object: Object, Description: Description, Item: Item, Colour: Colour, Event: Event, Weather: Weather, Gender: Gender, Season: Season, Favourite: Favourite, Image: Image)
                        return Clothing
                    }
                }
            }
    }
    
    
    func setFavourite(item: Clothing){
        if(item.Favourite == false) {
            DispatchQueue.main.async {
                self.db.collection(self.user).document(item.id).setData(["Favourite": true],merge: true)
            { error in
                    if error == nil {
                        self.getFavourite()
                    }
                }
            }
        }
        else
        {DispatchQueue.main.async {
            self.db.collection(self.user).document(item.id).setData(["Favourite": false],merge: true)
            { error in
                    if error == nil {
                        self.getFavourite()
                    }
                }

            }
            
            
        }
        
    }
        

        
    
    func deleteData(clothingToDelete: Clothing){
        db.collection(user).document(clothingToDelete.id).delete { error in
            if error == nil {
                self.list.removeAll() { clothing in
                    return clothingToDelete.id == clothing.id
                }
            }
        }
        
        
        
    }
    
}



