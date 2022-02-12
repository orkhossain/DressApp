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
    
    var body: some View {
                VStack{
                    Form {
                        Section(header: Text("Short paragraph about the item")){
                            TextField("Description", text: $Description)
                                .frame(maxHeight: 40)
                        }
                        
                        Section(header: Text("INFORMATION")){
                            
                            
                            Picker("Item",selection: $Item) {
                                Group
                                {
                                    ForEach(symbols, id: \.self) { clothing in
                                        Text("\(clothing)").tag("\(clothing)")}
                                }
                            }
                            
                            Picker("Gender",selection: $Gender){
                                Text("Male").tag("Male")
                                Text("Female").tag("Female")
                            }
                            
                            Picker("Color",selection: $Colour) {
                                Group{
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
                                }
                                Group{
                                    Text("Rainbow").tag("Rainbow")
                                    
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
                }.navigationBarTitle("Add new")
            }
        }




