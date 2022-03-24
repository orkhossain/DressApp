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


class ClothviewModel: ObservableObject {
    
    @Published var list : [Clothing] = []
    @Published var categoryList : [Clothing] = []
    @Published var favouriteList : [Clothing] = []
    @ObservedObject var OutfitModel = OutfitViewModel()
    
    private var user = "\(String(describing:Auth.auth().currentUser!.email))"
    private var db = Firestore.firestore()
    private var userID = Auth.auth().currentUser!.uid
    
    
    
    
    
    func addItem
    (Description: String,Object: String, Item: String,Colour: String,Weather: String,Event: String,Gender: String,Favourite: Bool,Season: String, ImagePath: String)
    {
        
        db.collection("\(String(describing:Auth.auth().currentUser!.email))").addDocument(data: ["Description":Description,"Object": "Clothing", "Item":Item,"Colour": Colour, "Weather":Weather,"Event": Event, "Gender":Gender, "Favourite":Favourite,"Season": Season, "userID": userID, "ImagePath": ImagePath])

        
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
                    
                    //                    return try? QueryDocumentSnapshot.data(as: Clothing.self)
                    
                    
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
    
    
    
    
    //    func generateOutfit(Weather: String,minTemp: String, maxTemp: String, gender: String, Event: String){
    //        self.getClothing()
    //
    //        var weather: String
    //        switch Weather{
    //        case "Clear":
    //            weather = "Sunny"
    //        case "Clouds":
    //            weather = "Cloudy"
    //        case "Rain":
    //            weather = "Rainy"
    //        case "Snow":
    //            weather = "Snow"
    //        case "Drizzle":
    //            weather = "Rainy"
    //        case "Thunderstorm":
    //            weather = "Rainy"
    //        default:
    //            weather = ""
    //        }
    //
    //        let weatherList = self.list.filter{$0.Weather.contains(weather)}
    //        let genderList = weatherList.filter{$0.Gender.contains(gender)} + weatherList.filter{$0.Gender.contains("Unisex")}
    //        let eventList = genderList.filter{$0.Event.contains(Event)}
    //
    //        let allClothingMatches = self.list.
    //        var ColourCombination = [["Black","Black","Black"],
    //                                         ["Red","Black","Brown"],
    //                                         ["Gray","Blue","White"]]
    //
    //
    //        let Casual = [
    //            ["Hoodie","Jeans","Sneakers"],["Shirt","Jeans","Sneakers"],
    //            ["Shirt","Trousers","Sneakers"],["Sweater","T-Shirt","Trousers","Sneakers"],
    //            ["Shirt","Chino","Sneakers"],
    //            ["T-Shirt","Jeans","Chelsea Boots"],["T-Shirt","Trousers","Sneakers"],
    //            ["Shirt","Jeans","Worker-Boots"],
    //            ["T-Shirt","Cargo","Sneakers"],
    //            ["Hoodie","Cargo","Sneakers"],
    //            ["Vest","T-Shirt","Cargo","Sneakers"]
    //        ]
    //
    //        let Formal = [
    //            ["Shirt","Trousers","Sneakers"],
    //            ["Shirt","Trousers","Sneakers"],
    //            ["Shirt","Trousers","Sneakers"],
    //            ["Sweater","Shirt","Trousers","Sneakers"],
    //            ["Sweater","Shirt","Chino","Sneakers"],["Sweater","T-Shirt","Jeans","Chelsea Boots"],
    //            ["Sweater","T-Shirt","Chino","Chelsea Boots"],["Shirt","Jeans","Chelsea Boots"],
    //        ]
    //
    //        let Date = [[""]]
    //        let Party = [[""]]
    
    //        var list: [[String]]
    //        switch Event{
    //        case "Casual":
    //            list = Casual
    //        case "Formal":
    //            list = Formal
    //        case "Date":
    //            list = Date
    //        case "Party":
    //            list = Party
    //        default:
    //            list = [[]]
    //        }
    
    //        let flatList = Array(Set(list.flatMap{$0}))
    //        var listofOutfits = [[String]]()
    
    
    //                for i in list{
    //                    for clothing in eventList {
    //                        var newOutfit = [String]()
    //                        if i.contains(clothing.Item){
    //                            if !newOutfit.contains(clothing.id){
    //                                newOutfit.append(clothing.id)
    //                                print (newOutfit)
    //                            }
    //                        }
    //                            listofOutfits.append(newOutfit)
    //                }
    //
    //
    //
    //        }
    
    //    }
    
}



