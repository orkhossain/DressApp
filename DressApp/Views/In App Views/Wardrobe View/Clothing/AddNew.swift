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
    
    @ObservedObject private var model = ClothviewModel()
    @State var Description:String = ""
    @State var Item:String = ""
    @State var Colour:String = ""
    @State var Event:String = ""
    @State var Weather:String = ""
    @State var Gender:String = ""
    @State var Season:String = ""
    @State var Favuorite:Bool = false
    
    var symbols = Wardrobe().symbols
    var top = Wardrobe().Top
    var bottom = Wardrobe().Bottom
    var outerlayer = Wardrobe().Outerlayer
    var shoes = Wardrobe().Shoes
    var accessories = Wardrobe().Accessories
    var colours = Wardrobe().colours
    
    var body: some View {
        
            NavigationView{Form {
                Section(header: Text("Short paragraph about the item")){
                    TextField("Description", text: $Description)
                        .frame(maxHeight: 40)
                }
                
                Section(header: Text("INFORMATION")){
                    
                    
                    Picker("Item",selection: $Item) {
                        let allItems = top + bottom + shoes + outerlayer + accessories
                        ForEach(allItems, id: \.self) { clothing in
                            Group
                            {
                                Text("\(clothing)").tag("\(clothing)")
                                
                            }
                        }
                    }
                    
                    Picker("Gender",selection: $Gender){
                        Text("Male").tag("Male")
                        Text("Female").tag("Female")
                        Text("Unisex").tag("Unisex")
                    }
                    
                    Picker("Color",selection: $Colour) {
                        ForEach(colours, id: \.self) { colour in
                            Group{
                                Text("\(colour)").tag("\(colour)")
                            }
                        }
                    }
                    
                    Picker("Event",selection: $Event) {
                        Text("Casual").tag("Casual")
                        Text("Formal").tag("Formal")
                        Text("Party").tag("Party")
                        Text("Date").tag("Date")
                    }
                    
                    Picker("Weather",selection: $Weather) {
                        Text("Sunny").tag("Sunny")
                        Text("Cloudy").tag("Cloudy")
                        Text("Rainy").tag("Rainy")
                        Text("Snow").tag("Snow")
                    }
                    
                    Picker("Season",selection: $Season) {
                        Text("Spring").tag("Spring")
                        Text("Summer").tag("Summer")
                        Text("Autumn").tag("Autumn")
                        Text("Winter").tag("Winter")
                    }
                    
                    
                }
                
                
                Button(action: {
                    model.addItem(Description: self.Description, Object: "Clothing", Item: self.Item, Colour: self.Colour, Weather: self.Weather, Event: self.Event, Gender: self.Gender, Favourite: false ,Season: self.Season)
                    Description = ""
                    Item = ""
                    Colour = ""
                    Event = ""
                    Weather = ""
                    Gender = ""
                    Season = ""
                    Favuorite = false
                }, label: {
                    Text("Add Item")
                })
                    .disabled(Item.isEmpty || Colour.isEmpty || Weather.isEmpty || Event.isEmpty || Gender.isEmpty || Season.isEmpty)
            }
            .navigationBarTitle("Add new")
            }
    }
}




