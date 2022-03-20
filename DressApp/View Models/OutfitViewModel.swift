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
    @Published var favouriteList : [Outfit] = []
    
    private var user = "\(String(describing:Auth.auth().currentUser!.email))"
    private var db = Firestore.firestore()
    
    
    
    func createOutfit (Clothing: [String],Event: String,Gender: String,Favourite: Bool,Season: String){
        db.collection("\(String(describing:Auth.auth().currentUser!.email))").addDocument(data: ["Object":"Outfit", "Outfit": Clothing,"Event": Event, "Gender":Gender, "Favourite":Favourite,"Season": Season, "userID": Auth.auth().currentUser!.uid])}
    
    
    
    func getOutfits(){
        self.autoDelete()
        db.collection(user).whereField("Object", isEqualTo: "Outfit")
            .addSnapshotListener{ (querySnapshot, error) in
                
                guard let documents = querySnapshot?.documents else {
                    print("No Outfits")
                    return
                }
                DispatchQueue.main.async {
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
    }
    
    
    func autoDelete(){
        
        db.collection(user).whereField("Object", isEqualTo: "Outfit").whereField("Clothing", isEqualTo: []).getDocuments(){ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                DispatchQueue.main.async {
                    for document in querySnapshot!.documents {
                        document.reference.delete()
                    }
                }}
        }}
    
    
    
    func getFavourite(){
        
        db.collection(user).whereField("Object", isEqualTo: "Outfit").whereField("Favourite", isEqualTo: true)
            .addSnapshotListener{ (querySnapshot, error) in
                
                guard let documents = querySnapshot?.documents else {
                    print("No Outfits")
                    return
                }
                DispatchQueue.main.async {
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
    }
    
    
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
    
    
    
    func generateOutfit(Weather: String,minTemp: String, maxTemp: String, gender: String, Event: String, Clothings: [Clothing], Outifits: [Outfit]){
        
                var weather: String
                switch Weather{
                case "Clear":
                    weather = "Sunny"
                case "Clouds":
                    weather = "Cloudy"
                case "Rain":
                    weather = "Rainy"
                case "Snow":
                    weather = "Snow"
                case "Drizzle":
                    weather = "Rainy"
                case "Thunderstorm":
                    weather = "Rainy"
                default:
                    weather = ""
                }
        
                let weatherList = Clothings.filter{$0.Weather.contains(weather)}
                let genderList = weatherList.filter{$0.Gender.contains(gender)} + weatherList.filter{$0.Gender.contains("Unisex")}
                let eventList = genderList.filter{$0.Event.contains(Event)}
        
        
        
        var EventOutfitsDictionary = Dictionary<String,[[Dictionary<String,String>]]>()
        var outFitDetail = Dictionary<String,[String]>()
        //variable to store key
        var kk = ""
        
        
        // for each outfit in the outfits
        for outfit in Outifits{
            //Dictioa
            outFitDetail = [outfit.Event:outfit.Clothing]
            
            // new dictionary to store the clothin detail of each clothing item
            var g = [Dictionary<String,String>]()
            var f = [[Dictionary<String,String>]]()

            for (key,value) in outFitDetail {
                kk = key
                // for each clothing item in the clothings
                //if there are more than one outfit in the event
                for cloths in value{
                    for i in Clothings.filter({$0.id.contains("\(cloths)")}){
                        //Get the clothing detail and append it in the outfit
                        g.append([i.Item:i.Colour])
                        
                    }
                }
                f.append(g)
            }
            
            if EventOutfitsDictionary[kk] != nil{
                EventOutfitsDictionary[kk]?.append(contentsOf: f)
            }
            else{
                EventOutfitsDictionary[kk] = f
            }

        }
        
        print(EventOutfitsDictionary)
        
        
        
        
    }
    
    
    
}
