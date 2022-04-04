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
                        print("updated")
                    }}}}
        else
        {db.collection(user).document(Outfit.id).setData(["Favourite": false],merge: true){
            error in
            DispatchQueue.main.async{
                if error == nil {
                    print("updated")

                }}}}}
    
    
    func deleteData(OutfitToDelete: Outfit){
        db.collection(user).document(OutfitToDelete.id).delete { error in
            DispatchQueue.main.async {
                if error == nil {
                    self.list.removeAll() { Outfit in
                        return OutfitToDelete.id == Outfit.id}}}}}
    
    
    
    
    
    func generateOutfit(Weather: String, Gender: String, Event: String, Clothings: [Clothing], Outifits: [Outfit])-> [Outfit]{
  
  
        let list = customList(Weather: Weather, Gender: Gender, Event: Event, Clothings: Clothings)
        
        let combinationList = generateCombination(Clothings: Clothings, Outifits: Outifits)
        
        var outfitsToPickFrom = [Dictionary<String,String>]()
        
        if Event != ""{
            outfitsToPickFrom = (combinationList[Event] ?? []) as [Dictionary<String,String>]
        }else{
            let arr = Array(combinationList.values)
            
            for i in arr{
                for j in i{
                outfitsToPickFrom.append(j)
                }
            }
            
        }
        
        
        let pairs = createPairs(clothingList: outfitsToPickFrom)

        let count = count(listOfPair: pairs)
        
        let pairCombination = combinePairs(pair: count)
        
        let newDict = newOutfitDict(outfit: pairCombination)

        let newOutfits = Set(newDict.keys).symmetricDifference(Set(outfitsToPickFrom))
        
        let sortedPossOutfits = sortPossNewOutfit(newOutfits: newOutfits, newDict: newDict)
        
        var mostFavourite = [[String:String]]()
        
        if sortedPossOutfits.count > 9{
             mostFavourite = Array(sortedPossOutfits.prefix(9))}
        else{
            mostFavourite = sortedPossOutfits
        }
        
        let outfits = generateNewOutfits(mostFavourite: mostFavourite, clothingList: list)
        
        let Season = getSeason()

        var listOfOutfits = [Outfit]()
        for i in outfits{
            let outfit = Outfit(id: UUID().uuidString, Clothing: i, Event: Event, Gender: Gender, Season: Season, Favourite: false)
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
                    let j = i.sorted(by: { $0.0 < $1.0 })
                    let pair = Dictionary(uniqueKeysWithValues: j.map({ ($0.key, $0.value) }))
                    pairDict.append(pair)}}
        return pairDict
    }
    
    
    
    func count(listOfPair: [[String:String]]) -> [[String:String]: Int] {
        
        let pairList = listOfPair.reduce(into: [:]) { counts, number in counts[number, default: 0] += 1}

        return pairList
    }
    
    func sortAndReturnDict(dict: [String:String]) ->  [String:String]{
        let sorted = dict.sorted(by: { $0.0 < $1.0 })
        let sortedDict = Dictionary(uniqueKeysWithValues: sorted.map({ ($0.key, $0.value) }))
        return sortedDict
    }
    
    func combinePairs(pair: [[String:String]: Int]) -> [[[String:String]:Int]] {
        
        var combinationDict = [[[String:String]:Int]]()

        let combinationsArray = pair.combinations(length: 2, repeatingElements: false)
 
        for i in combinationsArray{
            combinationDict.append(Dictionary(uniqueKeysWithValues: i.map({ ($0.key, $0.value) })))
        }
        
        return combinationDict
    }
    
    
    func newOutfitDict(outfit: [[[String:String]:Int]]) -> [[String:String]:Int] {
        var newDict = [[String:String]:Int]()
        let top = Set(Wardrobe().Top)
        let bottom = Set(Wardrobe().Bottom)
        let outerlayer = Set(Wardrobe().Outerlayer)
        let shoes = Set(Wardrobe().Shoes)
        let accessories = Set(Wardrobe().Accessories)
        
        for i in outfit{
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
        return newDict
        
    }

    
    func sortPossNewOutfit(newOutfits: Set<Dictionary<String, String>>, newDict: [[String:String]:Int] ) -> [[String:String]] {
        var weightedOutfits =  [[String:String]:Int]()
        for i in newOutfits{
            weightedOutfits[i] = newDict[i]
        }
        let orderdOutfits = weightedOutfits.keysSortedByValue(isOrderedBefore: >)
        
        return orderdOutfits
        
    }

    
    
    func generateNewOutfits(mostFavourite: [[String:String]],clothingList: [Clothing]) -> [[String:String]]{
        
        var outfits = [[String:String]]()
        
        for i in mostFavourite{
            
            var ids = [String:String]()
            
            for (key,value) in i{
            let itemFilter = clothingList.filter{$0.Item.contains(key)}
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
        return outfits
    }
    
    func customList(Weather: String, Gender: String, Event: String, Clothings: [Clothing]) -> [Clothing]{
        var newWeather = Weather
        
        if !["Sunny","Cloudy","Rainy","Snow"].contains(Weather){
        switch Weather{
        case "Clear":
            newWeather = "Sunny"
        case "Clouds":
            newWeather = "Cloudy"
        case "Rain":
            newWeather = "Rainy"
        case "Snow":
            newWeather = "Snow"
        case "Drizzle":
            newWeather = "Rainy"
        case "Thunderstorm":
            newWeather = "Rainy"
        default:
            newWeather = ""
        }
        }
        
        var list = [Clothing]()
        
        
        
        if newWeather != "" && Gender != "" && Event != "" {

            let l1 = Clothings.filter{$0.Weather.contains(newWeather)}
            let l2 = l1.filter{$0.Gender.contains(Gender)}
            list = l2.filter{$0.Event.contains(Event)}

        }
        else if newWeather != "" && Gender != "" && Event == ""{

            let l1 = Clothings.filter{$0.Weather.contains(newWeather)}
            list = l1.filter{$0.Gender.contains(Gender)}
        }
        else if newWeather != "" && Gender == "" && Event != ""{
            let l1 = Clothings.filter{$0.Weather.contains(newWeather)}
            list =  l1.filter{$0.Event.contains(Event)}
        }
        else if newWeather != "" && Gender == "" && Event == ""{

            list = Clothings.filter{$0.Weather.contains(newWeather)}
        }
        else if newWeather == "" && Gender != "" && Event != ""{

            let l1 = Clothings.filter{$0.Gender.contains(Gender)}
            list = l1.filter{$0.Event.contains(Event)}

        }
        else if newWeather == "" && Gender != "" && Event == ""{

            list = Clothings.filter{$0.Gender.contains(Gender)}

        }
        else if newWeather == "" && Gender == "" && Event != ""{

            list =  Clothings.filter{$0.Event.contains(Event)}

        }
        else if  newWeather == "" && Gender == "" && Event == "" {
            list = Clothings
        }


        return list
        
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
