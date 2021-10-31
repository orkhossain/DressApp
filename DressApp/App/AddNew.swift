//
//  Wardrobe.swift
//  DressApp
//
//  Created by Ork Hossain Muntaqin on 30/06/2021.
//

import SwiftUI
import FirebaseFirestoreSwift
import FirebaseFirestore
import Firebase
import GoogleSignIn

let db = Firestore.firestore()


struct AddNew: View {
    @State var ID = UUID().uuidString
    @State var Description:String = ""
    @State var Item:String = ""
    @State var Colour:String = ""
    @State var Event:Int = 0
    @State var Weather:Int = 0
    @State var Gender:Int = 0
    @State var Season:Int = 0
    @State var Favuorite:Bool = false
    @State var userID = Auth.auth().currentUser!.uid
    
    
    
    
    var body: some View {
        
        
        VStack{
            
            Form {
                Section(header: Text("Short paragraph about the item")){
                    TextField("Description", text: $Description)}
                
                
                
                Section(header: Text("INFORMATION")){
                    Picker("Gender",selection: $Gender){
                        Text("Male").tag(1)
                        Text("Female").tag(2)
                    }.cornerRadius(10)
                    
                    Picker("Color",selection: $Colour) {
                        Text("Black").tag("Black")
                        Text("White").tag("White")
                        Text("Red").tag("Red")
                        Text("Gray").tag("Gray")
                        Text("Yellow").tag("Yellow")
                        Text("Green").tag("Green")
                        Text("Blue").tag("Blue")
                        Text("Orange").tag("Orange")
                        Text("Purple").tag("Purple")
                        Text("Pink").tag("Pink")
                    }.cornerRadius(10)
                    
                    Picker("Item",selection: $Item) {
                        Text("Shirt").tag("Shirt")
                        Text("T-Shirt").tag("T-Shirt")
                        Text("Polo").tag("Polo")
                        Text("Trousers").tag("Trousers")
                        Text("Jacket").tag("Jacket")
                        Text("Jumper").tag("Jumper")
                        Text("Hoodie").tag("Hoodie")
                        Text("Coat").tag("Coat")
                        Text("Cardigan").tag("Cardigan")
                        Text("Jeans").tag("Jeans")
                    }.cornerRadius(10)
                    
                    Picker("Event",selection: $Event) {
                        Text("Casual").tag(1)
                        Text("Formal").tag(2)
                        Text("Party").tag(3)
                        Text("Date").tag(4)
                    }.cornerRadius(10)
                    
                    Picker("Weather",selection: $Weather) {
                        Text("Sunny").tag(1)
                        Text("Cloudy").tag(2)
                        Text("Rainy").tag(3)
                    }.cornerRadius(10)
                    
                    Picker("Season",selection: $Weather) {
                        Text("Spring").tag(1)
                        Text("Summer").tag(2)
                        Text("Autumn").tag(3)
                        Text("Winter").tag(4)
                    }.cornerRadius(10)
                    
                    
                }
                
                
                
                
                Button(action: {
                    addItem(ID: self.ID ,Description: self.Description, Item: self.Item, Colour: self.Colour, Weather: self.Weather,Event: self.Event, Gender: self.Gender, Favourite: false ,Season: self.Season, userID: Auth.auth().currentUser!.uid)
                }, label: {
                    Text("Add Item")
                })
                .disabled(Item.isEmpty || Colour.isEmpty || Weather == 0 || Event == 0 || Gender == 0 || Season == 0)
                
                
            }.cornerRadius(10).padding(.top, 20)
            
        }
    }
    
}

func addItem(ID: String, Description: String,Item: String,Colour: String,Weather: Int,Event: Int,Gender: Int,Favourite: Bool,Season: Int, userID: String){
    db.collection("\(String(describing: Auth.auth().currentUser!.displayName ?? Auth.auth().currentUser!.email))").document("\(Item)").setData(["ID":ID, "Description":Description, "Item":Item,"Colour": Colour, "Weather":Weather,"Event": Event, "Gender":Gender, "Favourite":Favourite,"Season": Season, "userID":userID])
    print(Text("Item added"))
}


