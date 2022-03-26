//
//  ViewModel.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 09/11/2021.
//

import Firebase
import FirebaseFirestore
import IteratorTools
import CloudKit


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
    
    
    
    func generateOutfit(Weather: String,minTemp: String, maxTemp: String, gender: String, Event: String, Clothings: [Clothing], Outifits: [Outfit])-> [Outfit]{
        
        let top = Set(Wardrobe().Top)
        let bottom = Set(Wardrobe().Bottom)
        let outerlayer = Set(Wardrobe().Outerlayer)
        let shoes = Set(Wardrobe().Shoes)
        let accessories = Set(Wardrobe().Accessories)
        
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
        
        let a = combinationList[Event]! as [Dictionary<String,String>]
        
        
        let b = createPairs(clothingList: a)
        
        let c = groupByandCount(listOfPair: b)
        
        let d = c.combinations(length: 2, repeatingElements: false)
        
        var e = [[[String:String]:Int]]()
        
        for i in d{
            e.append(Dictionary(uniqueKeysWithValues: i.map({ ($0.key, $0.value) })))
        }
        
        var newDict = [[String:String]:Int]()

        for i in e{
            let dicts = Array(i.keys)
            let values = Array(i.values)
            var dict1 = dicts[0]
            let dict2 = dicts[1]
            dict1.merge(dict2) {(current,_) in current}
           
            let sum = values.reduce(0, +)
            let set = Set(dict1.keys)
            
            if (top.intersection(set).count < 3 && top.intersection(set).count > 0 && bottom.intersection(set).count < 2 && bottom.intersection(set).count > 0 &&
                outerlayer.intersection(set).count < 3 && accessories.intersection(set).count < 4 &&
                shoes.intersection(set).count > 0  && shoes.intersection(set).count < 2){
                
                let sortedDict = sortAndReturnDict(dict: dict1)
                newDict[sortedDict] = sum
                
            }
            
        }
        

        let newOutfits = Set(newDict.keys).symmetricDifference(Set(a))
        
        var weightedOutfits =  [[String:String]:Int]()
        for i in newOutfits{
            weightedOutfits[i] = newDict[i]
        }
        
        let orderdOutfits = weightedOutfits.keysSortedByValue(isOrderedBefore: >)
        
        var mostFavourite = [[String:String]]()
        
        if orderdOutfits.count > 9{
             mostFavourite = Array(orderdOutfits.prefix(9))}
        else{
            mostFavourite = orderdOutfits
        }
        
        
        var outfits = [[String:String]]()
        
        for i in mostFavourite{
            
            var ids = [String:String]()
            
            for (key,value) in i{
            let itemFilter = list.filter{$0.Item.contains(key)}
                for i in itemFilter.filter({$0.Colour.contains(value)}){
                    if i.Image != ""{
                        ids[i.id] = i.Image
                    }
                    
                }
  
            }
            if ids.count > 2{
            outfits.append(ids)
            }
        }
        print(outfits)

        
        var listOfOutfits = [Outfit]()
        for i in outfits{
            let outfit = Outfit(id: UUID().uuidString, Clothing: i, Event: Event, Gender: gender, Season: Season, Favourite: false)
            listOfOutfits.append(outfit)
        }
        
        return listOfOutfits
        
    }
    
    
    func generateCombination(Clothings: [Clothing], Outifits: [Outfit]) -> Dictionary<String,
        [Dictionary<String,String>]>{
        
        var EventOutfitsDictionary = Dictionary<String,[Dictionary<String,String>]>()
        
        for outfit in Outifits{
            let k = outfit.Event
            let outFitDetail = outfit.Clothing
            
            var outFitDetails = [Dictionary<String,String>]()
            var clothingDetails = Dictionary<String,String>()
            
            for (key,_) in outFitDetail {
                
                let clothList = Clothings.filter({$0.id.contains("\(key)")})
                for cloth in clothList {
                    clothingDetails[cloth.Item] = cloth.Colour
            }
            
                if !outFitDetails.contains(clothingDetails) && clothingDetails.count > 2{
                outFitDetails.append(clothingDetails)}
            
            if EventOutfitsDictionary[k] != nil{
                EventOutfitsDictionary[k]?.append(contentsOf: outFitDetails)
            }
            else{
                EventOutfitsDictionary[k] = outFitDetails
            }
        }
        
      
        
    }
            
            return EventOutfitsDictionary
    
}
    
    
    func createPairs(clothingList : [Dictionary<String,String>])-> [[String:String]]{
        
        var pairDict = [[String:String]]()
        for cloth in clothingList{
                let combination =  (cloth.combinations(length: 2, repeatingElements: false))
                for i in combination{
                    let pair = Dictionary(uniqueKeysWithValues: i.map({ ($0.key, $0.value) }))
                    pairDict.append(pair)}}
        return pairDict
    }
    
    
    
    func groupByandCount(listOfPair: [[String:String]]) -> [[String:String]: Int] {

        let pairList = listOfPair.reduce(into: [:]) { counts, number in counts[number, default: 0] += 1}
        
        let sorted = pairList.sorted { (a:(key: [String : String], value: Int), b:(key: [String : String], value: Int)) in
            a.value > b.value
        }
        
        let sortedDict = Dictionary(uniqueKeysWithValues: sorted.map({ ($0.key, $0.value) }))
        
        return sortedDict
    }
    
    func sortAndReturnDict(dict: [String:String]) ->  [String:String]{
        let sorted = dict.sorted(by: { $0.0 < $1.0 })
        let sortedDict = Dictionary(uniqueKeysWithValues: sorted.map({ ($0.key, $0.value) }))
        return sortedDict
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




extension Calendar {static let iso8601 = Calendar(identifier: .iso8601)}


extension Dictionary {
    func sortedKeys(isOrderedBefore:(Key,Key) -> Bool) -> [Key] {
        return Array(self.keys).sorted(by: isOrderedBefore)
    }
    
    func sortedKeysByValue(isOrderedBefore:(Value, Value) -> Bool) -> [Key] {
        return sortedKeys {
            isOrderedBefore(self[$0]!, self[$1]!)
        }
    }
    
    func keysSortedByValue(isOrderedBefore:(Value, Value) -> Bool) -> [Key] {
        return Array(self)
            .sorted() {
                let (_, lv) = $0
                let (_, rv) = $1
                return isOrderedBefore(lv, rv)
            }
            .map {
                let (k, _) = $0
                return k
            }
    }
}
