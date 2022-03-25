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
import IteratorTools


class OutfitViewModel: ObservableObject {
    
    @Published var list : [Outfit] = []
    @Published var favouriteList : [Outfit] = []
    
    private var user = "\(String(describing:Auth.auth().currentUser!.email))"
    private var db = Firestore.firestore()
    
    
    
    func createOutfit (Clothing: [String:String],Event: String,Gender: String,Favourite: Bool,Season: String){
        db.collection("\(String(describing:Auth.auth().currentUser!.email))").addDocument(data: ["Object":"Outfit", "Outfit": Clothing,"Event": Event, "Gender":Gender, "Favourite":Favourite,"Season": Season, "userID": Auth.auth().currentUser!.uid])}
    
    
    
    func getOutfits(){
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
                        
                        let Clothing = data["Outfit"] as? [String:String] ?? [:]
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
                        
                        let Clothing = data["Outfit"] as? [String:String] ?? [:]
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
                DispatchQueue.main.async{
                    if error == nil {
                        self.getFavourite()}}}}
        else
        {db.collection(user).document(Outfit.id).setData(["Favourite": false],merge: true){
                error in
                DispatchQueue.main.async{
                    if error == nil {
                        self.getFavourite()
                    }}}}}
    
    
    func deleteData(OutfitToDelete: Outfit){
        db.collection(user).document(OutfitToDelete.id).delete { error in
            DispatchQueue.main.async {
                if error == nil {
                    self.list.removeAll() { Outfit in
                        return OutfitToDelete.id == Outfit.id}}}}}
    
    
    
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
    
    
    let Season = getSeason()
    
    let weatherList = Clothings.filter{$0.Weather.contains(weather)}
    var genderList = [Clothing]()
    if gender == "Unisex"{
        genderList =  weatherList.filter{$0.Gender.contains("Unisex")}
        
    }
    else{
        genderList = weatherList.filter{$0.Gender.contains(gender)} + weatherList.filter{$0.Gender.contains("Unisex")}
    }
    
    
    let list = genderList.filter{$0.Event.contains(Event)}
    
    

    let combinationList = generateCombination(Clothings: Clothings, Outifits: Outifits)
    
    let a = combinationList[Event]! as [[Dictionary<String,String>]]
    
    var e = [[[[String:String]]]]()
    for i in a{
        if (i.count > 2){
            let b =  (i.combinations(length: 2, repeatingElements: false))
            e.append(b)
        }
        if(i.count <= 2){
            e.append([i])}
    }
    
    let c = Array(e.joined()) as [[[String:String]]]

    var j = [[[String:String]]]()
    
    for i in c {
        let ii: [Dictionary<String,String>] = i
        let jj =  (ii.sorted(by: {itemsSort(p1: $0, p2: $1)})) as [Dictionary<String,String>]
        j.append(jj)
    }

    let d = j.reduce(into: [:]) { counts, number in
       counts[number, default: 0] += 1

    }
    
    let dd = d.sorted { (a: ([[String : String]], Int), b:([[String : String]], Int) ) in
        a.1 < b.1
    }
    
    var newDict =  [[[String:String]]: Int]()
    for i in dd{
        newDict[i.key] = i.value
    }
    print(newDict)

    
}
    
func generateCombination(Clothings: [Clothing], Outifits: [Outfit]) -> Dictionary<String,[[Dictionary<String,String>]]>{
    
    var EventOutfitsDictionary = Dictionary<String,[[Dictionary<String,String>]]>()

    for outfit in Outifits{
        let k = outfit.Event
        let outFitDetail = outfit.Clothing

        var outFitDetails = [[Dictionary<String,String>]]()
        var clothingDetails = [Dictionary<String,String>]()

        for (key,_) in outFitDetail {

                let clothList = Clothings.filter({$0.id.contains("\(key)")})
                for cloth in clothList {
                    clothingDetails.append([cloth.Item:cloth.Colour])}
            }
        
        if !outFitDetails.contains(clothingDetails){
            outFitDetails.append(clothingDetails)}

        if EventOutfitsDictionary[k] != nil{
            EventOutfitsDictionary[k]?.append(contentsOf: outFitDetails)
        }
        else{
            EventOutfitsDictionary[k] = outFitDetails
        }
    }
    
    return EventOutfitsDictionary
    
}
    
    
    
func itemsSort(p1:[String:Any], p2:[String:Any]) -> Bool {
        guard let s1 = p1["itemName"] as? String, let s2 = p2["itemName"] as? String else {
            return false
        }
        return s1 < s2
    }





func getSeason() -> String {
    
    let now = Date()
    let day  = Calendar.iso8601.ordinality(of: .day, in: .year, for: now)!
    var Season : String
    
    switch day {
       case 80..<172:
        Season = "Spring"
       case 172...264:
        Season = "Summer"
        case 265...355:
        Season = "Autumn"
    default:
        Season = "Winter"
    }
    
    return String(Season)
    
}

}

extension Calendar {
    static let iso8601 = Calendar(identifier: .iso8601)
}
